<%@ WebHandler Language="C#" Class="SaveReportIssue" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using ITM.Courses.DAO;
using ITM.Courses.LogManager;

public class SaveReportIssue : IHttpHandler, IRequiresSessionState
{
    Logger logger = new Logger();
    private JavaScriptSerializer jss = new JavaScriptSerializer();

    string cnxnString = string.Empty;
    string logPath = string.Empty;
    string configFilePath = string.Empty;
    string collegeName = string.Empty;

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            context.Response.AppendHeader("Access-Control-Allow-Origin", "*");
            context.Response.ContentType = "text/plain";
            int userId = 0;

            if (context.Session["ConnectionString"] == null)
            {
                UserLogins userLogin = new UserLoginsDAO().GetUserLoginByUserNamePassword("temp_user", "123", "");

                if (userLogin != null)
                {
                    UserDetails user = new UserDetailsDAO().GetUserByUserName(userLogin.UserName, userLogin.CnxnString, context.Server.MapPath(userLogin.LogFilePath));

                    if (user != null)
                    {
                        userId = user.Id;
                        cnxnString = userLogin.CnxnString;
                        logPath = userLogin.LogFilePath;
                        collegeName = userLogin.CollegeName;
                        configFilePath = context.Server.MapPath(userLogin.ReleaseFilePath);
                    }
                }
                else
                {
                    context.Response.Write(jss.Serialize(new { Status = "Error", Message = "Session Expire" }));
                    return;
                }
            }
            else
            {
                cnxnString = context.Session["ConnectionString"].ToString();
                logPath = context.Server.MapPath(context.Session["LogFilePath"].ToString());
                collegeName = context.Session["CollegeName"].ToString();
                configFilePath = context.Server.MapPath(context.Session["ReleaseFilePath"].ToString());
                userId = Convert.ToInt32(context.Session["UserId"].ToString());
            }

            if (string.IsNullOrEmpty(context.Request.QueryString["title"]) || string.IsNullOrEmpty(context.Request.QueryString["description"]) || string.IsNullOrEmpty(context.Request.QueryString["email"]) ||
                string.IsNullOrEmpty(context.Request.QueryString["expectedContent"]))
            {
                context.Response.Write(jss.Serialize(new { Status = "Error", Message = "Invalid data!" }));
                return;
            }

            string title = context.Request.QueryString["title"].ToString();
            string description = context.Request.QueryString["description"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string expectedContent = context.Request.QueryString["expectedContent"].ToString();
            int chapterId = Convert.ToInt32(context.Request.QueryString["chapterId"].ToString());
            int sectionId = Convert.ToInt32(context.Request.QueryString["sectionId"].ToString());

            ReportIssueDAO reportIssueDAO = new ReportIssueDAO();

            reportIssueDAO.AddReportIssue(userId, title, description, email, expectedContent, chapterId, sectionId, cnxnString, logPath);

            context.Response.Write(jss.Serialize(new { Status = "Ok", Message = "Success" }));

        }
        catch (Exception ex)
        {
            logger.Error("SaveReportIssue-Handler", "ProcessRequest", "Error occured while saving report issue", ex, logPath);
            context.Response.Write(jss.Serialize(new { Status = "Error", Message = ex.Message }));
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}