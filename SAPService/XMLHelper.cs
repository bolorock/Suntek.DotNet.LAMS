using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using System.IO;

namespace Longtek.HR.CMMS.Utility
{
    ///  <summary>
    ///  序列化与反序列化
    ///  FileName                        :        Serializer.cs      
    ///  Verion                          :              0.10
    ///  Author                          :              zhouyu   http://max.cszi.com
    ///  Update                        :              2007-10-22
    ///  Description            :              序列化与反序列化,主要用于将对象里的数据序列化成XML数据,用于存于文本或是数据库
    ///  Thanks                        :              小浩http://cs.alienwave.cn  )
    ///  </summary>
    public class XMLHelper
    {
        ///  <summary>
        ///  将文件反序列化成对象
        ///  使用:BlogSettingInfo  info  =    (BlogSettingInfo)  Serializer.XmlDeserializerFormFile(typeof(BlogSettingInfo),  @"H:\CSBlog\02.xml");
        ///  </summary>
        ///  <param  name="type">对象类型</param>
        ///  <param  name="path">文件路径</param>
        ///  <returns></returns>
        public static object XmlDeserializerFormFile(Type type, string path)
        {
            using (System.IO.StreamReader reader = new StreamReader(path))
            {
                return new XmlSerializer(type).Deserialize(reader);
            }

        }


        ///  <summary>
        ///  将字符串内容反序列化成对象
        ///  使用:BlogSettingInfo  info  =  (BlogSettingInfo)Serializer.XmlDeserializerFormText(typeof(BlogSettingInfo),config);
        ///  </summary>
        ///  <param  name="type">对象类型</param>
        ///  <param  name="serializeText">被序列化的文本</param>
        ///  <returns></returns>
        public static object XmlDeserializerFormXML(Type type, string serializeText)
        {
            using (StringReader reader = new StringReader(serializeText))
            {
                return new XmlSerializer(type).Deserialize(reader);
            }
        }


        ///  <summary>
        ///  将目标对象序列化成XML到文件中
        ///  </summary>
        ///  <param  name="target"></param>
        ///  <param  name="p_strPath"></param>
        public static void XmlSerializerToFile(object target, string p_strPath)
        {
           string m_strOrgXML = XmlSerializerToXml(target);
           System.Xml.XmlDocument m_xmlDoc = new XmlDocument();
           m_xmlDoc.LoadXml(m_strOrgXML);
           m_xmlDoc.Save(p_strPath);
        }


        ///  <summary>
        ///  将目标对象序列化成完整的XML文档
        ///  </summary>
        ///  <param  name="target"></param>
        ///  <returns></returns>
        public static string XmlSerializerToXml(object target)
        {
            XmlSerializer serializer = new XmlSerializer(target.GetType());
            MemoryStream stream = new MemoryStream();
            serializer.Serialize((Stream)stream, target);
            byte[] bytes = stream.ToArray();
            UTF8Encoding encoding = new UTF8Encoding();
          //  string str = encoding.GetString(bytes).Replace("<?xml version=\"1.0\"?>", "").Replace("xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"", "");
            string str = encoding.GetString(bytes);
       
            stream.Dispose();
            return str;

        }
       

    }



}
