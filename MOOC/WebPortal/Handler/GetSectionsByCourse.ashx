<%@ WebHandler Language="C#" Class="GetSectionsByCourse" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using ITM.Courses.DAO;
using ITM.Courses.LogManager;
using System.Configuration;

public class GetSectionsByCourse : IHttpHandler, IRequiresSessionState
{
    Logger logger = new Logger();
    private JavaScriptSerializer jss = new JavaScriptSerializer();

    string cnxnString = string.Empty;
    string logPath = string.Empty;
    string configFilePath = string.Empty;

    public void ProcessRequest(HttpContext context)
    {
        List<ChapterSection> sections = new List<ChapterSection>();
        try
        {
            context.Response.AppendHeader("Access-Control-Allow-Origin", "*");
            context.Response.ContentType = "text/plain";

            if (context.Session["ConnectionString"] == null)
            {
                cnxnString = ConfigurationManager.ConnectionStrings["Annonymus_CnxnString"].ToString();
                logPath = ConfigurationManager.AppSettings["Annonymus_LogPath"].ToString();
            }
            else
            {
                cnxnString = context.Session["ConnectionString"].ToString();
                logPath = context.Server.MapPath(context.Session["LogFilePath"].ToString());
                configFilePath = context.Server.MapPath(context.Session["ReleaseFilePath"].ToString());
            }
            
            //if (string.IsNullOrEmpty(context.Session["UserName"].ToString()) || string.IsNullOrEmpty(context.Request.QueryString["courseid"]))
            if (string.IsNullOrEmpty(context.Request.QueryString["courseid"]))
            {
                context.Response.Write(jss.Serialize(new { Status = "Error", Message = "Invalid data UserId shall not be empty!", Sections = sections }));
                return;
            }

            //int userId = Convert.ToInt32(context.Session["UserId"].ToString());
            int courseId = Convert.ToInt32(context.Request.QueryString["courseid"]);

            ChapterSectionDAO finalQuizDAO = new ChapterSectionDAO();
            sections = finalQuizDAO.GetAllSectionsByCourse(courseId, cnxnString, logPath);

            context.Response.Write(jss.Serialize(new { Status = "Ok", Message = "GetSectionsByCourse-Success", Sections = sections }));

        }
        catch (Exception ex)
        {
            logger.Error("GetSectionsByCourse-Handler", "ProcessRequest", "Error occured while getting Sections", ex, logPath);
            context.Response.Write(jss.Serialize(new { Status = "Error", Message = ex.Message, Sections = sections }));
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