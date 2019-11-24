/****** Object:  StoredProcedure [dbo].[GenerateGeneralReport]    Script Date: 6/26/2018 9:12:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- [GenerateGeneralReport]
CREATE PROC [dbo].[GenerateGeneralReport]
AS
BEGIN
SELECT ROW_NUMBER() over (order by ID) AS 'Sr No.',
*
FROM AdmissionFormDetail t1 where AadharNumber is not null and AadharNumber!='' and LastModified = (select max(LastModified) from AdmissionFormDetail where t1.AadharNumber =AdmissionFormDetail.AadharNumber)
 END