
/****** Object:  Table [dbo].[AdmissionFormDetail]    Script Date: 6/8/2018 11:20:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdmissionFormDetail](
	[Id] [int] IDENTITY(1200,1) NOT NULL,
	[CourseName] [varchar](200) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[FatherName] [varchar](100) NOT NULL,
	[FatherFirstName] [varchar](100) NULL,
	[FatherMiddleName] [varchar](100) NULL,
	[FatherLastName] [varchar](100) NULL,
	[MotherFirstName] [varchar](100) NULL,
	[MotherMiddleName] [varchar](100) NULL,
	[MotherLastName] [varchar](100) NULL,
	[AadharNumber] [varchar](20) NULL,
	[PanNumber] [varchar](20) NULL,
	[Dob] [date] NULL,
	[CalculatedAge] [int] NULL,
	[Nationality] [varchar](150) NULL,
	[MotherTongue] [varchar](100) NULL,
	[Religion] [varchar](50) NULL,
	[Category] [varchar](50) NULL,
	[Caste] [varchar](50) NULL,
	[SubCaste] [varchar](50) NULL,
	[CurrentAddress] [varchar](500) NULL,
	[PermanentAddress] [varchar](500) NULL,
	[ResContactNo] [varchar](20) NULL,
	[MobileNumber] [varchar](20) NULL,
	[Email] [varchar](150) NULL,
	[GuardianMotherName] [varchar](150) NULL,
	[GuardianFatherName] [varchar](150) NULL,
	[OccupationofMother] [varchar](200) NULL,
	[OccupationofFather] [varchar](200) NULL,
	[EducationofMother] [varchar](200) NULL,
	[EducationofFather] [varchar](200) NULL,
	[GuardianAddress] [varchar](max) NULL,
	[AnnualIncome] [varchar](50) NULL,
	[GuardianTelephoneNo] [varchar](20) NULL,
	[GuardianOffice] [varchar](20) NULL,
	[GuardianMobile] [varchar](20) NULL,
	[GuardianEmergencyConactNo] [varchar](20) NULL,
	[GuardianEmail] [varchar](100) NULL,
	[NativePlaceAddress] [varchar](500) NULL,
	[BankName] [varchar](200) NULL,
	[BankAddress] [varchar](500) NULL,
	[BankAccountNumber] [varchar](20) NULL,
	[AccountType] [varchar](200) NULL,
	[IFSCCode] [varchar](20) NULL,
	[MICRNumber] [varchar](30) NULL,
	[OrganisationName] [varchar](200) NULL,
	[Designation] [varchar](300) NULL,
	[TotalExperienceInMonth] [varchar](5) NULL,
	[TotalExperienceInYear] [varchar](10) NULL,
	[Photo] [varchar](255) NULL,
	[SignaturePath] [varchar](255) NULL,
	[ParentSignaturePath] [varchar](255) NULL,
	[IsSvtStudentFrom] [bit] NULL,
	[IsSvtKnowRefrence] [varchar](200) NULL,
	[KnowAboutCourse] [varchar](100) NULL,
	[OtherSpecifyHowYouknowCourses] [varchar](100) NULL,
	[PGYearofPassing] [varchar](20) NULL,
	[PGSchoolName] [varchar](200) NULL,
	[PGMedium] [varchar](100) NULL,
	[PGBoardName] [varchar](100) NULL,
	[PGTotalPercent] [varchar](10) NULL,
	[PGGrade] [varchar](10) NULL,
	[BachelorYearofPassing] [varchar](20) NULL,
	[BachelorSchoolName] [varchar](200) NULL,
	[BachelorMedium] [varchar](100) NULL,
	[BachelorBoardName] [varchar](100) NULL,
	[BachelorTotalPercent] [varchar](10) NULL,
	[BachelorGrade] [varchar](10) NULL,
	[HscYearofPassing] [varchar](20) NULL,
	[HscSchoolName] [varchar](200) NULL,
	[HscMedium] [varchar](100) NULL,
	[HscBoardName] [varchar](100) NULL,
	[HscTotalPercent] [varchar](10) NULL,
	[HscGrade] [varchar](10) NULL,
	[SscYearofPassing] [varchar](20) NULL,
	[SscSchoolName] [varchar](200) NULL,
	[SscMedium] [varchar](100) NULL,
	[SscBoardName] [varchar](100) NULL,
	[SscTotalPercent] [varchar](10) NULL,
	[SscGrade] [varchar](10) NULL,
	[ExaminationType] [varchar](100) NULL,
	[OtherExaminationType] [varchar](200) NULL,
	[HobbiesOrSpecailInterest] [varchar](500) NULL,
	[HonorPrizeName] [varchar](500) NULL,
	[Note] [varchar](max) NULL,
	[DateRegistered] [datetime] NOT NULL,
	[IsSubmitted] [bit] NULL,
	[DateSubmitted] [datetime] NULL,
	[LastModified] [datetime] NULL,
	[LastModified2] [datetime] NULL,
	[IsDuplicateAadhar] [bit] NULL,
 CONSTRAINT [PK_AdmissionFormDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[UspAdmissionFormDetailSave]    Script Date: 6/8/2018 11:20:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:	Kaushik
-- Create date:	23-May-2018
-- Description:	Save AdmissionFormDetail Data
-- =============================================
CREATE PROCEDURE [dbo].[UspAdmissionFormDetailSave] (
	@Id int = 0, 
	@CourseName varchar(200)=null,
	@FirstName varchar(100)=null,
	@LastName varchar(100)=null,
	@FatherName varchar(100)=null,
	 
	@FatherFirstName varchar(100) = NULL,
	@FatherMiddleName varchar(100) = NULL,
	@FatherLastName varchar(100) = NULL,
	@MotherFirstName varchar(100) = NULL,
	@MotherMiddleName varchar(100) = NULL,
	@MotherLastName varchar(100) = NULL,
	@AadharNumber varchar(20) = NULL,
	@PanNumber varchar(20) = NULL,
	@Dob date = NULL,
	@CalculatedAge int = NULL,
	@Nationality varchar(150) = NULL,
	@MotherTongue varchar(100) = NULL,
	@Religion varchar(50) = NULL,
	@Category varchar(50) = NULL,
	@Caste varchar(50) = NULL,
	@SubCaste varchar(50) = NULL,
	@CurrentAddress varchar(500) = NULL,
	@PermanentAddress varchar(500) = NULL,
	@ResContactNo varchar(20) = NULL,
	@MobileNumber varchar(20) = NULL,
	@Email varchar(150) = NULL,
	@GuardianMotherName varchar(150) = NULL,
	@GuardianFatherName varchar(150) = NULL,
	@OccupationofMother varchar(200) = NULL,
	@OccupationofFather varchar(200) = NULL,
	@EducationofMother varchar(200) = NULL,
	@EducationofFather varchar(200) = NULL,
	@GuardianAddress varchar(MAX) = NULL,
	@AnnualIncome varchar(50) = NULL,
	@GuardianTelephoneNo varchar(20) = NULL,
	@GuardianOffice varchar(20) = NULL,
	@GuardianMobile varchar(20) = NULL,
	@GuardianEmergencyConactNo varchar(20) = NULL,
	@GuardianEmail varchar(100) = NULL,
	@NativePlaceAddress varchar(500) = NULL,
	@BankName varchar(200) = NULL,
	@BankAddress varchar(500) = NULL,
	@BankAccountNumber varchar(20) = NULL,
	@AccountType varchar(200) = NULL,
	@IFSCCode varchar(20) = NULL,
	@MICRNumber varchar(30) = NULL,
	@OrganisationName varchar(200) = NULL,
	@Designation varchar(300) = NULL,
	@TotalExperienceInMonth varchar(5) = NULL,
	@TotalExperienceInYear varchar(10) = NULL,
	@Photo varchar(255) = NULL,
	@SignaturePath varchar(255) = NULL,
	@ParentSignaturePath varchar(255) = NULL,
	@IsSvtStudentFrom bit = NULL,
	@IsSvtKnowRefrence varchar(200) = NULL,
	@KnowAboutCourse varchar(100) = NULL,
	@OtherSpecifyHowYouknowCourses varchar(100) = NULL,
	@PGYearofPassing varchar(20) = NULL,
	@PGSchoolName varchar(200) = NULL,
	@PGMedium varchar(100) = NULL,
	@PGBoardName varchar(100) = NULL,
	@PGTotalPercent varchar(10) = NULL,
	@PGGrade varchar(10) = NULL,
	@BachelorYearofPassing varchar(20) = NULL,
	@BachelorSchoolName varchar(200) = NULL,
	@BachelorMedium varchar(100) = NULL,
	@BachelorBoardName varchar(100) = NULL,
	@BachelorTotalPercent varchar(10) = NULL,
	@BachelorGrade varchar(10) = NULL,
	@HscYearofPassing varchar(20) = NULL,
	@HscSchoolName varchar(200) = NULL,
	@HscMedium varchar(100) = NULL,
	@HscBoardName varchar(100) = NULL,
	@HscTotalPercent varchar(10) = NULL,
	@HscGrade varchar(10) = NULL,
	@SscYearofPassing varchar(20) = NULL,
	@SscSchoolName varchar(200) = NULL,
	@SscMedium varchar(100) = NULL,
	@SscBoardName varchar(100) = NULL,
	@SscTotalPercent varchar(10) = NULL,
	@SscGrade varchar(10) = NULL,
	@ExaminationType varchar(100) = NULL,
	@OtherExaminationType varchar(200) = NULL,
	@HobbiesOrSpecailInterest varchar(500) = NULL,
	@HonorPrizeName varchar(500) = NULL,
	@Note varchar(MAX) = NULL,
	@DateRegistered datetime = NULL,
	@IsSubmitted bit = NULL,
	@DateSubmitted datetime = NULL,
	@LastModified datetime = NULL,
	@LastModified2 datetime = NULL,
	@IsDuplicateAadhar bit = NULL
)
AS

SET NOCOUNT ON

update [AdmissionFormDetail] set IsDuplicateAadhar=1 where Id <> @Id and [AadharNumber]=@AadharNumber

IF @Id > 0 
BEGIN
	UPDATE
		[AdmissionFormDetail]
	SET
		[CourseName] = UPPER(@CourseName),
		[FirstName] = UPPER(@FirstName),
		[LastName] = UPPER(@LastName),
		[FatherName] = UPPER(@FatherName),
		
		[FatherFirstName] = UPPER(@FatherFirstName),
		[FatherMiddleName] = UPPER(@FatherMiddleName),
		[FatherLastName] = UPPER(@FatherLastName),
		[MotherFirstName] = UPPER(@MotherFirstName),
		[MotherMiddleName] = UPPER(@MotherMiddleName),
		[MotherLastName] = UPPER(@MotherLastName),
		[AadharNumber] = @AadharNumber,
		[PanNumber] = UPPER(@PanNumber),
		[Dob] = @Dob,
		[CalculatedAge] = @CalculatedAge,
		[Nationality] = UPPER(@Nationality),
		[MotherTongue] = UPPER(@MotherTongue),
		[Religion] = UPPER(@Religion),
		[Category] = UPPER(@Category),
		[Caste] = UPPER(@Caste),
		[SubCaste] = UPPER(@SubCaste),
		[CurrentAddress] = UPPER(@CurrentAddress),
		[PermanentAddress] = UPPER(@PermanentAddress),
		[ResContactNo] = @ResContactNo,
		[MobileNumber] = @MobileNumber,
		[Email] = UPPER(@Email),
		[GuardianMotherName] = UPPER(@GuardianMotherName),
		[GuardianFatherName] = UPPER(@GuardianFatherName),
		[OccupationofMother] = UPPER(@OccupationofMother),
		[OccupationofFather] = UPPER(@OccupationofFather),
		[EducationofMother] =  UPPER(@EducationofMother),
		[EducationofFather] =  UPPER(@EducationofFather),
		[GuardianAddress] =    UPPER(@GuardianAddress),
		[AnnualIncome] = @AnnualIncome,
		[GuardianTelephoneNo] = @GuardianTelephoneNo,
		[GuardianOffice] = @GuardianOffice,
		[GuardianMobile] = @GuardianMobile,
		[GuardianEmergencyConactNo] = @GuardianEmergencyConactNo,
		[GuardianEmail] = UPPER(@GuardianEmail),
		[NativePlaceAddress] = UPPER(@NativePlaceAddress),
		[BankName] = UPPER(@BankName),
		[BankAddress] = UPPER(@BankAddress),
		[BankAccountNumber] = @BankAccountNumber,
		[AccountType] = UPPER(@AccountType),
		[IFSCCode] = UPPER(@IFSCCode),
		[MICRNumber] = @MICRNumber,
		[OrganisationName] = UPPER(@OrganisationName),
		[Designation] = UPPER(@Designation),
		[TotalExperienceInMonth] = @TotalExperienceInMonth,
		[TotalExperienceInYear] = @TotalExperienceInYear,
		[Photo] = @Photo,
		[SignaturePath] = @SignaturePath,
		[ParentSignaturePath] = @ParentSignaturePath,
		[IsSvtStudentFrom] = @IsSvtStudentFrom,
		[IsSvtKnowRefrence] = @IsSvtKnowRefrence,
		[KnowAboutCourse] = UPPER(@KnowAboutCourse),
		[OtherSpecifyHowYouknowCourses] = UPPER(@OtherSpecifyHowYouknowCourses),
		[PGYearofPassing] = @PGYearofPassing,
		[PGSchoolName] = UPPER(@PGSchoolName),
		[PGMedium] = UPPER(@PGMedium),
		[PGBoardName] = UPPER(@PGBoardName),
		[PGTotalPercent] = @PGTotalPercent,
		[PGGrade] = UPPER(@PGGrade),
		[BachelorYearofPassing] = @BachelorYearofPassing,
		[BachelorSchoolName] = UPPER(@BachelorSchoolName),
		[BachelorMedium] = UPPER(@BachelorMedium),
		[BachelorBoardName] = UPPER(@BachelorBoardName),
		[BachelorTotalPercent] = @BachelorTotalPercent,
		[BachelorGrade] = UPPER(@BachelorGrade),
		[HscYearofPassing] = @HscYearofPassing,
		[HscSchoolName] = UPPER(@HscSchoolName),
		[HscMedium] = UPPER(@HscMedium),
		[HscBoardName] = UPPER(@HscBoardName),
		[HscTotalPercent] = @HscTotalPercent,
		[HscGrade] = UPPER(@HscGrade),
		[SscYearofPassing] = @SscYearofPassing,
		[SscSchoolName] = UPPER(@SscSchoolName),
		[SscMedium] = UPPER(@SscMedium),
		[SscBoardName] = UPPER(@SscBoardName),
		[SscTotalPercent] = @SscTotalPercent,
		[SscGrade] = UPPER(@SscGrade),
		[ExaminationType] = UPPER(@ExaminationType),
		[OtherExaminationType] = UPPER(@OtherExaminationType),
		[HobbiesOrSpecailInterest] = UPPER(@HobbiesOrSpecailInterest),
		[HonorPrizeName] = UPPER(@HonorPrizeName),
		[Note] =UPPER(@Note),
		--[DateRegistered] = @DateRegistered,
		[IsSubmitted] = @IsSubmitted,
		[DateSubmitted] = @DateSubmitted,
		[LastModified] = @LastModified,
		[LastModified2] = @LastModified2,
		[IsDuplicateAadhar] = @IsDuplicateAadhar
	WHERE
		 [Id] = @Id

	SELECT @Id As Id

END
ELSE
BEGIN

	INSERT INTO [AdmissionFormDetail] (
		[CourseName],
		[FirstName],
		[LastName],
		[FatherName],
		[FatherFirstName],
		[FatherMiddleName],
		[FatherLastName],
		[MotherFirstName],
		[MotherMiddleName],
		[MotherLastName],
		[AadharNumber],
		[PanNumber],
		[Dob],
		[CalculatedAge],
		[Nationality],
		[MotherTongue],
		[Religion],
		[Category],
		[Caste],
		[SubCaste],
		[CurrentAddress],
		[PermanentAddress],
		[ResContactNo],
		[MobileNumber],
		[Email],
		[GuardianMotherName],
		[GuardianFatherName],
		[OccupationofMother],
		[OccupationofFather],
		[EducationofMother],
		[EducationofFather],
		[GuardianAddress],
		[AnnualIncome],
		[GuardianTelephoneNo],
		[GuardianOffice],
		[GuardianMobile],
		[GuardianEmergencyConactNo],
		[GuardianEmail],
		[NativePlaceAddress],
		[BankName],
		[BankAddress],
		[BankAccountNumber],
		[AccountType],
		[IFSCCode],
		[MICRNumber],
		[OrganisationName],
		[Designation],
		[TotalExperienceInMonth],
		[TotalExperienceInYear],
		[Photo],
		[SignaturePath],
		[ParentSignaturePath],
		[IsSvtStudentFrom],
		[IsSvtKnowRefrence],
		[KnowAboutCourse],
		[OtherSpecifyHowYouknowCourses],
		[PGYearofPassing],
		[PGSchoolName],
		[PGMedium],
		[PGBoardName],
		[PGTotalPercent],
		[PGGrade],
		[BachelorYearofPassing],
		[BachelorSchoolName],
		[BachelorMedium],
		[BachelorBoardName],
		[BachelorTotalPercent],
		[BachelorGrade],
		[HscYearofPassing],
		[HscSchoolName],
		[HscMedium],
		[HscBoardName],
		[HscTotalPercent],
		[HscGrade],
		[SscYearofPassing],
		[SscSchoolName],
		[SscMedium],
		[SscBoardName],
		[SscTotalPercent],
		[SscGrade],
		[ExaminationType],
		[OtherExaminationType],
		[HobbiesOrSpecailInterest],
		[HonorPrizeName],
		[Note],
		[DateRegistered],
		[IsSubmitted],
		[DateSubmitted],
		[LastModified],
		[LastModified2],
		[IsDuplicateAadhar]
	) VALUES (
		UPPER(@CourseName),
		UPPER(@FirstName),
		UPPER(@LastName),
		UPPER(@FatherName),
		UPPER(@FatherFirstName),
		UPPER(@FatherMiddleName),
		UPPER(@FatherLastName),
		UPPER(@MotherFirstName),
		UPPER(@MotherMiddleName),
		UPPER(@MotherLastName),
		@AadharNumber,
		@PanNumber,
		@Dob,
		@CalculatedAge,
		UPPER(@Nationality),
		UPPER(@MotherTongue),
		UPPER(@Religion),
		UPPER(@Category),
		UPPER(@Caste),
		UPPER(@SubCaste),
		UPPER(@CurrentAddress),
		UPPER(@PermanentAddress),
		@ResContactNo,
		@MobileNumber,
		UPPER(@Email),
		UPPER(@GuardianMotherName),
		UPPER(@GuardianFatherName),
		UPPER(@OccupationofMother),
		UPPER(@OccupationofFather),
		UPPER(@EducationofMother),
		UPPER(@EducationofFather),
		UPPER(@GuardianAddress),
		@AnnualIncome,
		@GuardianTelephoneNo,
		@GuardianOffice,
		@GuardianMobile,
		@GuardianEmergencyConactNo,
		UPPER(@GuardianEmail),
		UPPER(@NativePlaceAddress),
		UPPER(@BankName),
		UPPER(@BankAddress),
		@BankAccountNumber,
		UPPER(@AccountType),
		UPPER(@IFSCCode),
		@MICRNumber,
		UPPER(@OrganisationName),
		UPPER(@Designation),
		@TotalExperienceInMonth,
		@TotalExperienceInYear,
		@Photo,
		@SignaturePath,
		@ParentSignaturePath,
		@IsSvtStudentFrom,
		@IsSvtKnowRefrence,
		UPPER(@KnowAboutCourse),
		UPPER(@OtherSpecifyHowYouknowCourses),
		@PGYearofPassing,
		UPPER(@PGSchoolName),
		UPPER(@PGMedium),
		UPPER(@PGBoardName),
		@PGTotalPercent,
		UPPER(@PGGrade),
		@BachelorYearofPassing,
		UPPER(@BachelorSchoolName),
		UPPER(@BachelorMedium),
		UPPER(@BachelorBoardName),
		@BachelorTotalPercent,
		UPPER(@BachelorGrade),
		@HscYearofPassing,
		UPPER(@HscSchoolName),
		UPPER(@HscMedium),
		UPPER(@HscBoardName),
		@HscTotalPercent,
		UPPER(@HscGrade),
		@SscYearofPassing,
		UPPER(@SscSchoolName),
		UPPER(@SscMedium),
		UPPER(@SscBoardName),
		@SscTotalPercent,
		UPPER(@SscGrade),
		UPPER(@ExaminationType),
		UPPER(@OtherExaminationType),
		UPPER(@HobbiesOrSpecailInterest),
		UPPER(@HonorPrizeName),
		UPPER(@Note),
		@DateRegistered,
		@IsSubmitted,
		@DateSubmitted,
		@LastModified,
		@LastModified2,
		@IsDuplicateAadhar
	)

	SELECT SCOPE_IDENTITY() AS Id

END


GO
/****** Object:  StoredProcedure [dbo].[UspAdmissionFormDetailSearch]    Script Date: 6/8/2018 11:20:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:	Kaushik
-- Create date:	23-May-2018
-- Description:	Save AdmissionFormDetail Data
-- =============================================
CREATE PROCEDURE [dbo].[UspAdmissionFormDetailSearch] (
	@Id int= NULL,
	@LastName varchar(100)= NULL,
	@Dob date= NULL,
	@AadharNumber varchar(100)= NULL,
	@StartRowIndex int = NULL,
	@EndRowIndex int = NULL,
	@SortExpression VARCHAR(50) = NULL,
	@SortDirection VARCHAR(10) = NULL
)
AS

SET NOCOUNT ON

-- Get Total Count
-- List the selected Page records from database
IF @SortExpression IS NULL
BEGIN
	SET @SortExpression = 'Name'
END

;WITH AllRecord AS
(
SELECT ROW_NUMBER() OVER (ORDER BY CASE 
WHEN @SortExpression = 'Id' and @SortDirection ='Descending'  THEN m.Id END DESC,
	CASE WHEN @SortExpression = 'Id' THEN m.Id END ASC,
m.[Id]) As RowIndex,
	 m.[Id],
	 m.[CourseName],
	 m.[FirstName],
	 m.[LastName],
	 m.[FatherName],
	 m.[FatherFirstName],
	 m.[FatherMiddleName],
	 m.[FatherLastName],
	 m.[MotherFirstName],
	 m.[MotherMiddleName],
	 m.[MotherLastName],
	 m.[AadharNumber],
	 m.[PanNumber],
	 m.[Dob],
	 m.[CalculatedAge],
	 m.[Nationality],
	 m.[MotherTongue],
	 m.[Religion],
	 m.[Category],
	 m.[Caste],
	 m.[SubCaste],
	 m.[CurrentAddress],
	 m.[PermanentAddress],
	 m.[ResContactNo],
	 m.[MobileNumber],
	 m.[Email],
	 m.[GuardianMotherName],
	 m.[GuardianFatherName],
	 m.[OccupationofMother],
	 m.[OccupationofFather],
	 m.[EducationofMother],
	 m.[EducationofFather],
	 m.[GuardianAddress],
	 m.[AnnualIncome],
	 m.[GuardianTelephoneNo],
	 m.[GuardianOffice],
	 m.[GuardianMobile],
	 m.[GuardianEmergencyConactNo],
	 m.[GuardianEmail],
	 m.[NativePlaceAddress],
	 m.[BankName],
	 m.[BankAddress],
	 m.[BankAccountNumber],
	 m.[AccountType],
	 m.[IFSCCode],
	 m.[MICRNumber],
	 m.[OrganisationName],
	 m.[Designation],
	 m.[TotalExperienceInMonth],
	 m.[TotalExperienceInYear],
	 m.[Photo],
	 m.[SignaturePath],
	 m.[ParentSignaturePath],
	 m.[IsSvtStudentFrom],
	 m.[IsSvtKnowRefrence],
	 m.[KnowAboutCourse],
	 m.[OtherSpecifyHowYouknowCourses],
	 m.[PGYearofPassing],
	 m.[PGSchoolName],
	 m.[PGMedium],
	 m.[PGBoardName],
	 m.[PGTotalPercent],
	 m.[PGGrade],
	 m.[BachelorYearofPassing],
	 m.[BachelorSchoolName],
	 m.[BachelorMedium],
	 m.[BachelorBoardName],
	 m.[BachelorTotalPercent],
	 m.[BachelorGrade],
	 m.[HscYearofPassing],
	 m.[HscSchoolName],
	 m.[HscMedium],
	 m.[HscBoardName],
	 m.[HscTotalPercent],
	 m.[HscGrade],
	 m.[SscYearofPassing],
	 m.[SscSchoolName],
	 m.[SscMedium],
	 m.[SscBoardName],
	 m.[SscTotalPercent],
	 m.[SscGrade],
	 m.[ExaminationType],
	 m.[OtherExaminationType],
	 m.[HobbiesOrSpecailInterest],
	 m.[HonorPrizeName],
	 m.[Note],
	 m.[DateRegistered],
	 m.[IsSubmitted],
	 m.[DateSubmitted],
	 m.[LastModified],
	 m.[LastModified2],
	m.[IsDuplicateAadhar]
FROM
	[AdmissionFormDetail] as m
WHERE 1=1 
	AND (m.Id = @Id OR ISNULL(@Id,0)=0)
	AND (m.LastName = @LastName OR @LastName IS NULL)	
	AND (m.Dob = @Dob OR @Dob IS NULL)	
	AND (m.AadharNumber = @AadharNumber OR @AadharNumber IS NULL)	
	AND ISNULL(m.IsDuplicateAadhar,0)=0
),
AllRecordCount AS
(
SELECT COUNT(1) TotalRecords FROM AllRecord
)
SELECT * FROM AllRecord,AllRecordCount
WHERE RowIndex >= ISNULL(@StartRowIndex,0) and RowIndex<= ISNULL (@EndRowIndex,RowIndex)


GO
/****** Object:  StoredProcedure [dbo].[UspGeneralCheckDuplicate]    Script Date: 6/8/2018 11:20:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec [UspGeneralCheckDuplicate] @tableName='Users', @columnName='Mobile',@columnNameValue=4324234234,@primaryKey='Id',@primaryKeyValue='1cf4ffbd-fe63-4e45-a3a0-7e9e85c4b046'  
  
CREATE PROCEDURE [dbo].[UspGeneralCheckDuplicate]        
 -- Add the parameters for the stored procedure here        
 @tableName varchar(50),        
 @columnName varchar(50),        
 @columnNameValue varchar(50),        
 @columnName2 varchar(50) = '',        
 @columnName2Value varchar(50)= '',        
 @IsCombinationCheck bit = 0,        
 @columnName3 varchar(50) = '',        
 @columnName3Value varchar(50)= '',        
 @primaryKey varchar(50)=null,        
 @primaryKeyValue varchar(50) =null       
AS        
BEGIN        
 -- SET NOCOUNT ON added to prevent extra result sets from        
 -- interfering with SELECT statements.        
 SET NOCOUNT ON;        
        
    -- Insert statements for procedure here        
    DECLARE @query VARCHAR(600);        
    SET @query = '        
 SELECT * FROM ' + @tableName + '        
 WHERE (' + @columnName + ' =  ''' + @columnNameValue + ''''        
 IF @columnName2 <> ''        
 BEGIN        
  IF @IsCombinationCheck = 1        
  BEGIN        
   SET @query = @query +        
   ' AND ' + @columnName2 + ' =  ''' + @columnName2Value + ''''        
   END        
  ELSE        
  BEGIN        
   SET @query = @query +        
   ' OR ' + @columnName2 + ' =  ''' + @columnName2Value + ''''        
   END        
 END        
         
 IF @columnName3 <> ''        
 BEGIN        
  IF @IsCombinationCheck = 1        
  BEGIN        
   SET @query = @query +        
   ' AND ' + @columnName3 + ' =  ''' + @columnName3Value + ''')'        
   END        
  ELSE        
  BEGIN        
   SET @query = @query +        
   ' OR ' + @columnName3 + ' =  ''' + @columnName3Value + ''')'        
   END        
 END        
         
 IF ((@columnName2 <> '' AND (@columnName3 = '' or @columnName3 is null)) OR (@columnName2 = '' AND @columnName3 = ''))        
 BEGIN        
   SET @query = @query + ')'        
 END        
    
  IF(@primaryKeyValue is not null)    
   BEGIN    
    PRINT(@query + ' AND ' + @primaryKey + ' <> ''' + @primaryKeyValue +'''')        
    EXEC(@query  + ' AND ' + @primaryKey + ' <> ''' + @primaryKeyValue +'''')        
   END      
  ELSE    
   BEGIN    
    PRINT(@query)     
    EXEC(@query)        
   END       
END 

GO
