namespace AA.ExcelManager
{
    using DocumentFormat.OpenXml;
    using DocumentFormat.OpenXml.Spreadsheet;
    using System;
    using System.Drawing;

    public class NumberCell : Cell
    {
        public NumberCell(string header, string text, int index, Stylesheet styleSheet)
        {
            try
            {
                base.DataType = CellValues.Number;
                base.CellReference = header + index;
                base.CellValue = new CellValue(text);
                UInt32Value value2 = CreateCellFormat(styleSheet);
                base.StyleIndex = value2;
            }
            catch (Exception exception)
            {
                throw exception;
            }
        }

        private static UInt32Value CreateCellFormat(Stylesheet styleSheet)
        {
            UInt32Value value3;
            CellFormat format = new CellFormat();
            try
            {
                Alignment alignment = new Alignment
                {
                    WrapText = true,
                    Vertical = VerticalAlignmentValues.Center,
                    Horizontal = HorizontalAlignmentValues.Center
                };
                format.Alignment = alignment;
                format.ApplyAlignment = true;
                Borders borders = new Borders();
                Border border = new Border();
                border = new Border
                {
                    LeftBorder = new LeftBorder()
                };
                border.LeftBorder.Style = BorderStyleValues.Medium;
                border.RightBorder = new RightBorder();
                border.RightBorder.Style = BorderStyleValues.Medium;
                border.TopBorder = new TopBorder();
                border.TopBorder.Style = BorderStyleValues.Medium;
                border.BottomBorder = new BottomBorder();
                border.BottomBorder.Style = BorderStyleValues.Medium;
                border.DiagonalBorder = new DiagonalBorder();
                borders.Append(new OpenXmlElement[] { border });
                borders.Count = UInt32Value.FromUInt32((uint)borders.ChildElements.Count);
                format.BorderId = borders.Count;
                styleSheet.CellFormats.Append(new OpenXmlElement[] { format });
                UInt32Value count = styleSheet.CellFormats.Count;
                CellFormats cellFormats = styleSheet.CellFormats;
                cellFormats.Count += 1;
                value3 = count;
            }
            catch (Exception exception)
            {
                throw exception;
            }
            return value3;
        }

        private static UInt32Value CreateFill(Stylesheet styleSheet, System.Drawing.Color fillColor)
        {
            UInt32Value value4;
            try
            {
                OpenXmlElement[] childElements = new OpenXmlElement[1];
                ForegroundColor color = new ForegroundColor();
                HexBinaryValue value3 = new HexBinaryValue
                {
                    Value = ColorTranslator.ToHtml(System.Drawing.Color.FromArgb(fillColor.A, fillColor.R, fillColor.G, fillColor.B)).Replace("#", "")
                };
                color.Rgb = value3;
                childElements[0] = color;
                PatternFill fill = new PatternFill(childElements)
                {
                    PatternType = PatternValues.Solid
                };
                Fill fill2 = new Fill(new OpenXmlElement[] { fill });
                styleSheet.Fills.Append(new OpenXmlElement[] { fill2 });
                UInt32Value count = styleSheet.Fills.Count;
                Fills fills = styleSheet.Fills;
                fills.Count += 1;
                value4 = count;
            }
            catch (Exception exception)
            {
                throw exception;
            }
            return value4;
        }

        private static UInt32Value CreateFont(Stylesheet styleSheet, string fontName, double? fontSize, bool isBold, System.Drawing.Color foreColor)
        {
            UInt32Value value4;
            try
            {
                DocumentFormat.OpenXml.Spreadsheet.Font font = new DocumentFormat.OpenXml.Spreadsheet.Font();
                if (!string.IsNullOrEmpty(fontName))
                {
                    FontName name = new FontName
                    {
                        Val = fontName
                    };
                    font.Append(new OpenXmlElement[] { name });
                }
                if (fontSize.HasValue)
                {
                    FontSize size = new FontSize
                    {
                        Val = fontSize.Value
                    };
                    font.Append(new OpenXmlElement[] { size });
                }
                if (isBold)
                {
                    Bold bold = new Bold();
                    font.Append(new OpenXmlElement[] { bold });
                }
                DocumentFormat.OpenXml.Spreadsheet.Color color2 = new DocumentFormat.OpenXml.Spreadsheet.Color();
                HexBinaryValue value3 = new HexBinaryValue
                {
                    Value = ColorTranslator.ToHtml(System.Drawing.Color.FromArgb(foreColor.A, foreColor.R, foreColor.G, foreColor.B)).Replace("#", "")
                };
                color2.Rgb = value3;
                DocumentFormat.OpenXml.Spreadsheet.Color color = color2;
                font.Append(new OpenXmlElement[] { color });
                styleSheet.Fonts.Append(new OpenXmlElement[] { font });
                UInt32Value count = styleSheet.Fonts.Count;
                Fonts fonts = styleSheet.Fonts;
                fonts.Count += 1;
                value4 = count;
            }
            catch (Exception exception)
            {
                throw exception;
            }
            return value4;
        }
    }
}
