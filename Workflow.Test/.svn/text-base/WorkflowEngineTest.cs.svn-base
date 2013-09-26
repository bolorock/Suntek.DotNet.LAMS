using EAFrame.Workflow.Engine;
using EAFrame.Workflow.Definition;
using EAFrame.Workflow.Domain;
using EAFrame.Workflow.Service;
using EAFrame.Workflow.Enums;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;

using EAFrame.Core.Authentication;

namespace Workflow.Test
{


    /// <summary>
    ///This is a test class for WorkflowEngineTest and is intended
    ///to contain all WorkflowEngineTest Unit Tests
    ///</summary>
    [TestClass()]
    public class WorkflowEngineTest
    {

        private IUser user = new User()
        {
            ID = "UR1500028529",
            LoginName = "shengp",
            Name = "沈国萍",
            Skin = "Default",
            OrgID = "OR1200001684",
            UserType = (short)EAFrame.Core.Enums.UserType.Administrator
        };
        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        // 
        //You can use the following additional attributes as you write your tests:
        //
        //Use ClassInitialize to run code before running the first test in the class
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //use testinitialize to run code before running each test
        [TestInitialize()]
        public void mytestinitialize()
        {
        }
        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///A test for CreateAProcess
        ///</summary>
        [TestMethod()]
        public void CreateAProcessTest()
        {
            WorkflowEngine target = new WorkflowEngine(); // TODO: Initialize to an appropriate value
            string processDefID = "3E00A7D1-A189-4DB4-8E6D-284A65B93695"; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = target.CreateAProcess(processDefID);
            Assert.AreEqual(expected, actual);

        }

        /// <summary>
        ///A test for StartAProcess
        ///</summary>
        [TestMethod()]
        public void StartAProcessTest()
        {
            WorkflowEngine target = new WorkflowEngine(); // TODO: Initialize to an appropriate value
            for (int i = 0; i < 10; i++)
            {
                string processInstID = target.CreateAProcess("f0e45a57-8739-487b-90d4-9e76013fd61d");// string.Empty; // TODO: Initialize to an appropriate value
                IDictionary<string, object> parameters = null; // TODO: Initialize to an appropriate value
                target.StartAProcess(processInstID, parameters);

                ProcessInst pi = target.GetProcessInst(processInstID);
                Assert.AreEqual(pi.CurrentState, (short)ProcessInstStatus.Running);
            }

            //IList<WorkItem> myWorkItems = target.GetMyWorkItems("UR1500028529", null).Where(w => w.CurrentState == (short)WorkItemStatus.WaitExecute).ToList();
            //while (myWorkItems != null && myWorkItems.Count > 0)
            //{
            //    WorkItem wi = myWorkItems.Where(w => w.CurrentState == (short)WorkItemStatus.WaitExecute).OrderByDescending(w => w.CreateTime).FirstOrDefault();
            //    Assert.IsNotNull(wi);
            //    Assert.AreEqual(wi.CurrentState, (short)WorkItemStatus.WaitExecute);
            //    target.CompleteWorkItem(user, wi.ID, parameters);

            //    WorkItem cwi = new WorkItemService().GetDomain(wi.ID);
            //    Assert.AreEqual(cwi.CurrentState, (short)WorkItemStatus.Compeleted);

            //    myWorkItems = target.GetMyWorkItems("UR1500028529", null).Where(w => w.CurrentState == (short)WorkItemStatus.WaitExecute).ToList();
            //}

            //WorkflowPersistence persistence = new WorkflowPersistence();
            //IList<ActivityInst> activityInsts = persistence.GetActivityInsts(processInstID);

            //foreach (var ai in activityInsts)
            //{
            //    Assert.AreEqual(ai.CurrentState, (short)ActivityInstStatus.Compeleted);
            //}

            //pi = persistence.GetProcessInst(processInstID);
            //Assert.AreEqual(pi.CurrentState, (short)ProcessInstStatus.Completed);
        }

