using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ITM.Courses.DAO;
using ITM.Courses.DAOBase;
using ITM.Courses.ConfigurationsManager;
using ITM.Courses.LogManager;
using ITM.Courses.Utilities;
using System.Configuration;
using System.Web.Script.Serialization;

public partial class Staff_ManageChapters : PageBase
{
    //string cnxnString = string.Empty;
    //string logPath = string.Empty;
    Logger logger = new Logger();
    string logPath;
    string cnxnString;
    string configPath;
    int staffId;

    const int FIRST_ELEMENT = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        errorSummary.Visible = false;
        Success.Visible = false;
        
        if (Session["ConnectionString"] == null)
        {
            Response.Redirect("../Login.aspx", false);
            return;
        }
        else
        {
            cnxnString = Session["ConnectionString"].ToString();
            logPath = Server.MapPath(Session["LogFilePath"].ToString());
            configPath = Server.MapPath(Session["ReleaseFilePath"].ToString());
            staffId = Convert.ToInt32(Session["UserId"]);
        }

        if (!IsPostBack)
        {
            PopulateCourse();

        }
    }

    #region Populate Dropdowns
    private void PopulateCourse()
    {
        try
        {
            CourseDetailsDAO Course = new CourseDetailsDAO();
            ddlCourseId.DataSource = Course.GetAllCoursesByStaff(int.Parse(Session["UserId"].ToString()),cnxnString, logPath);
            ddlCourseId.DataTextField = "CourseName";
            ddlCourseId.DataValueField = "Id";
            ddlCourseId.DataBind();
            ddlCourseId.Items.Add(new System.Web.UI.WebControls.ListItem("--Select Course--", "0", true));
            ddlCourseId.SelectedValue = "0";
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

    //protected void gvChapterDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName == "EditDetails")
    //    {
    //        //View.Visible = false;
    //        //btnCancel.Visible = false;
    //        //Edit.Visible = true;
    //        //Success.Visible = false;
    //        //getChapterDetail(Convert.ToInt32(e.CommandArgument));
    //        //hfChapterId.Value = e.CommandArgument.ToString();
    //    }
    //}

    protected void gvChapterDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvChapterDetails.PageIndex = e.NewPageIndex;
        bindGridView();
    }
    protected void ddlCourseId_SelectedIndexChanged(object sender, EventArgs e)
    {
        AddChapter.Visible = true; 
        bindGridView();
    }
    private void bindGridView()
    {
        try
        {
            ChapterDetailsDAO chapters = new ChapterDetailsDAO();
            List<ChapterDetails> chapterList = new List<ChapterDetails>();
            chapterList = chapters.GetAllChaptersByCourse(Int32.Parse(ddlCourseId.SelectedValue), cnxnString, logPath);
            gvChapterDetails.DataSource = chapterList;
            gvChapterDetails.DataBind();
            gvChapterDetails.Visible = true;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnAddUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            ChapterDetailsDAO objDao = new ChapterDetailsDAO();

            if (hfIsEdit.Value == "false")
            {
                objDao.AddChapters(int.Parse(ddlCourseId.SelectedValue), "en", "1", "show-db-section-contents.htm", txtNewChapterName.Text.Trim(), DateTime.Now, "show-db-section-contents.htm", 600, true, cnxnString, logPath);
            }
            else if (hfIsEdit.Value == "true")
            {
                objDao.Update_ChaptersTitle(int.Parse(hfSelectedChapterId.Value), txtNewChapterName.Text.Trim(), cnxnString, logPath);
            }

            bindGridView();
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    
    }

    protected void gvChapterDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            int chapterId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "DeleteDetails")
            {
                new ChapterDetailsDAO().DeleteChapter(chapterId, cnxnString, logPath);
                Success.InnerText = "Chapter deleted successfully.";
                Success.Visible = true;

                bindGridView();
            }
        }
        catch (Exception ex)
        {
            if (ex.Source == "MySql.Data" || ex.Message.ToLower().Contains("foreign key"))
            {
                errorSummary.InnerText = "Error: there are some sections refer to this chapter, so cannot delete it.";
                errorSummary.Visible = true;
            }
            else
            {
                throw ex;
            }
        }
    }

    protected void gvChapterDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            e.Row.Attributes.Add("onMouseOver", "Highlight(this)");

            e.Row.Attributes.Add("onMouseOut", "UnHighlight(this)");
        }
    }
}