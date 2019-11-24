﻿using System;
using System.Collections.Generic;
using System.Linq;
using iTextSharp.text;
using iTextSharp.text.pdf;
using ITM.Courses.DAO;
using System.IO;

/// <summary>
/// Summary description for PDFCourseWiseStudentsTypingCount
/// </summary>
public class PDFCourseWiseStudentsTypingCount
{
    private static int LOGO_IMAGE_SCALE = 40;
    private static int LOGO_POSITION_X = 70;
    private static int LOGO_POSITION_Y = 750;
    private static int COLLEGE_NAME_FONT_SIZE = 16;
    private static int FONT_SIZE = 9;

    public PDFCourseWiseStudentsTypingCount()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static void CreatePDFHeader(ref PdfWriter writer, ref Document document, ApplicationLogoHeader config)
    {
        try
        {
            using (Stream logoStream = new FileStream(config.LogoImagePath, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                Image image = Image.GetInstance(logoStream);
                image.Alt = config.CollegeName;
                image.ScalePercent(LOGO_IMAGE_SCALE);
                image.SetAbsolutePosition(LOGO_POSITION_X, LOGO_POSITION_Y);
                document.Add(image);
            }


            PdfPTable table = new PdfPTable(1);
            Paragraph colleges = new Paragraph();
            Paragraph address = new Paragraph();
            Paragraph tagLine = new Paragraph();
            Paragraph tagLine1 = new Paragraph();
            Paragraph tagLine2 = new Paragraph();

            PdfPCell cell = new PdfPCell();
            float[] widths = new float[] { 554f };
            table.TotalWidth = 720f;
            table.LockedWidth = true;
            table.HorizontalAlignment = 0;
            table.SetWidths(widths);
            cell.Padding = 5;


            Phrase textColleges = new Phrase(config.LogoText.Trim().ToUpper(), new Font(Font.FontFamily.HELVETICA, COLLEGE_NAME_FONT_SIZE, Font.BOLD));
            colleges.Add(textColleges);
            colleges.Add(new Phrase(Environment.NewLine));

            //Phrase textTagLine = new Phrase(config.TagLine.Trim(), new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL));
            //tagLine.Add(textTagLine);
            //tagLine.Add(new Phrase(Environment.NewLine));

            //Phrase textTagLine1 = new Phrase(config.TagLine1.Trim(), new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL));
            //tagLine1.Add(textTagLine1);
            //tagLine1.Add(new Phrase(Environment.NewLine));

            //Phrase textTagLine2 = new Phrase(config.TagLine2.Trim(), new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL));
            //tagLine2.Add(textTagLine2);
            ////tagLine2.Add(new Phrase(Environment.NewLine));

            //Phrase textAddress = new Phrase(config.Address.Trim(), new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL));
            //address.Add(textAddress);
            ////address.Add(new Phrase(Environment.NewLine));

            colleges.Alignment = Element.ALIGN_CENTER;
            //address.Alignment = Element.ALIGN_CENTER;
            //tagLine.Alignment = Element.ALIGN_CENTER;
            //tagLine1.Alignment = Element.ALIGN_CENTER;
            //tagLine2.Alignment = Element.ALIGN_CENTER;

            cell.AddElement(colleges);
            //cell.AddElement(tagLine);
            //cell.AddElement(tagLine1);
            //cell.AddElement(tagLine2);
            //cell.AddElement(address);

            table.AddCell(cell);
            ColumnText tab = new ColumnText(writer.DirectContent);
            tab.SetSimpleColumn(400, 570, 500, 100);
            //tab.SetSimpleColumn(20, 400, 500, 100);
            //tab.AddElement(table);
            tab.AddElement(textColleges);
            tab.Go();
        }
        catch (Exception ex)
        {
            // TODO - log an exception
            return;
        }
    }

    public static void CreatePDFSubHeader(ref PdfWriter writer, ref Document document, string course, string subcourse)
    {
        try
        {
            Phrase courseName = new Phrase("Course : " + course + " - " + subcourse, new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL));
            Phrase month = new Phrase("Month : ", new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL));
            Phrase year = new Phrase("Year : ", new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL));
            Phrase examname = new Phrase("Exam Name : ", new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL));

            Phrase date = new Phrase("Date : ", new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL));
            Phrase supervisor = new Phrase("Supervisor Name : ", new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL));

            ColumnText courseNameCT = new ColumnText(writer.DirectContent);
            ColumnText yearCT = new ColumnText(writer.DirectContent);
            ColumnText examnameCT = new ColumnText(writer.DirectContent);
            ColumnText monthCT = new ColumnText(writer.DirectContent);
            ColumnText paperNameCT = new ColumnText(writer.DirectContent);
            ColumnText papercodeCT = new ColumnText(writer.DirectContent);
            ColumnText dateCT = new ColumnText(writer.DirectContent);
            ColumnText supervisorCT = new ColumnText(writer.DirectContent);

            courseNameCT.Alignment = Element.ALIGN_LEFT;
            monthCT.Alignment = Element.ALIGN_LEFT;
            yearCT.Alignment = Element.ALIGN_LEFT;
            examnameCT.Alignment = Element.ALIGN_LEFT;
            paperNameCT.Alignment = Element.ALIGN_LEFT;
            papercodeCT.Alignment = Element.ALIGN_LEFT;
            dateCT.Alignment = Element.ALIGN_LEFT;
            supervisorCT.Alignment = Element.ALIGN_LEFT;

            courseNameCT.SetSimpleColumn(60, 470, 800, 100);
            monthCT.SetSimpleColumn(200, 470, 800, 100);
            yearCT.SetSimpleColumn(300, 470, 800, 100);
            examnameCT.SetSimpleColumn(450, 470, 800, 100);
            paperNameCT.SetSimpleColumn(200, 450, 800, 100);
            papercodeCT.SetSimpleColumn(60, 450, 800, 100);
            dateCT.SetSimpleColumn(450, 430, 800, 100);
            supervisorCT.SetSimpleColumn(60, 430, 800, 100);

            courseNameCT.AddText(courseName);
            monthCT.AddText(month);
            yearCT.AddText(year);
            examnameCT.AddText(examname);
            //paperNameCT.AddText(paperName);
            //papercodeCT.AddText(papercode);
            dateCT.AddText(date);
            supervisorCT.AddText(supervisor);

            courseNameCT.Go();
            yearCT.Go();
            examnameCT.Go();
            monthCT.Go();
            //paperNameCT.Go();
            //papercodeCT.Go();
            //dateCT.Go();
            //supervisorCT.Go();

        }
        catch (Exception ex)
        {

            return;
        }
    }

    public static void CreatePDFMainContent(ref PdfWriter writer, ref Document document, List<UserDetails> topperList, int reportCount)
    {
        try
        {
            Paragraph srno = new Paragraph();
            Paragraph course = new Paragraph();
            Paragraph studentCount = new Paragraph();
            
            srno.Alignment = Element.ALIGN_CENTER;
            course.Alignment = Element.ALIGN_CENTER;
            studentCount.Alignment = Element.ALIGN_CENTER;

            srno.Add(new Phrase("SrNo", new Font(Font.FontFamily.HELVETICA, FONT_SIZE, Font.BOLD)));
            course.Add(new Phrase("Course", new Font(Font.FontFamily.HELVETICA, FONT_SIZE, Font.BOLD)));
            studentCount.Add(new Phrase("Student-Counts", new Font(Font.FontFamily.HELVETICA, FONT_SIZE, Font.BOLD)));
            
            int count = 0;
            int counter = 0;
            int marklist = topperList.Count();
            PdfPTable table = null;

            foreach (UserDetails m in topperList)
            {
                counter++;

                if ((count % (reportCount + 1)) == 0)
                {
                    table = new PdfPTable(3);
                    float[] widths = new float[] { 50f, 200f, 100f };
                    table.TotalWidth = 554f;
                    table.LockedWidth = true;
                    table.HorizontalAlignment = 0;
                    table.SetWidths(widths);

                    PdfPCell cell1 = new PdfPCell();
                    cell1.Padding = 5;
                    cell1.HorizontalAlignment = Element.ALIGN_CENTER;
                    cell1.AddElement(srno);

                    PdfPCell cell2 = new PdfPCell();
                    cell2.Padding = 5;
                    cell2.HorizontalAlignment = Element.ALIGN_CENTER;
                    cell2.AddElement(course);

                    PdfPCell cell3 = new PdfPCell();
                    cell3.Padding = 5;
                    cell3.HorizontalAlignment = Element.ALIGN_CENTER;
                    cell3.AddElement(studentCount);

                    table.AddCell(cell1);
                    table.AddCell(cell2);
                    table.AddCell(cell3);
                    
                    count++;
                }

                Phrase p1 = new Phrase(counter.ToString(), new Font(Font.FontFamily.HELVETICA, FONT_SIZE, Font.NORMAL));
                PdfPCell cellp1 = new PdfPCell(p1);
                cellp1.Padding = 5;
                cellp1.HorizontalAlignment = Element.ALIGN_CENTER;
                Phrase p2 = new Phrase(m.Course, new Font(Font.FontFamily.HELVETICA, FONT_SIZE, Font.NORMAL));
                PdfPCell cellp2 = new PdfPCell(p2);
                cellp2.Padding = 5;
                cellp2.HorizontalAlignment = Element.ALIGN_CENTER;
                Phrase p3 = new Phrase(m.Id.ToString(), new Font(Font.FontFamily.HELVETICA, FONT_SIZE, Font.NORMAL));
                PdfPCell cellp3 = new PdfPCell(p3);
                cellp3.Padding = 5;
                cellp3.HorizontalAlignment = Element.ALIGN_CENTER;

                table.AddCell(cellp1);
                table.AddCell(cellp2);
                table.AddCell(cellp3);
                
                if (count == reportCount)
                {
                    ColumnText tab1 = new ColumnText(writer.DirectContent);
                    tab1.SetSimpleColumn(20, 720, 800, 80);
                    tab1.AddElement(table);
                    tab1.Go();
                    document.NewPage();
                    count = 0;
                }
                else
                {
                    count++;
                }
                if (counter == marklist)
                {
                    ColumnText tab0 = new ColumnText(writer.DirectContent);
                    tab0.SetSimpleColumn(20, 720, 800, 80);
                    tab0.AddElement(table);
                    tab0.Go();
                }
            }
        }
        catch (Exception ex)
        {
        }
    }
}