        /// <summary>
        ///A test for StartAProcess
        ///</summary>
        [TestMethod()]
        public void StartAProcessTest1()
        {
            WorkflowEngine target = new WorkflowEngine(); // TODO: Initialize to an appropriate value
            string processInstID = target.CreateAProcess("f0e45a57-8739-487b-90d4-9e76013fd61d");// string.Empty; // TODO: Initialize to an appropriate value
            IDictionary<string, object> parameters = new Dictionary<string, object>(); // TODO: Initialize to an appropriate value
            //:PlanType=='Personal'||:RequireApprove=false
            parameters.Add("PlanType", "Department");// "Personal");
            parameters.Add("RequireApprove", true);
            parameters.Add("IsChangePlan", false);

            target.StartAProcess(processInstID, parameters);

            ProcessInst pi = target.GetProcessInst(processInstID);
            Assert.AreEqual(pi.CurrentState, (short)ProcessInstStatus.Running);

            IDictionary<string, object> parms = new Dictionary<string, object>();
            parms.Add("CurrentState", (short)WorkItemStatus.WaitExecute);
            IList<WorkItem> myWorkItems = target.GetMyWorkItems("UR1500028529", parms);

            foreach (var wi in myWorkItems)
            {
                Assert.IsNotNull(wi);
                Assert.AreEqual(wi.CurrentState, (short)WorkItemStatus.WaitExecute);

                target.CompleteWorkItem(user, wi.ID, parameters);

                WorkItem cwi = new WorkItemService().GetDomain(wi.ID);
                Assert.AreEqual(cwi.CurrentState, (short)WorkItemStatus.Compeleted);

                //  myWorkItems = target.GetMyWorkItems("UR1500028529", null).Where(w => w.CurrentState == (short)WorkItemStatus.WaitExecute).ToList();
            }

            //myWorkItems = target.GetMyWorkItems("UR1100032957").Where(w => w.CurrentState == (short)WorkItemStatus.WaitExecute).ToList();
            //while (myWorkItems != null && myWorkItems.Count > 0)
            //{
            //    WorkItem wi = myWorkItems.Where(w => w.CurrentState == (short)WorkItemStatus.WaitExecute).OrderByDescending(w => w.CreateTime).FirstOrDefault();
            //    Assert.IsNotNull(wi);
            //    Assert.AreEqual(wi.CurrentState, (short)WorkItemStatus.WaitExecute);


            //    target.CompleteWorkItem(wi.ID, parameters);

            //    WorkItem cwi = new WorkItemService().GetDomain(wi.ID);
            //    Assert.AreEqual(cwi.CurrentState, (short)WorkItemStatus.Compeleted);

            //    myWorkItems = target.GetMyWorkItems("UR1100032957").Where(w => w.CurrentState == (short)WorkItemStatus.WaitExecute).ToList();
            //}


            //WorkflowPersistence persistence = new WorkflowPersistence();
            //IList<ActivityInst> activityInsts = persistence.GetActivityInsts(processInstID);

            //foreach (var ai in activityInsts)
            //{
            //    Assert.AreEqual(ai.CurrentState, (short)ActivityInstStatus.Compeleted);
            //}

            //pi = persistence.GetProcessInst(processInstID);
            //Assert.AreEqual(pi.CurrentState, (short)ProcessInstStatus.Completed);
        }

        /// <summary>
        ///A test for CompleteWorkItem
        ///</summary>
        [TestMethod()]
        public void CompleteWorkItemTest()
        {
            WorkflowEngine target = new WorkflowEngine(); // TODO: Initialize to an appropriate value
            string workItemID = string.Empty; // TODO: Initialize to an appropriate value
            target.CompleteWorkItem(user, workItemID, null);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for CreateAProcess
        ///</summary>
        [TestMethod()]
        public void CreateAProcessTest1()
        {
            WorkflowEngine target = new WorkflowEngine(); // TODO: Initialize to an appropriate value
            string processDefID = string.Empty; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = target.CreateAProcess(processDefID);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for StartAProcess
        ///</summary>
        [TestMethod()]
        public void StartAProcessTest2()
        {
            WorkflowEngine target = new WorkflowEngine(); // TODO: Initialize to an appropriate value
            string processInstID = string.Empty; // TODO: Initialize to an appropriate value
            IDictionary<string, object> parameters = null; // TODO: Initialize to an appropriate value
            target.StartAProcess(processInstID, parameters);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for StartAProcess
        ///</summary>
        [TestMethod()]
        public void StartAProcessTest3()
        {
            WorkflowEngine target = new WorkflowEngine(); // TODO: Initialize to an appropriate value
            string processInstID = string.Empty; // TODO: Initialize to an appropriate value
            target.StartAProcess(processInstID);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }
    }
}
