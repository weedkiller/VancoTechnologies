using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Drawing;
using DocumentFormat.OpenXml.Drawing.Charts;
using DocumentFormat.OpenXml.Drawing.Spreadsheet;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace QuarterlyReports.Helpers
{
    public class GraphsInExcel
    {
        static DrawingsPart drawingsPart = null;

        public static void GenerateChartsForQuestions(string filePath, string filename, List<AnwerChartReport> listOfAnwerChartReport)
        {
            string worksheetName = "Sheet1";
            int columnStart = 1;
            int rowStart = 2;
            int columnWidth = 9;
            int rowWidth = 16;

            for (int i = 1; i <= listOfAnwerChartReport.Count; i++)
            {
                InsertChartInSpreadsheet(filePath + "\\" + filename, worksheetName, listOfAnwerChartReport[i - 1].Title, listOfAnwerChartReport[i - 1].DicAnwers, columnStart, columnStart + columnWidth, rowStart, rowStart + rowWidth, listOfAnwerChartReport.Count);
            }
        }

        // Given a document name, a worksheet name, a chart title, and a Dictionary collection of text keys
        // and corresponding integer data, creates a column chart with the text as the series and the integers as the values.
        private static void InsertChartInSpreadsheet(string docName, string worksheetName, string title,
        Dictionary<string, int> data, int columnStart, int columnEnd, int rowStart, int rowEnd, int totalCount)
        {
            // Open the document for editing.
            using (SpreadsheetDocument document = SpreadsheetDocument.Open(docName, true))
            {
                IEnumerable<Sheet> sheets = document.WorkbookPart.Workbook.Descendants<Sheet>().
        Where(s => s.Name == worksheetName);
                if (sheets.Count() == 0)
                {
                    // The specified worksheet does not exist.
                    return;
                }
                WorksheetPart worksheetPart = (WorksheetPart)document.WorkbookPart.GetPartById(sheets.First().Id);

                // Add a new drawing to the worksheet.
                if (drawingsPart == null)
                {
                    drawingsPart = worksheetPart.AddNewPart<DrawingsPart>();

                    worksheetPart.Worksheet.Append(new DocumentFormat.OpenXml.Spreadsheet.Drawing() { Id = worksheetPart.GetIdOfPart(drawingsPart) });
                    worksheetPart.Worksheet.Save();
                }
                else
                {
                    drawingsPart = worksheetPart.DrawingsPart;

                }

                // Add a new chart and set the chart language to English-US.

                ChartPart chartPart = drawingsPart.AddNewPart<ChartPart>();
                chartPart.ChartSpace = new ChartSpace();
                chartPart.ChartSpace.Append(new EditingLanguage() { Val = new StringValue("en-US") });


                DocumentFormat.OpenXml.Drawing.Charts.Chart chart = chartPart.ChartSpace.AppendChild<DocumentFormat.OpenXml.Drawing.Charts.Chart>(
                    new DocumentFormat.OpenXml.Drawing.Charts.Chart());

                // Create a new clustered column chart.
                PlotArea plotArea = chart.AppendChild<PlotArea>(new PlotArea());
                Layout layout = plotArea.AppendChild<Layout>(new Layout());
                BarChart barChart = plotArea.AppendChild<BarChart>(new BarChart(new BarDirection() { Val = new EnumValue<BarDirectionValues>(BarDirectionValues.Column) },
                    new BarGrouping() { Val = new EnumValue<BarGroupingValues>(BarGroupingValues.Clustered) }));

                uint i = 0;

                // Iterate through each key in the Dictionary collection and add the key to the chart Series
                // and add the corresponding value to the chart Values.
                foreach (string key in data.Keys)
                {
                    BarChartSeries barChartSeries = barChart.AppendChild<BarChartSeries>(new BarChartSeries(new Index()
                    {
                        Val =
                            new UInt32Value(i)
                    },
                        new Order() { Val = new UInt32Value(i) },
                        new SeriesText(new NumericValue() { Text = key })));

                    StringLiteral strLit = barChartSeries.AppendChild<CategoryAxisData>(new CategoryAxisData()).AppendChild<StringLiteral>(new StringLiteral());
                    strLit.Append(new PointCount() { Val = new UInt32Value(1U) });
                    strLit.AppendChild<StringPoint>(new StringPoint() { Index = new UInt32Value(0U) }).Append(new NumericValue(title));

                    NumberLiteral numLit = barChartSeries.AppendChild<DocumentFormat.OpenXml.Drawing.Charts.Values>(
                        new DocumentFormat.OpenXml.Drawing.Charts.Values()).AppendChild<NumberLiteral>(new NumberLiteral());
                    numLit.Append(new FormatCode("General"));
                    numLit.Append(new PointCount() { Val = new UInt32Value(1U) });
                    numLit.AppendChild<NumericPoint>(new NumericPoint() { Index = new UInt32Value(0u) }).Append
        (new NumericValue(data[key].ToString()));

                    i++;
                }

                barChart.Append(new AxisId() { Val = new UInt32Value(48650112u) });
                barChart.Append(new AxisId() { Val = new UInt32Value(48672768u) });

                // Add the Category Axis.
                CategoryAxis catAx = plotArea.AppendChild<CategoryAxis>(new CategoryAxis(new AxisId() { Val = new UInt32Value(48650112u) }, new Scaling(new Orientation()
                {
                    Val = new EnumValue<DocumentFormat.
                        OpenXml.Drawing.Charts.OrientationValues>(DocumentFormat.OpenXml.Drawing.Charts.OrientationValues.MinMax)
                }),
                    new AxisPosition() { Val = new EnumValue<AxisPositionValues>(AxisPositionValues.Bottom) },
                    new TickLabelPosition() { Val = new EnumValue<TickLabelPositionValues>(TickLabelPositionValues.NextTo) },
                    new CrossingAxis() { Val = new UInt32Value(48672768U) },
                    new Crosses() { Val = new EnumValue<CrossesValues>(CrossesValues.AutoZero) },
                    new AutoLabeled() { Val = new BooleanValue(true) },
                    new LabelAlignment() { Val = new EnumValue<LabelAlignmentValues>(LabelAlignmentValues.Center) },
                    new LabelOffset() { Val = new UInt16Value((ushort)100) }));

                // Add the Value Axis.
                ValueAxis valAx = plotArea.AppendChild<ValueAxis>(new ValueAxis(new AxisId() { Val = new UInt32Value(48672768u) },
                    new Scaling(new Orientation()
                    {
                        Val = new EnumValue<DocumentFormat.OpenXml.Drawing.Charts.OrientationValues>(
                            DocumentFormat.OpenXml.Drawing.Charts.OrientationValues.MinMax)
                    }),
                    new AxisPosition() { Val = new EnumValue<AxisPositionValues>(AxisPositionValues.Left) },
                    new MajorGridlines(),
                    new DocumentFormat.OpenXml.Drawing.Charts.NumberingFormat()
                    {
                        FormatCode = new StringValue("General"),
                        SourceLinked = new BooleanValue(true)
                    }, new TickLabelPosition()
                    {
                        Val = new EnumValue<TickLabelPositionValues>
                            (TickLabelPositionValues.NextTo)
                    }, new CrossingAxis() { Val = new UInt32Value(48650112U) },
                    new Crosses() { Val = new EnumValue<CrossesValues>(CrossesValues.AutoZero) },
                    new CrossBetween() { Val = new EnumValue<CrossBetweenValues>(CrossBetweenValues.Between) }));

                // Add the chart Legend.
                Legend legend = chart.AppendChild<Legend>(new Legend(new LegendPosition() { Val = new EnumValue<LegendPositionValues>(LegendPositionValues.Right) },
                    new Layout()));

                chart.Append(new PlotVisibleOnly() { Val = new BooleanValue(true) });

                // Save the chart part.
                chartPart.ChartSpace.Save();

                if (drawingsPart.ChartParts.Count() < totalCount - 1)
                {
                    return;
                }
                drawingsPart.WorksheetDrawing = new WorksheetDrawing();
                for (int j = 0; j < drawingsPart.ChartParts.Count(); j++)
                {
                    chartPart = drawingsPart.ChartParts.ElementAt(j);
                    // Position the chart on the worksheet using a TwoCellAnchor object.

                    TwoCellAnchor twoCellAnchor = drawingsPart.WorksheetDrawing.AppendChild<TwoCellAnchor>(new TwoCellAnchor());
                    twoCellAnchor.Append(new DocumentFormat.OpenXml.Drawing.Spreadsheet.FromMarker(new ColumnId(columnStart.ToString()),
                        new ColumnOffset(columnEnd.ToString()),
                        new RowId(rowStart.ToString()),
                        new RowOffset(rowEnd.ToString())));
                    twoCellAnchor.Append(new DocumentFormat.OpenXml.Drawing.Spreadsheet.ToMarker(new ColumnId(columnEnd.ToString()),
                        new ColumnOffset(columnEnd.ToString()),
                        new RowId(rowEnd.ToString()),
                        new RowOffset(rowEnd.ToString())));

                    // Append a GraphicFrame to the TwoCellAnchor object.
                    DocumentFormat.OpenXml.Drawing.Spreadsheet.GraphicFrame graphicFrame =
                        twoCellAnchor.AppendChild<DocumentFormat.OpenXml.
            Drawing.Spreadsheet.GraphicFrame>(new DocumentFormat.OpenXml.Drawing.
            Spreadsheet.GraphicFrame());
                    graphicFrame.Macro = "";

                    graphicFrame.Append(new DocumentFormat.OpenXml.Drawing.Spreadsheet.NonVisualGraphicFrameProperties(
                        new DocumentFormat.OpenXml.Drawing.Spreadsheet.NonVisualDrawingProperties() { Id = new UInt32Value(2u), Name = "Chart 1" },
                        new DocumentFormat.OpenXml.Drawing.Spreadsheet.NonVisualGraphicFrameDrawingProperties()));

                    graphicFrame.Append(new Transform(new Offset() { X = 0L, Y = 0L },
                                                                            new Extents() { Cx = 0L, Cy = 0L }));

                    graphicFrame.Append(new Graphic(new GraphicData(new ChartReference() { Id = drawingsPart.GetIdOfPart(chartPart) }) { Uri = "http://schemas.openxmlformats.org/drawingml/2006/chart" }));

                    twoCellAnchor.Append(new ClientData());

                    if (j % 2 != 0)
                    {
                        rowStart = rowStart + 18;
                        rowEnd = rowEnd + 18;
                        columnStart = 1;
                        columnEnd = 10;
                    }
                    else
                    {
                        columnStart = columnStart + 10;
                        columnEnd = columnEnd + 10;
                    }
                }

                drawingsPart.WorksheetDrawing.Save();
            }

        }
    }
}