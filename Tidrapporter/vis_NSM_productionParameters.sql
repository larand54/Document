USE [VIS_VIDA]
GO
/****** Object:  StoredProcedure [dbo].[vis_NSM_productionParameters]    Script Date: 2018-01-03 15:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- exec dbo.vis_NSM_productionParameters 91495

ALTER PROCEDURE [dbo].[vis_NSM_productionParameters] @ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		Select
		--SOR.SortingOrderNo,
		SOR.SortingOrderNo AS ID,
		--sor.prio as sortrownumber,
		
		LTRIM(str(sor.SortingOrderNo)) + LTRIM(str(sor.SortingOrderRowNo)) as RunOrderRowId,
		sr.runcomparisonid,
		sr.sortgroup,
		gd.GradeNo AS GradeNumber,
		gd.GradeName,
		msrclassLU.Receptnamn as msrclass,
		pg.NominalThicknessMM as thickness_nominal,
		pg.ActualThicknessMM as thickness_actual,
		pg.NominalWidthMM as width_nominal,
		pg.ActualWidthMM as width_actual,
		RPG.scannerLength as ScannerLength,
		RPG.cutLength as CutLength,
		rpg.activatewhendonelinkID,
		CAST(rpg.Ignoreproductparameters as bit) as Ignoreproductparameters,
		CAST(rpg.active as bit) as RemaActive,
		sr.Trays,
		sr.traysString,
		sr.max_pieces,
		sr.doublepackage,
		sr.cut_type,
		sr.prio as fack_prio,
		sr.prio_discharge,
		sr.register,
		sr.info,
		sr.margin,
		sr.value,
		sf.SurfacingNo as surface,
		sf.SurfacingName as surface_text,

		sc.SpeciesNo as species,
		sc.SpeciesName as species_text,
		--gd.GradeNo as quality,
		--gd.GradeName as quality_text,

	  CASE WHEN sor.SizeFormat = 1 THEN str(pg.ActualThicknessMM)
	  WHEN sor.SizeFormat = 2 THEN str(pg.NominalThicknessMM)
	  WHEN sor.SizeFormat = 3 THEN pg.NominalThicknessINCH
	  End AS thickness_override,
	  
	  CASE WHEN sor.SizeFormat = 1 THEN str(pg.ActualWidthMM)
	  WHEN sor.SizeFormat = 2 THEN str(pg.NominalWidthMM)
	  WHEN sor.SizeFormat = 3 THEN pg.NominalWidthINCH
	  End AS width_override,
	  
	  CASE WHEN sor.LengthFormat = 1 THEN str(pl.ActualLengthMM)
	  WHEN sor.LengthFormat = 3 THEN str(pl.NominalLengthFEET)
	  WHEN sor.LengthFormat = 4 THEN pl.ActualLengthINCH
	  End AS length_override,
	  
	  
	  
		PrinterSide.ReceptNamn as printer_side,
		PrinterTop1.ReceptNamn as printer_top1,
		PrinterTop2.ReceptNamn as printer_top2,
		PrinterTop3.ReceptNamn as printer_top3,
		PrinterTop4.ReceptNamn as printer_top4,
		PrinterTop5.ReceptNamn as printer_top5,
		Printerautolabel.ReceptNamn as printer_autolabel,
		
		
/* Recept name Git */
		gtin_13.ReceptNamn as gtin_13,
		gtin_1.ReceptNamn as [gtin_1_package],
		gtin_12.ReceptNamn as [gtin_12_package],
		gtin_14.ReceptNamn as [gtin_14_package],
		gtin_bundle.ReceptNamn as gtin_bundle,
    
    		
		LabelLayout.PackageLogLayoutName as label_layout,
		admt.number_of_labels,
		admt.vilmabasid,
		admt.[description],

		--sor.Mark as customer_reference,
		sor.Info1 as info_1,
		sor.Info2 as info_2,
		
		-- Changed from stp.ProgramNo to stp.ProgramID 
		stp.ProgramID as StackerProgram,		
		stp.ProgramNamn as StackerRecept,
		stp.thickness as StackerThickness,
		stp.width as StackerWidth,
		stp.[length] as StackerLength,
		boardscannerProgram.ReceptNamn as BoardScannerProgram,
		boardscannerProgram.[Description] as BoardScannerRecept,

		st.number_of_rows,
		st.rows_until_first_stick,
		st.rows_between_sticks,
		st.boards_per_row_1,
		st.boards_per_row_2,
		CAST(CASE WHEN st.stick_dispenser_1 = 0 THEN 0
		ELSE 1 END as bit) as stick_dispenser_1,
		CAST(CASE WHEN st.stick_dispenser_2 = 0 THEN 0
		ELSE 1 END as bit) as  stick_dispenser_2,
		CAST(CASE WHEN st.stick_dispenser_3 = 0 THEN 0
		ELSE 1 END as bit) as  stick_dispenser_3,
		CAST(CASE WHEN st.stick_dispenser_4 = 0 THEN 0
		ELSE 1 END as bit) as  stick_dispenser_4,
		CAST(CASE WHEN st.stick_dispenser_5 = 0 THEN 0
		ELSE 1 END as bit) as  stick_dispenser_5,
		CAST(CASE WHEN st.stick_dispenser_6 = 0 THEN 0
		ELSE 1 END as bit) as  stick_dispenser_6,
		Press1.[Description] as PressReceptNamn1,
		Press1.ReceptNamn as PressReceptProgram1,
		ptv.lifter_1_group,
		ptv.lifter_1_quantity,
		Press2.[Description]  as PressReceptNamn2,
		Press2.ReceptNamn as PressReceptProgram2,
		Plastic.ReceptNamn as plastic_type,
		ptv.lifter_2_group,
		ptv.lifter_2_quantity,	
		ptv.package_outfeed,	
		RPGC.species as RemaSpecies,
		RPGC.maxleftcut,
		RPGC.maxrightcut,
		RPGC.minleftcut,
		RPGC.minrightcut,
		RPGC.minmoisture,
		RPGC.maxmoisture,
		RPGC.targetmoisture,
		RPGC.roundingmodule,
		--GV.batchid, --körorder
		planerProgram.[Description] as PlanerRecept,
		planerProgram.ReceptNamn as PlanerProgram,

		intakeProgram.[Description] as PlanerInFeedRecept,
		intakeProgram.ReceptNamn as PlanerInFeedProgram,
		GV.intake_thickness as PlanerInFeedThickness,
		GV.intake_width as PlanerInFeedWidth,
		sor.Languagecode
		
		/*GV.length_nom_1 as length_nom_1,
		GV.length_nom_2 as length_nom_2,
		GV.length_nom_3 as length_nom_3,
		GV.length_nom_4 as length_nom_4,
		GV.length_act_1 as length_act_1,
		GV.length_act_2 as length_act_2,
		GV.length_act_3 as length_act_3,
		GV.length_act_4 as length_act_4*/

		FROM dbo.SortingOrderRow SOR
		Left Outer Join dbo.ProdInstru pin on pin.ProdInstruNo = SOR.ProdInstructNo
		Left Outer Join dbo.ProductLength pl on pl.ProductLengthNo = SOR.ProductLengthNo
		Left Outer Join dbo.SupplierShippingPlan SSP on SSP.SupplierShipPlanObjectNo = SOR.CSDNo
		Left Outer Join dbo.CustomerShippingPlanDetails CSD on CSD.CustShipPlanDetailObjectNo = SSP.CustShipPlanDetailObjectNo
		left outer join [dbo].[DelperSSPCDS_defsspno] LEV ON LEV.Defsspno = SOR.CSDNo
		INNER JOIN      dbo.Product pd ON pd.ProductNo = SOR.ProductNo
		INNER JOIN      dbo.ProductGroup pg ON pd.ProductGroupNo = pg.ProductGroupNo
		INNER JOIN      dbo.Grade gd ON pd.GradeNo = gd.GradeNo
						AND gd.LanguageCode = 1
		INNER JOIN      dbo.ProductCategory pc ON       pg.ProductCategoryNo = pc.ProductCategoryNo
						AND pc.LanguageCode = 1
		INNER JOIN      dbo.Species sc ON pg.SpeciesNo = sc.SpeciesNo
						AND sc.LanguageCode = 1
		INNER JOIN      dbo.Surfacing sf ON pg.SurfacingNo = sf.SurfacingNo
						AND sf.LanguageCode = 1
						
		LEFT OUTER JOIN dbo.Remaproductgroup RPG on RPG.WorkOrderID = SOR.SortingOrderNo
		and RPG.SortingOrderRowNo = SOR.SortingOrderRowNo
		left join dbo.ProdParam boardscannerProgram on boardscannerProgram.ReceptID = RPG.ID
		and boardscannerProgram.ProdParamID = 15

		LEFT OUTER JOIN dbo.Remaproductgroupcollection RPGC on RPGC.runID = SOR.SortingOrderNo
		

		LEFT OUTER JOIN dbo.generalvalues GV 
		left join dbo.ProdParam planerProgram on planerProgram.ReceptID = GV.planer_program
		and planerProgram.ProdParamID = 16
		
		left join dbo.ProdParam intakeProgram on intakeProgram.ReceptID = GV.intake_program
		and intakeProgram.ProdParamID = 17
		on GV.batchid = SOR.SortingOrderNo

		LEFT OUTER JOIN [dbo].[admintabvalues] admt	
		left join dbo.ProdParam PrinterSide on PrinterSide.ReceptID = admt.printer_side
		and PrinterSide.ProdParamID = 18
		left join dbo.ProdParam Printertop1 on Printertop1.ReceptID = admt.printer_top1
		and Printertop1.ProdParamID = 19
		left join dbo.ProdParam Printertop2 on Printertop2.ReceptID = admt.printer_top2
		and Printertop2.ProdParamID = 20
		left join dbo.ProdParam Printertop3 on Printertop3.ReceptID = admt.printer_top3
		and Printertop2.ProdParamID = 32
		left join dbo.ProdParam Printertop4 on Printertop4.ReceptID = admt.printer_top4
		and Printertop2.ProdParamID = 33
		left join dbo.ProdParam Printertop5 on Printertop5.ReceptID = admt.printer_top5
		and Printertop2.ProdParamID = 34
		left join dbo.ProdParam PrinterAutolabel on PrinterAutolabel.ReceptID = admt.printer_autolabel
		and PrinterAutolabel.ProdParamID = 21
		

	/* Added reference to prodparam for git'ns */		
		left join dbo.ProdParam gtin_13 on gtin_13.ReceptID = admt.gtin_13
		and gtin_13.ProdParamID = 31
		left join dbo.ProdParam gtin_1 on gtin_1.ReceptID = admt.[gtin_1_package]
		and gtin_1.ProdParamID = 26
		
		left join dbo.ProdParam gtin_12 on gtin_12.ReceptID = admt.[gtin_1_package]
		and gtin_12.ProdParamID = 27
		
		left join dbo.ProdParam gtin_14 on gtin_14.ReceptID = admt.[gtin_1_package]
		and gtin_14.ProdParamID = 28				
		
		left join dbo.ProdParam gtin_bundle on gtin_bundle.ReceptID = admt.[gtin_1_package]
		and gtin_bundle.ProdParamID = 29
