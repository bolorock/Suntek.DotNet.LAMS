using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;
using SunTek.EAFrame.Core;
using SunTek.EAFrame.Core.Enums;
using SunTek.EAFrame.Core.Web;
using SunTek.EAFrame.Core.Utility;
using SunTek.EAFrame.Core.Extensions;


namespace WebSite
{
    public partial class ResourceEdit : BasePage
    {
        /// <summary>
        /// 页面初始化
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string id = Request.QueryString["id"];

                if (!string.IsNullOrEmpty(id))
                {

                    ResourceService sResource = new ResourceService();
                    //Dictionary<string, object> parCurrent = new Dictionary<string, object>();
                    //parCurrent.Add("ID", id);
                    //IList<Resource> liCurrent = sResource.FindAll(parCurrent);

                    Resource resource = sResource.GetDomain(id);

                    txtCurrentName.Text = resource.Name;
                    txtCurrentDescription.Text = resource.Description;
                    hdfCurrentId.Value = id;
                    hdfParentId.Value = resource.ParentID;
                    txtSortOrder.Text = resource.SortOrder.ToString();
                    txtValue.Text = resource.URL;
                    txtIcon.Text = resource.Icon;
                    rblType.SelectedValue = resource.Type.ToSafeString();

                    if (string.IsNullOrEmpty(resource.ParentID))
                    {
                        txtParentName.Text = "/";
                        txtParentName.Enabled = false;
                    }
                    else
                    {
                        Dictionary<string, object> parParent = new Dictionary<string, object>();
                        parParent.Add("ID", hdfParentId.Value);
                        List<Resource> liParent = sResource.GetList(parParent);
                        txtParentName.Text = sResource.GetDomain(resource.ParentID).Name;
                    }
                }

                lResourceStatus.Text = string.Format("该资源包含{0}个子级资源。", GetResourceStatus(id)[0]);
            }

        }

        /// <summary>
        /// 提交修改
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            ResourceService sResource = new ResourceService();
            Resource inResource = sResource.GetDomain(hdfCurrentId.Value);
            string oldName = inResource.Name;
            string oldOrder = inResource.SortOrder.ToString();

            bool isChangeName = !oldName.Equals(txtCurrentName.Text.Trim());

            bool isChangeOrder = !oldOrder.Equals(txtSortOrder.Text.Trim());

            inResource.Text = txtCurrentName.Text.Trim();
            inResource.Description = txtCurrentDescription.Text.Trim();
            inResource.SortOrder = Convert.ToInt16(txtSortOrder.Text);
            inResource.URL = txtValue.Text.Trim();
            inResource.Icon = txtIcon.Text.Trim();
            inResource.Type = (short)rblType.SelectedValue.Cast<ResourceType>();

            try
            {
                //判断是否有修改资源排序
                if (!isChangeOrder)
                {
                    //更新当前资源信息
                    sResource.Update(inResource);

                    //当前资源没有修改序号

                    //判断是否有修改资源名称
                    if (isChangeName)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "reNewAjaxTreeNode", "<script>reNewAjaxTreeNode('" + inResource.ID + "', '" + inResource.Name + "');"
                                                                                               + "</script>");
                    }
                }
                else
                {
                    //当前资源修改序号

                    //更新同级资源序号
                    ResourceService ssResource = new ResourceService();
                    int numMax = ssResource.All().Where(o => o.ParentID != null && o.ParentID.Equals(hdfParentId.Value, StringComparison.OrdinalIgnoreCase)).Count();
                    int numMin = 1;


                    int newNum = Convert.ToInt16(txtSortOrder.Text.Trim());

                    //循环修改所有资源排序
                    if (newNum >= numMin && newNum <= numMax)
                    {
                        IList<Resource> li = ssResource.All().Where(o => o.SortOrder >= newNum).ToList();

                        for (int i = 0; i < li.Count; i++)
                        {
                            if (li[i].ID != inResource.ID)
                            {
                                Resource newResource = ssResource.GetDomain(li[i].ID);
                                newResource.SortOrder += 1;
                                ssResource.Update(newResource);
                            }
                        }
                    }

                    //更新当前资源信息
                    sResource.Update(inResource);


                    WebUtil.PromptMsg("修改成功");
                    ClientScript.RegisterStartupScript(this.GetType(), "reNewAjaxTreeNode", "<script>window.parent.location.href='ResourceManage.aspx';"
                        + "</script>");

                }

            }
            catch (Exception ex)
            {
                log.Error(string.Format("把资源id={0},名称修改为{1}时出错！", inResource.ID, inResource.Name), ex);
                WebUtil.PromptMsg("修改出错，请检查格式是否正确！");
            }
        }


        /// <summary>
        /// 获取当前文件夹信息
        /// </summary>
        /// <param name="folderId"></param>
        /// <returns></returns>
        public ArrayList GetResourceStatus(string folderId)
        {
            ArrayList al = new ArrayList();

            ResourceService sResource = new ResourceService();


            if (!string.IsNullOrEmpty(folderId))
            {
                Dictionary<string, object> parResource = new Dictionary<string, object>();
                parResource.Add("ParentID", folderId);
                List<Resource> liResource = sResource.GetList(parResource);


                al.Add(liResource.Count);

            }
            else
            {
                IList<Resource> liResource = sResource.All();

                al.Add(liResource.Count);

            }

            return al;
        }

        /// <summary>
        /// 删除资源
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string folderId = hdfCurrentId.Value;
            string folderName = txtCurrentName.Text;
            ResourceService sResource = new ResourceService();
            try
            {
                sResource.Delete(hdfCurrentId.Value);
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }
            ClientScript.RegisterStartupScript(this.GetType(), "reMoveAjaxTreeNode", "<script>reMoveAjaxTreeNode('" + folderId + "', '" + folderName + "');"
                + "window.location.href='ResourceEdit.aspx';"
                + "</script>");

        }
    }
}