/* End reference to prodparam for git'ns */		

		Left outer join dbo.PackageLogLayout LabelLayout on LabelLayout.PackageLogLayoutNo = admt.label_layout

		on admt.ID = sor.SortingOrderNo
			and admt.SortingOrderRowNo = sor.SortingOrderRowNo
			
			
		LEFT OUTER JOIN dbo.stackertabvalues st on st.SortingOrderRowNo = sor.SortingOrderRowNo
			and st.ID = sor.SortingOrderNo
			
		LEFT OUTER JOIN dbo.stackertabvaluesProgram stp on stp.ProgramNo = st.ProgramNo

		LEFT OUTER JOIN dbo.presstabvalues ptv 
		left join dbo.ProdParam Press1 on Press1.ReceptID = ptv.press_1
		and Press1.ProdParamID = 23

		left join dbo.ProdParam Press2 on Press2.ReceptID = ptv.press_2
		and Press2.ProdParamID = 24

		left join dbo.ProdParam Plastic on Plastic.ReceptID = ptv.plastic_type
		and Plastic.ProdParamID = 30

		on ptv.SortingOrderRowNo = sor.SortingOrderRowNo
			and ptv.ID = sor.SortingOrderNo
			
		LEFT OUTER JOIN dbo.sortrows sr 
		left join dbo.ProdParam msrclassLU on msrclassLU.ReceptID = sr.msrclass
		and msrclassLU.ProdParamID = 25
		on sr.SortingOrderRowNo = sor.SortingOrderRowNo
		and sr.ID = sor.SortingOrderNo
				
	WHERE SOR.SortingOrderNo = @ID


END

