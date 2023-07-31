//==============================================================================
//   Coverlap Toolset: Object-based colocalization with overlap threshold
//==============================================================================

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Global variables initialization:
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

var sourceDirectory;
var outputDirectory;
var imageFilesList;
var maxFilesList;

var folderOrganization = "One subfolder per image";
var makeComposite = true;
var luts;
var target1 = "ERG";
var target2 = "EdU";
var channel1 = "C1";
var channel2 = "C2";
var region1 = "ACC";
var region2 = "CP";
var nameToFind = "Scan1";
var extensionToFind = "nd";

var lowThresholdT1R1 = 10;
var lowThresholdT1R2 = 10;
var lowThresholdT2R1 = 50;
var lowThresholdT2R2 = 50;
var minSizeT1 = 120;
var minSizeT2 = 250;
	
var	medT1x = 5;
var	medT1y = 5;
var	medT1z = 2;
var	gaussianT1x = 1;
var	gaussianT1y = 1;
var	gaussianT1z = 1;
var sbBackgroundT1 = 5;
var watershedT1 = false;
var watershedRadiusT1 = 0;
	
var	medT2x = 4;
var	medT2y = 4;
var	medT2z = 2;
var	gaussianT2x = 1;
var	gaussianT2y = 1;
var	gaussianT2z = 1;
var sbBackgroundT2 = 10;
var watershedT2 = true;
var watershedRadiusT2 = 5;

var overlapThr = 50;
var excludeEdges = true;

var ask4ROIs = true;
var useNewOverlap = "No";
var newOverlapThr = 0;
var sampleName;
var stackChanged;

var screenW = 0;
var screenH = 0;


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Macros:
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//------------------------------------------------------------------------------
macro "Macro 1: Creation of Max Intensity Projection images Action Tool - N66C000D0aD0bD0cD0dD0eD18D19D1aD1bD1cD1dD1eD27D28D29D35D36D44D45D53D54D62D63D72D73D82D8aD8bD91D92D99D9aD9bDa0Da1Da8Da9DaaDb0Db1Db7Db8Db9DbaDc0Dc1Dc6Dc7Dc8Dc9DcaDcbDccDcdDceDd0Dd1Dd5Dd6Dd7Dd8Dd9DdaDdbDdcDddDdeDe0De1De6De7De8De9DeaDebDecDedDeeCaecC000DabCfffD00D01D02D03D04D05D06D07D08D09D10D11D12D13D14D15D16D17D20D21D22D23D24D25D30D31D32D33D34D40D41D42D43D50D51D52D60D61D70D71D80D90Ce9aD2aD2bD2dD2eD39D3aD3bD3cD3dD3eD46D47D48D49D4aD4bD4cD4dD4eD55D56D57D58D59D5aD5bD5cD5dD5eD65D66D67D68D69D6aD6bD6dD6eD74D75D76D77D78D79D7aD7cD7dD7eD83D84D85D86D87D88D89D8cD8dD8eD93D94D95D96D97D98D9cD9dD9eDa2Da3Da4Da5Da6Da7DacDadDb2Db3Db4Db5DbbDbcDbdDbeDc2Dc3Dc4Dc5Dd2Dd3Dd4De2De3De4Cd9aD2cD38D64DaeC100C000D26D37D81Cd8aD6cD7bDb6De5C111Bf0C000D01D11D12D21D22D32D33D42D43D53D64D65D75D76D86D87D88D89D98D99D9aD9bD9cD9dD9eDaaDabDacDadDaeCaecD0bD0cD0dD0eD1aD1bD1cD1dD1eD29D2aD2bD2cD2dD2eD38D39D3aD3bD3cD3dD3eD47D48D49D4aD4bD4cD4dD4eD56D57D58D59D5aD5bD5cD5dD5eD66D67D68D69D6aD6bD6cD6dD6eD78D79D7aD7bD7cD7dD7eD8aD8bD8cD8dD8eC000CfffD10D20D30D31D40D41D50D51D52D60D61D62D63D70D71D72D73D74D80D81D82D83D84D85D90D91D92D93D94D95D96D97Da0Da1Da2Da3Da4Da5Da6Da7Da8Da9Ce9aD02D03D04D05D06D07D08D09D0aD13D14D15D16D17D18D19D23D24D25D26D27D28D35D36D37D44D45D46Cd9aD34D55C100D54C000D77Cd8aC111D00B0fC000D09D0aD18D19D28D29D37D38D47D48D56D57D65D66D74D75D81D82D83D84D90D91Da0CaecD00D01D02D03D04D05D06D07D08D10D11D12D13D14D15D16D17D20D21D22D23D24D25D26D27D30D31D32D33D34D35D36D40D41D42D43D44D45D46D50D51D52D53D54D55D60D61D62D63D64D70D71D72D80C000CfffD1aD2aD39D3aD49D4aD58D59D5aD67D68D69D6aD76D77D78D79D7aD85D86D87D88D89D8aD93D94D95D96D97D98D99D9aDa1Da2Da3Da4Da5Da6Da7Da8Da9DaaCe9aCd9aC100C000D73Cd8aC111D92Nf0C000D00D10D11D12D21D22D23D24D33D34D35D45D46D56D57D67D68D77D78D88D89D98D99Da9DaaDb9DbaDc0Dc1Dc2Dc3Dc4Dc9DcaDd0Dd1Dd2Dd3Dd4Dd9DdaDe0De1De2De3De4De9DeaCaecD65D66D74D75D76D83D84D85D86D87D92D93D94D95D96D97Da1Da2Da3Da4Da5Da6Da7Da8Db0Db1Db2Db3Db4Db5Db6Db7Db8Dc5Dc6Dc7Dc8Dd5Dd6Dd7Dd8De5De6De7De8C000CfffD01D02D03D04D05D06D07D08D09D0aD13D14D15D16D17D18D19D1aD25D26D27D28D29D2aD36D37D38D39D3aD47D48D49D4aD58D59D5aD69D6aD79D7aD8aD9aCe9aD20D30D31D32D40D41D42D43D44D50D51D52D53D54D60D61D62D63D64D70D71D72D73D80D81D82D90D91Da0Cd9aD55C100C000Cd8aC111" { // The containing folder for each image should be the animal/sample ID

	cleanUp();
	GUIMacro1();
	maxIntensityProjection();
	close("imageFilesList");
	print("A MIP has been successfully created for all of the images.");
	beep();
}

//------------------------------------------------------------------------------
macro "Macro 2: Testing of parameters for nuclear markers segmentation Action Tool - N66C000D0aD0bD0cD0dD0eD18D19D1aD1bD1cD1dD1eD27D28D29D35D36D44D45D53D54D62D63D72D73D82D91D92D98D99D9aDa0Da1Da7Da8Da9DaaDabDb0Db1Db6Db7Db8DbbDc0Dc1Dc6Dc7Dc8DceDd0Dd1Dd6Dd7Dd8DdcDddDdeDe0De1De6De7De8De9DeaDebDecDedC9ecC000D26D37D81DeeCfffD00D01D02D03D04D05D06D07D08D09D10D11D12D13D14D15D16D17D20D21D22D23D24D25D30D31D32D33D34D40D41D42D43D50D51D52D60D61D70D71D80D90CaecCe9aD2aD2bD2dD2eD39D3aD3bD3cD3dD3eD46D47D48D49D4aD4bD4cD4dD4eD55D56D57D58D59D5aD5bD5cD5dD5eD65D66D67D68D69D6aD6bD6cD6dD6eD74D75D76D77D78D79D7aD7bD7cD7dD7eD83D84D85D86D87D88D89D8aD8bD8cD8dD8eD93D94D95D96D97D9bD9cD9dD9eDa2Da3Da4Da5Da6DacDadDb2Db3Db4Db5Db9DbcDbdDbeDc2Dc3Dc4Dc5Dc9DcaDcbDccDcdDd2Dd3Dd4Dd5Dd9DdaDe2De3De4De5C9ecCd8aDbaDdbC100Cd9aD2cD38D64DaeC111C101Bf0C000D01D07D08D09D0aD0bD0cD11D12D18D19D1aD1bD21D22D32D33D42D43D53D64D65D75D76D86D87D88D89D98D99D9aD9bD9cD9dD9eDaaDabDacDadDaeC9ecC000D77CfffD10D20D30D31D40D41D50D51D52D60D61D62D63D70D71D72D73D74D80D81D82D83D84D85D90D91D92D93D94D95D96D97Da0Da1Da2Da3Da4Da5Da6Da7Da8Da9CaecD0dD0eD1dD1eD29D2aD2bD2cD2dD2eD38D39D3aD3bD3cD3dD3eD47D48D49D4aD4bD4cD4dD4eD56D57D58D59D5aD5bD5cD5dD5eD66D67D68D69D6aD6bD6cD6dD6eD78D79D7aD7bD7cD7dD7eD8aD8bD8cD8dD8eCe9aD02D03D04D05D06D13D14D15D16D17D23D24D25D26D27D28D35D36D37D44D45D46C9ecD1cCd8aC100D54Cd9aD34D55C111D00C101B0fC000D03D04D09D0aD13D14D18D19D23D24D28D29D37D38D47D48D56D57D65D66D74D75D81D82D83D84D90D91Da0C9ecD34C000D73CfffD1aD2aD39D3aD49D4aD58D59D5aD67D68D69D6aD76D77D78D79D7aD85D86D87D88D89D8aD93D94D95D96D97D98D99D9aDa1Da2Da3Da4Da5Da6Da7Da8Da9DaaCaecD00D01D02D05D06D07D08D10D11D12D15D16D17D20D21D22D25D26D27D30D31D32D33D35D36D40D41D42D43D44D45D46D50D51D52D53D54D55D60D61D62D63D64D70D71D72D80Ce9aC9ecCd8aC100Cd9aC111D92C101Nf0C000D00D10D11D12D21D22D23D24D33D34D35D45D46D56D57D67D68D77D78D82D83D84D88D89D92D93D94D98D99Da1Da2Da3Da4Da9DaaDb0Db1Db2Db3Db4Db9DbaDc0Dc1Dc3Dc4Dc9DcaDd0Dd3Dd4Dd9DdaDe3De4De9DeaC9ecC000CfffD01D02D03D04D05D06D07D08D09D0aD13D14D15D16D17D18D19D1aD25D26D27D28D29D2aD36D37D38D39D3aD47D48D49D4aD58D59D5aD69D6aD79D7aD8aD9aCaecD65D66D74D75D76D85D86D87D95D96D97Da5Da6Da7Da8Db5Db6Db7Db8Dc2Dc5Dc6Dc7Dc8Dd1Dd2Dd5Dd6Dd7Dd8De1De2De5De6De7De8Ce9aD20D30D31D32D40D41D42D43D44D50D51D52D53D54D60D61D62D63D64D70D71D72D73D80D81D90Da0C9ecDe0Cd8aC100Cd9aD55C111C101D91" {

	cleanUp();
	GUIMacro2();
	Array.show(maxFilesList);
	Table.setLocationAndSize(screenW*0.7, screenH*0.3, screenW*0.3, screenH*0.6, "maxFilesList");
	
	while (true) {
		
		imageList = getList("image.titles"); 
		
		// If it is a new parameters test on already open channels:
		if ((imageList.length != 0) && (roiManager("count") > 0)) {
			
			ask4ROIs = false;
			
			//Close the open images except the two original channels
			for (i = 0; i < imageList.length ; i++) {
				
				if (!startsWith(imageList[i], channel1) && !startsWith(imageList[i], channel2)) {
			
					selectImage(imageList[i]);
					close();
				}
			}
			
			channelImageList = getList("image.titles");
			if (channelImageList.length == 2) { // Additional check that one of the channels hasn't been closed
				
				getSegmentationParameters();
				ask4ROIs = false; // Overrides if the user has inadvertently checked the box
				analyzeTestROI();
			}
			else {
				
				close("*"); // In case only one channel remains open
			}
		}
		
		// Else if we test parameters on a new image or ROI:
		else {
			
			while (imageList.length != 1) {
				
				close("*"); // In case several MIPs were open
				waitForUser("Open an MIP image you want to work on (double click in the list), then click OK to start \nIf you are done, click on Cancel");
				imageList = getList("image.titles"); 
			}
			
			for (i = 0; i < imageList.length ; i++) {
			
				if (matches(imageList[i],  "^MAX_.*")) {
					
					ask4ROIs = true;
					getSegmentationParameters();
					
					do {
						
						getTestROI();					
						
					} while (roiManager("count") == 0);
					
					analyzeTestROI();
				}
			}
		}
		
		waitForUser("You can examine the Visualization images to see if the outline matches your objects of interest. You can toggle the outline on and off with the Channels Tool.\n\nWhen you're ready for another test: \n- If you want to test different parameters on the same image and ROI, do not close anything and just click OK\n- Else, close all images with MAJ + W and click OK \nIf you are done, click on Cancel"); 
	}
}

//------------------------------------------------------------------------------
macro "Macro 3: Segmentation and 3D colocalization of two nuclear fluorescent markers Action Tool - N66C000D0aD0bD0cD0dD0eD18D19D1aD1bD1cD1dD1eD27D28D29D35D36D44D45D53D54D62D63D72D73D82D91D92D98D99D9aDa0Da1Da7Da8Da9DaaDb0Db1Db6Db7Db8DbcDbdDc0Dc1Dc6Dc7Dc8DccDcdDd0Dd1Dd6Dd7Dd8DdbDdcDe0De1De6De7De8De9DeaDebDecDedC8cbC000CfffD00D01D02D03D04D05D06D07D08D09D10D11D12D13D14D15D16D17D20D21D22D23D24D25D30D31D32D33D34D40D41D42D43D50D51D52D60D61D70D71D80D90CaecDdeDeeCe9aD2aD2bD2dD2eD39D3aD3bD3cD3dD3eD46D47D48D49D4aD4bD4cD4dD4eD55D56D57D58D59D5aD5bD5cD5dD5eD65D66D67D68D69D6aD6bD6cD6dD6eD74D75D76D77D78D79D7aD7bD7cD7dD7eD83D84D85D86D87D88D89D8aD8bD8cD8dD93D94D95D96D97D9bD9cD9dDa2Da3Da4Da5Da6DabDacDadDb2Db3Db4Db5Db9DbaDbbDbeDc2Dc3Dc4Dc5Dc9DcaDcbDd2Dd3Dd4Dd5Dd9DdaDe2De3De4De5C9ecCd8aD8eD9eC100CaecDceCd9aD2cD38D64DaeC000D26D37D81C111C011DddBf0C000D01D07D08D09D0aD0bD0dD0eD11D12D19D1aD1dD1eD21D22D2eD32D33D42D43D53D64D65D75D76D86D87D88D89D98D99D9aD9bD9cD9dD9eDaaDabDacDadDaeC8cbC000D0cCfffD10D20D30D31D40D41D50D51D52D60D61D62D63D70D71D72D73D74D80D81D82D83D84D85D90D91D92D93D94D95D96D97Da0Da1Da2Da3Da4Da5Da6Da7Da8Da9CaecD1bD1cD29D2aD2bD2cD2dD38D39D3aD3bD3cD3dD3eD47D48D49D4aD4bD4cD4dD4eD56D57D58D59D5aD5bD5cD5dD5eD66D67D68D69D6aD6bD6cD6dD6eD78D79D7aD7bD7cD7dD7eD8aD8bD8cD8dD8eCe9aD02D03D04D05D06D13D14D15D16D17D18D23D24D25D26D27D28D35D36D37D44D45D46C9ecCd8aC100D54CaecCd9aD34D55C000D77C111D00C011B0fC000D00D01D02D03D04D09D0aD10D11D12D13D18D19D20D21D22D28D29D37D38D47D48D56D57D65D66D74D75D81D82D83D84D90D91Da0C8cbC000CfffD1aD2aD39D3aD49D4aD58D59D5aD67D68D69D6aD76D77D78D79D7aD85D86D87D88D89D8aD93D94D95D96D97D98D99D9aDa1Da2Da3Da4Da5Da6Da7Da8Da9DaaCaecD05D06D07D08D14D15D16D17D23D24D25D26D27D30D31D32D33D34D35D36D40D41D42D43D44D45D46D50D51D52D53D54D55D60D61D62D63D64D70D71D72D80Ce9aC9ecCd8aC100CaecCd9aC000D73C111D92C011Nf0C000D00D10D11D12D21D22D23D24D33D34D35D45D46D56D57D67D68D77D78D80D81D82D88D89D90D91D92D93D94D98D99Da2Da3Da4Da9DaaDb3Db4Db9DbaDc3Dc4Dc5Dc9DcaDd3Dd4Dd5Dd9DdaDe2De3De4De5De9DeaC8cbD83C000Db5CfffD01D02D03D04D05D06D07D08D09D0aD13D14D15D16D17D18D19D1aD25D26D27D28D29D2aD36D37D38D39D3aD47D48D49D4aD58D59D5aD69D6aD79D7aD8aD9aCaecD65D66D74D75D76D84D85D86D87D95D96D97Da5Da6Da7Da8Db0Db1Db2Db6Db7Db8Dc0Dc1Dc2Dc6Dc7Dc8Dd0Dd1Dd2Dd6Dd7Dd8De0De1De6De7De8Ce9aD20D30D31D32D40D41D42D43D44D50D51D52D53D54D60D61D62D63D64D70D71D72D73Da0C9ecDa1Cd8aC100CaecCd9aD55C000C111C011" {

	cleanUp();
	GUIMacro3();
	if(ask4ROIs) getROIs();
	wait(1000);
	// Initialize 3D Manager
	run("3D Manager");
	analyzeROIs();
	getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
	File.append("End of processing: " + year + "/" + IJ.pad(month + 1, 2) + "/" + IJ.pad(dayOfMonth, 2) + " Time: " + IJ.pad(hour, 2) + ":" + IJ.pad(minute, 2) + ":" + IJ.pad(second, 2), outputDirectory + File.getName(sourceDirectory) + "_DetectionParameters.txt");
	print("\\Clear");
	print("Analysis completed!");
	close("maxFilesList");
	run("3D Manager");
	Ext.Manager3D_Close();
	beep();
}

//------------------------------------------------------------------------------
macro "Macro 4: Verification and correction of images Action Tool - N66C000D0aD0bD0cD0dD0eD18D19D1aD1bD1cD1dD1eD27D28D29D35D36D44D45D53D54D62D63D72D73D7eD82D8cD8dD8eD91D92D9aD9bD9cD9dD9eDa0Da1Da8Da9DaaDabDacDb0Db1Db6Db7Db8Db9DbaDc0Dc1Dc7Dd0Dd1De0De1DecDedDeeCaecDceC000CfffD00D01D02D03D04D05D06D07D08D09D10D11D12D13D14D15D16D17D20D21D22D23D24D25D30D31D32D33D34D40D41D42D43D50D51D52D60D61D70D71D80D90CaecDddDdeCe9aD2aD2bD2dD2eD39D3aD3bD3cD3dD3eD46D47D48D49D4aD4bD4cD4dD4eD55D56D57D58D59D5aD5bD5cD5dD5eD65D66D67D68D69D6aD6bD6cD6dD6eD74D75D76D77D78D79D7aD7bD7cD83D84D85D86D87D88D89D93D94D95D96D97D98Da2Da3Da4Da5Da6Da7DadDb2Db3Db4Db5DbbDbcDbdDbeDc2Dc3Dc4Dc5DcaDcbDccDcdDd2Dd3Dd4Dd5Dd6Dd7Dd8Dd9DdaDdbDdcDe2De3De4De5De6De7De8De9DeaDebC111D8bD99C100Dc6Dc8Cd9aD2cD38D64DaeC000D26D37D81Cd8aD7dD8aDc9C111Bf0C000D01D0cD0dD0eD11D12D21D22D32D33D42D43D53D64D65D75D76D86D87D88D89D98D99D9aD9bD9cD9dD9eDaaDabDacDadDaeCaecC000CfffD10D20D30D31D40D41D50D51D52D60D61D62D63D70D71D72D73D74D80D81D82D83D84D85D90D91D92D93D94D95D96D97Da0Da1Da2Da3Da4Da5Da6Da7Da8Da9CaecD0bD1aD1bD1cD1dD1eD29D2aD2bD2cD2dD2eD38D39D3aD3bD3cD3dD3eD47D48D49D4aD4bD4cD4dD4eD56D57D58D59D5aD5bD5cD5dD5eD66D67D68D69D6aD6bD6cD6dD6eD78D79D7aD7bD7cD7dD7eD8aD8bD8cD8dD8eCe9aD02D03D04D05D06D07D08D09D0aD13D14D15D16D17D18D19D23D24D25D26D27D28D35D36D37D44D45D46C111C100D54Cd9aD34D55C000D77Cd8aC111D00B0fC000D00D01D02D03D04D05D09D0aD10D11D18D19D21D28D29D37D38D47D48D56D57D65D66D74D75D81D82D83D84D90D91Da0CaecC000D20CfffD1aD2aD39D3aD49D4aD58D59D5aD67D68D69D6aD76D77D78D79D7aD85D86D87D88D89D8aD93D94D95D96D97D98D99D9aDa1Da2Da3Da4Da5Da6Da7Da8Da9DaaCaecD06D07D08D12D13D14D15D16D17D22D23D24D25D26D27D30D31D32D33D34D35D36D40D41D42D43D44D45D46D50D51D52D53D54D55D60D61D62D63D64D70D71D72D80Ce9aC111C100Cd9aC000D73Cd8aC111D92Nf0C000D00D10D11D12D21D22D23D24D33D34D35D45D46D56D57D67D68D70D71D77D78D80D81D88D89D90D91D98D99Da0Da1Da9DaaDb0Db1Db9DbaDc0Dc1Dc9DcaDd0Dd1Dd9DdaDe0De1De2De3De4De5De9DeaCaecC000CfffD01D02D03D04D05D06D07D08D09D0aD13D14D15D16D17D18D19D1aD25D26D27D28D29D2aD36D37D38D39D3aD47D48D49D4aD58D59D5aD69D6aD79D7aD8aD9aCaecD65D66D74D75D76D83D84D85D86D87D92D93D94D95D96D97Da2Da3Da4Da5Da6Da7Da8Db2Db3Db4Db5Db6Db7Db8Dc2Dc3Dc4Dc5Dc6Dc7Dc8Dd2Dd3Dd4Dd5Dd6Dd7Dd8De6De7De8Ce9aD20D30D31D32D40D41D42D43D44D50D51D52D53D54D60D61D62D63D64D72D73D82C111C100Cd9aD55C000Cd8aC111" {
	
	cleanUp();
	run("Set Measurements...", "area redirect=None decimal=9"); // Different from what is in the cleanUp function
	
	useNewOverlap = "No";
	GUIMacro4();
	
	// Open and set location of Results table
	print("\\Clear");
	tableResults = getResultsFileName(outputDirectory, ".*Results\.csv$");
	Table.open(outputDirectory + tableResults);
	Table.setLocationAndSize(screenW*0.7, screenH*0.3, screenW*0.3, screenH*0.2, tableResults);
	print("Working on Results file: " + tableResults);
	
	// Initialize 3D Manager and place it
	run("3D Manager");
	windowList = getList("window.titles");
	windowListLength = lengthOf(windowList);
   
	for (i=0; i<windowListLength; i++) {
		
   		if (startsWith(windowList[i], "RoiManager3D")) {
   			
   			selectWindow(windowList[i]);
   			setLocation(0, screenH*0.1);
   		}
	}
		
	while (true) {
		
		run("Close All");
		waitForUser("Open a Composite image you want to work on (double click in the list), then click OK \nYou can also open and close the corresponding .jpg image for visualisation purposes before clicking OK \nIf you are done, click on Cancel");
		close("Results");
		
		// Makes sure that a single Composite image is open
		imageList = getList("image.titles");
		cond1 = imageList.length != 1;
		cond2 = 0;
		
		if (imageList.length > 0) {
			
			cond2 = !matches(imageList[0],  ".*VisualizationComposite\.tif$");
		}
		
		while (cond1 || cond2) {
			
			run("Close All");
			waitForUser("Open a single Composite image and click OK");
			imageList = getList("image.titles");
			//print(imageList.length);
			
			cond1 = imageList.length != 1;
			
			if (imageList.length > 0) {
				
				cond2 = !matches(imageList[0],  ".*VisualizationComposite\.tif$");
			}
		}
		
		// Retrieves the sample name of the image and selects the appropriate row		
		sampleName = replace(getTitle(), "_VisualizationComposite.tif", "");
		targetRow = lookForRow(sampleName, tableResults);				
		Table.setSelection(targetRow, targetRow, tableResults);
		
		// Performs corrections if wanted
		ask4recount = getBoolean("Do you want to do any of these actions? \n-Modify the ROI \n-Reslice the stack\n-Change the overlap threshold\n-Correct the volume estimation?");
		if (ask4recount) {
			
			print("Working on sample: " + sampleName);
			run("Channels Tool...");
			selectWindow("Channels");
			setLocation(screenW*0.4, 0);
			Stack.setActiveChannels("1110");
			reprocessStack();
			selectWindow(tableResults);
			Table.save(outputDirectory + tableResults);
			Table.setSelection(targetRow, targetRow, tableResults);
						
			if (stackChanged) {
			
				run("Tile");
				waitForUser("You can compare the previous and the new composite images. Click OK when you are ready to move on");
			}
			
			else {
				
				roiManager("select", 2);
				waitForUser("Volume correction has been performed. Click OK when you are ready to move on");
			}		
		}
		
		else {
			
			ask4discard = getBoolean("Do you want to discard this sample?");
			if (ask4discard) {
				
				Dialog.create("Fill in the field with your justification for discarding the image");
				Dialog.addString("Discard explanation: ", "Write here", 50);
				Dialog.addString("Optional Comment: ", "", 50);
				Dialog.show();
				justifDiscard = Dialog.getString();
				optionalComment = Dialog.getString();
				
				Table.set("New Nb slices", targetRow, "", tableResults); 
				Table.set("New ROI Area", targetRow, "", tableResults); 
				Table.set("New ROI Volume mm3", targetRow, "", tableResults);
				Table.set("Corrected Total Area", targetRow, "", tableResults); 
				Table.set("Corrected Volume mm3", targetRow, "", tableResults); 
				Table.set("New" + target1 + " count", targetRow, "", tableResults); 
				Table.set("New" + target2 + " count", targetRow, "", tableResults);
				Table.set("New Overlap % Threshold", targetRow, "", tableResults);
				Table.set("New " + target1 + " in " + target2 + " count", targetRow, "", tableResults);
				Table.set("New " + target2 + " in " + target1 + " count", targetRow, "", tableResults);		
				Table.set("Resliced?", targetRow, "");
				Table.set("New stack", targetRow, "");
				Table.set("ROI changed?", targetRow, "");
				Table.set("OverlapThr changed?", targetRow, "");			
				Table.set("Discard justification", targetRow, justifDiscard, tableResults);
				getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
				Table.set("Appended the", targetRow, "" + year + "/" + IJ.pad(month + 1, 2) + "/" + IJ.pad(dayOfMonth, 2) + " at " + IJ.pad(hour, 2) + ":" + IJ.pad(minute, 2));
				Table.set("Comment", targetRow, optionalComment, tableResults);
				Table.update;
				selectWindow(tableResults);
				Table.save(outputDirectory + tableResults);
				Table.setSelection(targetRow, targetRow, tableResults);
																	
			}
		}
		
		roiManager("reset");
		call("java.lang.System.gc");
	}
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Common Functions:
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//------------------------------------------------------------------------------
function cleanUp() { 
// Cleans up the workspace and sets measurements
	
	// Get screen size
	screenH = screenHeight;
	screenW = screenWidth;
	
	// Close all open windows
	closeAllWindows();
	
	// Run Plugin check
	createEmptyTableActionMacro();
	checkForPlugin("MorphoLibJ...", "IJPB-plugins");
	checkForPlugin("3D ImageJ Suite", "3D ImageJ Suite");
	checkForImageScience();
	
	// Initialize and place Log Window
	print("\\Clear");
	Table.setLocationAndSize(screenW*0.7, 0, screenW*0.3, screenH*0.3, "Log");
	
	// Initialize and place ROI Manager
	roiManager("reset");
	selectWindow("ROI Manager");
	setLocation(screenW*0.55, 0);
	
	// Set necessary options
	RoiManager.restoreCentered(false);
	run("Conversions...", "scale");
	setBackgroundColor(0, 0, 0);	
	run("Set Measurements...", " decimal=9");
	run("Options...", "iterations=1 count=1 black");
	setOption("ExpandableArrays", true); // Enables arrays to extend automatically when elements are added to them
}

//------------------------------------------------------------------------------
function closeAllWindows(){
// Closes all open windows
	
	close("*");
	windowList = getList("window.titles");
	windowListLength = lengthOf(windowList);
   
	for (i=0; i<windowListLength; i++) {
		
   		close(windowList[i]);
	}
}

//------------------------------------------------------------------------------
function createEmptyTableActionMacro(){
// Creates and installs an empty Table Action macro to prevent an error from 
// occuring when double clicking on an item in a table. This will fortunately be
// unecessary as soon as ImageJ is updated ;).

	toolsetPath=getDir("macros")+"toolsets"+File.separator+"TableAction.ijm";
	if (!File.exists(toolsetPath)) {
		
		tableActionString="macro \"Table Action\"{}";
		File.saveString(tableActionString, toolsetPath);
	} 
	run("Install...", "install="+toolsetPath);
	showStatus("Empty Table Action installed");
}

//------------------------------------------------------------------------------
function checkForPlugin(menuName, pluginName) {
// Checks for the existence of a given plugin in a given menu
		
	List.setCommands;
	if(List.get(menuName) == "") {
	
		waitForUser("The " + pluginName + " plugin is missing.\nUse the Manage Update Sites window to install it.");
		run("Update...");
		exit
	} 
	
	else {
		
		showStatus("Check for " + pluginName + " passed");
	}
}

//------------------------------------------------------------------------------
function checkForImageScience() {
// Checks that the update site ImageScience is installed
	
	jarPath = getDirectory("startup")+"jars"+File.separator;
	fileList = getFileList(jarPath);
	
	found = 0;
	
	for(i=0; i<fileList.length; i++) {
		
		if(indexOf(fileList[i], "imagescience")!=-1) {
			
			found = 1;
			break;
		}
	}
	
	if (!found) {
	
		waitForUser("The ImageScience plugin is missing.\nUse the Manage Update Sites window to install it.");
		run("Update...");
		exit
	}
	
	else {
		
		showStatus("Check for ImageScience passed");
	}
}

//------------------------------------------------------------------------------
function getFilesList(dir, lookingForList) { 
// Parses through a folder and returns an array with the files you are lookingFor. 
// lookingForList should always be an array, even if it has only one item
	
	list = getFileList(dir); // Makes a list of what is inside the directory
	fileList = newArray;
	
	for (i = 0; i < list.length; i++) {
		
		if(File.isDirectory(dir + list[i]) && !matches(list[i], "Acquisition/")) { // If the file is a directory, not named Acquisition...
			
			returnedList = getFilesList(dir + list[i], lookingForList); // starts again with what is inside
			fileList = Array.concat(fileList, returnedList); // and replaces fileList with this new list
		}
		 
		else { // else if it finds a file and not another directory...
			
			for (j = 0; j < lookingForList.length; j++) {
				
				if (matches(list[i], lookingForList[j])) { // if the file name contains what we are lookingFor, adds it to the array	
					
					fileList[fileList.length] = replace(dir + list[i], "\\", "/");
				}
			}
		}
	}
	 
	return fileList;
}

//------------------------------------------------------------------------------
function getTargets() {
// Asks the user for target names and channels, and offers to save them into the
// "Test_Parameters.txt" file in the Results folder. If such a file already 
// exists, retrieves it to populate the GUI first.
	
	// Loads Test Parameters if any are saved
	getSavedParameters(outputDirectory + "Test_Parameters.txt");
	
	//Gets targets and channels of interest + file name to look for
	Dialog.create("Specify targets, channels and regions");
	Dialog.addMessage("Channels must start with a C (ex: C1)");
	Dialog.addString("Target 1", target1);
	Dialog.addToSameRow();
	Dialog.addString("Channel", channel1);
	Dialog.addString("Target 2", target2);
	Dialog.addToSameRow();
	Dialog.addString("Channel", channel2);
	Dialog.addMessage("Note that the names of the regions should be included in your sample's name (ex: V1291ACCL1c2)");
	Dialog.addString("Region 1", region1);
	Dialog.addToSameRow();
	Dialog.addString("Region 2", region2);
	
	Dialog.addMessage("Specify the files to look for");
	Dialog.addString("File name", nameToFind);
	Dialog.addToSameRow();
	Dialog.addString("Extension name", extensionToFind);
	
	Dialog.addCheckbox("Save parameters", false);
	Dialog.show();
	
	target1 = Dialog.getString();
	channel1 = Dialog.getString();
	target2 = Dialog.getString();
	channel2 = Dialog.getString();
	region1 = Dialog.getString();
	region2 = Dialog.getString();
		
	nameToFind = Dialog.getString();
	extensionToFind = Dialog.getString();
	
	saveTargets = Dialog.getCheckbox();
	
	// Creates arrays containing the MIPs and the original images
	maxFilesList = getFilesList(sourceDirectory, newArray("^MAX_.*")); // Should always be the same if the 1st macro was used to create MIPs
	imageFilesList = getFilesList(sourceDirectory, newArray("^(?!MAX_).*" + nameToFind + ".*\." + extensionToFind +"$")); // Excludes images that start with "MAX_"
	
	// Creates a list to save target parameters
	if (saveTargets) saveParameters(outputDirectory + "Test_Parameters.txt");
}

//------------------------------------------------------------------------------
function getSegmentationParameters() { 
// Asks the user for segmentation parameters, and offers to save them into a 
// text file in the Results folder (for example "Test_Parameters.txt"). If such  
// a file already exists, retrieves it to populate the GUI first.
	
	// Load Test Parameters if any are saved
	getSavedParameters(outputDirectory + "Test_Parameters.txt");
	
	//Get segmentation parameters
	Dialog.create("Segmentation");
	Dialog.addMessage("Detection parameters:");
	Dialog.addNumber("Low Threshold " + target1 + " " + region1, lowThresholdT1R1);
	Dialog.addToSameRow();
	Dialog.addNumber("Low Threshold " + target1 + " " + region2, lowThresholdT1R2);
	Dialog.addNumber("Minimum Size " + target1, minSizeT1, 0, 3, "px");
	Dialog.addNumber("Low Threshold " + target2 + " " + region1, lowThresholdT2R1);
	Dialog.addToSameRow();
	Dialog.addNumber("Low Threshold " + target2 + " " + region2, lowThresholdT2R2);
	Dialog.addNumber("Minimum Size " + target2, minSizeT2, 0, 3, "px");
	
	Dialog.addNumber("Minimum Overlap for Colocalization ", overlapThr, 0, 3, "%");
	
	Dialog.addMessage("Filtering parameters:"); 
	Dialog.addMessage(target1 + " Filtering:");
	Dialog.addNumber("Median " + target1 + " x", medT1x);
	Dialog.addToSameRow();
	Dialog.addNumber("Gaussian " + target1 + " x", gaussianT1x);
	Dialog.addNumber("Median " + target1 + " y", medT1y);
	Dialog.addToSameRow();
	Dialog.addNumber("Gaussian " + target1 + " y", gaussianT1y);
	Dialog.addNumber("Median " + target1 + " z", medT1z);
	Dialog.addToSameRow();
	Dialog.addNumber("Gaussian " + target1 + " z", gaussianT1z);
	Dialog.addNumber(target1 + " Subtract Background Radius", sbBackgroundT1);

	Dialog.addMessage(target2 + " Filtering:");
	Dialog.addNumber("Median " + target2 + " x", medT2x);
	Dialog.addToSameRow();
	Dialog.addNumber("Gaussian " + target2 + " x", gaussianT2x);
	Dialog.addNumber("Median " + target2 + " y", medT2y);
	Dialog.addToSameRow();
	Dialog.addNumber("Gaussian " + target2 + " y", gaussianT2y);
	Dialog.addNumber("Median " + target2 + " z", medT2z);
	Dialog.addToSameRow();
	Dialog.addNumber("Gaussian " + target2 + " z", gaussianT2z);
	Dialog.addNumber(target2 + " Subtract Background Radius", sbBackgroundT2);

	Dialog.addMessage("Binary operations:");
	Dialog.addCheckbox("Apply watershed on " + target1, watershedT1);
	Dialog.addToSameRow();
	Dialog.addNumber("Radius: ", watershedRadiusT1, 0, 2, "px");
	Dialog.addCheckbox("Apply watershed on " + target2, watershedT2);
	Dialog.addToSameRow();
	Dialog.addNumber("Radius: ", watershedRadiusT2, 0, 2, "px");
	Dialog.addCheckbox("Exclude objects on ROI edges", excludeEdges);
	
	Dialog.addMessage("Do you want to draw ROIs or to keep the one in the ROI manager?");
	Dialog.addCheckbox("Ask for ROIs", ask4ROIs);
	
	Dialog.addMessage("Do you want to save these parameters?");
	Dialog.addCheckbox("Save parameters", false);
	Dialog.show();
	
	lowThresholdT1R1 = Dialog.getNumber();
	lowThresholdT1R2 = Dialog.getNumber();
	minSizeT1 = Dialog.getNumber();
	lowThresholdT2R1 = Dialog.getNumber();
	lowThresholdT2R2 = Dialog.getNumber();
	minSizeT2 = Dialog.getNumber();
	
	overlapThr = Dialog.getNumber();
	
	medT1x = Dialog.getNumber();
	gaussianT1x = Dialog.getNumber();
	medT1y = Dialog.getNumber();
	gaussianT1y = Dialog.getNumber();
	medT1z = Dialog.getNumber();
	gaussianT1z = Dialog.getNumber();
	sbBackgroundT1 = Dialog.getNumber();
	
	medT2x = Dialog.getNumber();
	gaussianT2x = Dialog.getNumber();
	medT2y = Dialog.getNumber();
	gaussianT2y = Dialog.getNumber();
	medT2z = Dialog.getNumber();
	gaussianT2z = Dialog.getNumber();
	sbBackgroundT2 = Dialog.getNumber();
	
	watershedT1 = Dialog.getCheckbox();
	watershedRadiusT1 = Dialog.getNumber();
	watershedT2 = Dialog.getCheckbox();
	watershedRadiusT2 = Dialog.getNumber();
	excludeEdges = Dialog.getCheckbox();
	
	ask4ROIs = Dialog.getCheckbox();
	saveSegmentation = Dialog.getCheckbox();
	
	// Creates a list to save segmentation parameters
	if (saveSegmentation) saveParameters(outputDirectory + "Test_Parameters.txt");
}

//------------------------------------------------------------------------------
function saveParameters(file) {
// Saves a text file in the Results folder (for example "Test_Parameters.txt")
// that contains target parameters and segmentation parameters.
	
	List.clear();
	List.set("target1", target1);
	List.set("target2", target2);
	List.set("channel1", channel1);
	List.set("channel2", channel2);
	List.set("region1", region1);
	List.set("region2", region2);
	List.set("nameToFind", nameToFind);
	List.set("extensionToFind", extensionToFind);
	List.set("lowThresholdT1R1", lowThresholdT1R1);
	List.set("lowThresholdT1R2", lowThresholdT1R2);
	List.set("minSizeT1", minSizeT1);
	List.set("lowThresholdT2R1", lowThresholdT2R1);
	List.set("lowThresholdT2R2", lowThresholdT2R2);
	List.set("minSizeT2", minSizeT2);
	List.set("overlapThr", overlapThr);		
	List.set("medT1x", medT1x);
	List.set("medT1y", medT1y);
	List.set("medT1z", medT1z);
	List.set("gaussianT1x", gaussianT1x);
	List.set("gaussianT1y", gaussianT1y);
	List.set("gaussianT1z", gaussianT1z);
	List.set("sbBackgroundT1", sbBackgroundT1);
	List.set("watershedT1", watershedT1);		
	List.set("watershedRadiusT1", watershedRadiusT1);		
	List.set("medT2x", medT2x);
	List.set("medT2y", medT2y);
	List.set("medT2z", medT2z);
	List.set("gaussianT2x", gaussianT2x);
	List.set("gaussianT2y", gaussianT2y);
	List.set("gaussianT2z", gaussianT2z);
	List.set("sbBackgroundT2", sbBackgroundT2);
	List.set("watershedT2", watershedT2);		
	List.set("watershedRadiusT2", watershedRadiusT2);
	List.set("excludeEdges", excludeEdges);
	File.saveString(List.getList, file);
}

//------------------------------------------------------------------------------
function getSavedParameters(file) { 
// Looks for a previously saved parameters text file (eg. "Test_Parameters.txt")
// in the Results folder and loads them.
	
	if (File.exists(file)) { 
		
		List.clear();
		paramList = File.openAsRawString(file);
		List.setList(paramList);
		target1 = List.get("target1");
		channel1 = List.get("channel1");
		target2 = List.get("target2");
		channel2 = List.get("channel2");
		region1 = List.get("region1");
		region2 = List.get("region2");
		nameToFind = List.get("nameToFind");
		extensionToFind = List.get("extensionToFind");
		lowThresholdT1R1 = List.getValue("lowThresholdT1R1");
		lowThresholdT1R2 = List.getValue("lowThresholdT1R2");
		minSizeT1 = List.getValue("minSizeT1");
		lowThresholdT2R1 = List.getValue("lowThresholdT2R1");
		lowThresholdT2R2 = List.getValue("lowThresholdT2R2");
		minSizeT2 = List.getValue("minSizeT2");
		overlapThr = List.getValue("overlapThr");
		medT1x = List.getValue("medT1x");
		medT1y = List.getValue("medT1y");
		medT1z = List.getValue("medT1z");
		gaussianT1x = List.getValue("gaussianT1x");
		gaussianT1y = List.getValue("gaussianT1y");
		gaussianT1z = List.getValue("gaussianT1z");
		sbBackgroundT1 = List.getValue("sbBackgroundT1");
		watershedT1 = List.getValue("watershedT1");	
		watershedRadiusT1 = List.getValue("watershedRadiusT1");	
		medT2x = List.getValue("medT2x");
		medT2y = List.getValue("medT2y");
		medT2z = List.getValue("medT2z");
		gaussianT2x = List.getValue("gaussianT2x");
		gaussianT2y = List.getValue("gaussianT2y");
		gaussianT2z = List.getValue("gaussianT2z");
		sbBackgroundT2 = List.getValue("sbBackgroundT2");
		watershedT2 = List.getValue("watershedT2");	
		watershedRadiusT2 = List.getValue("watershedRadiusT2");		
		excludeEdges = List.get("excludeEdges");	
	}
}

//------------------------------------------------------------------------------
function normalizeAndCrop() { 
// Normalizes the channel, crops it around the ROI, and converts it into 8-bit

	run("Enhance Contrast...", "saturated=0.35 normalize update process_all");
	roiManager("select", 0);
	run("Crop");
	roiManager("select", 0);
	run("8-bit");
}

//------------------------------------------------------------------------------
function filterChannel(medChannelx, medChannely, medChannelz, gaussianChannelx, gaussianChannely, gaussianChannelz, sbBackgroundChannel) { 
// Filters the channel with the given parameters, using a median Fast Filter 
// from the 3D suite plugin (enable the 3D ImageJ Suite update site, from Thomas
// Boudier), and Fiji's 3D Gaussian Blur. Also uses its rolling ball algorithm 
// to subtract the background.
	
	if (medChannelx != 0) {
		
		run("3D Fast Filters","filter=Median radius_x_pix=" + medChannelx + " radius_y_pix=" + medChannely + " radius_z_pix=" + medChannelz + " Nb_cpus=12");
	}
	
	else {
	
		run("Duplicate...", "title=3D_Median duplicate");
	}
	
	selectWindow("3D_Median");
	run("Gaussian Blur 3D...", "x=" + gaussianChannelx + " y=" + gaussianChannely + " z=" + gaussianChannelz + "");
	
	if (sbBackgroundChannel != 0) {
	
		run("Subtract Background...", "rolling=" + sbBackgroundChannel + " disable stack");
	}
	
	roiManager("Select", 1);
	run("Clear Outside", "stack");
}

//------------------------------------------------------------------------------
function segmentChannel(targetName, lowThreshold, minSize, watershed, watershedRadius) { 
// Segments the channel with the given parameters, using the 3D Simple 
// Segmentation in the 3D suite plugin (enable the 3D ImageJ Suite update site, 
// from Thomas Boudier).
	
	// Segment the filtered image, using minimum size threshold
	run("3D Simple Segmentation", "low_threshold=" + lowThreshold + " min_size=" + minSize + " max_size=-1");
	close("Bin");	
	selectWindow("Seg");
	getVoxelSize(width, height, depth, unit);
	width = parseFloat(d2s(width, 4));
	height = parseFloat(d2s(height, 4));
	depth = parseFloat(d2s(depth, 4));
	
	if (watershed) {
		
		run("3D Watershed Split", "binary=Seg seeds=Automatic radius=" + watershedRadius);
		close("EDT");
		close("Seg");
		selectWindow("Split");
		setVoxelSize(width, height, depth, unit); 
	}

	if (excludeEdges) {
		
		run("8-bit");
		setThreshold(1, 255);
		run("Make Binary", "background=Dark black");
		rename(sampleName + "_Bin" + targetName);
	
		// Draw ROI through the stack
		roiManager("Select", 1);
		roiManager("Set Line Width", 2);
		setForegroundColor(255, 255, 255);
		run("Draw", "stack");
		
		// Transform Binary back into Segmentation image
		run("3D Simple Segmentation", "low_threshold=1 min_size=0 max_size=-1");
		close("Bin");
		close(sampleName + "_Bin" + targetName);
		selectImage("Seg");	
		run("Remove Largest Label"); // "Largest" voxel count
		close("Seg");
		selectImage("Seg-killLargest");
	}
		
	rename(sampleName + "_Seg" + targetName);
}

//------------------------------------------------------------------------------
function colocOverlapAnalysis(imageA, imageB, overlapThreshold, name3Drois, recount) { 
// Performs the colocalization analysis and saves its results and control images
	
	labels = getColocLabels(imageA, imageB, overlapThreshold);
	colocFound = false;
	
	if (labels.length > 1) {
		
		colocFound = true;
		// Now transform a "fake double array" into two arrays corresponding to
		// the overlapping labels exceeding the desired % of overlap threshold:
		labelsString = String.join(labels);
		subA = substring(labelsString, 0, indexOf(labelsString, "X") - 2);
		subB = substring(labelsString, indexOf(labelsString, "X") + 3 , lengthOf(labelsString));
		labelsA = makeIntAndSort(subA);
		labelsB = makeIntAndSort(subB);
		//Array.print("LabelsA: ", labelsA);
		//Array.print("LabelsB: ", labelsB);
	
		// Keep all objects that are in the labels arrays using MorphoLibJ 
		selectWindow(imageA);
		run("Select Label(s)", "label(s)=[" + String.join(labelsA) + "]");
		rename("ColocOverlapTh_" + imageA);
		selectWindow(imageB);
		run("Select Label(s)", "label(s)=[" + String.join(labelsB) + "]");
		rename("ColocOverlapTh_" + imageB);

		// Save 3D ROIs of colocalizations
		save3DROIS(imageA, imageB, labelsA, labelsB, target1, target2, name3Drois);
	}
	
	// Save results
	countColoc(imageA, imageB, recount);
	
	// Save control images
	saveColocControl(imageA, imageB, recount);

	// Close overlap segmentation images
	close("ColocOverlapTh_" + imageA);
	close("ColocOverlapTh_" + imageB);
}

//------------------------------------------------------------------------------
function getColocLabels(imageA, imageB, overlapThreshold) { 
// Returns a "fake double array" split by the letter "X", containing labels 
// from image A left of the "X", and from image B right of the "X", if they
// overlap objects or have overlapping objects from the other image, and if the
// % of overlap meets or exceeds the chosen threshold.

	labels = newArray("X");

	// Objects of image A having overlapping objects of image B:
	run("3D MultiColoc", "image_a=" + imageA + " image_b=" + imageB + "");
		
	// If imageA is empty, output an empty table
	if (!isOpen("Colocalisation")){
		Table.create("Colocalisation");
	}
	
	selectWindow("Colocalisation");
	Table.rename("Colocalisation", "Colocalisation" + imageA);
	Table.setLocationAndSize(screenW*0.25, 0, screenW*0.15, screenH*0.20, "Colocalisation" + imageA);		
	nbRows = Table.size;
	headings = split(Table.headings); // Array of Colocalisation Table headings 
	maxObjects = (lengthOf(headings)-1)/3; // Max number of objects B that can be found for a single Object A

	// Find out for each object B found if it exceeds the threshold, add those 
	// who do, and if you find at least one, also add the overlapped object A
	for (j = 0; j < nbRows; j++) {
		
		percArray = newArray();
		flag = false;
		
		for (k = 1; k < maxObjects + 1 ; k++) {
			
			if (Table.get("P" + k, j) > overlapThreshold) {
				
				labels = Array.concat(labels, Table.get("O" + k, j)); // Add right of "X"
				flag = true; // We flag if at least one object B exceeds the threshold
			}
		}
						
		if (flag) { // Add flagged object A to labels A left of "X"
			
			labels = Array.concat(Table.get("LabelObj", j), labels); // Add left of "X" 	
		}
	}
	
	// Objects of image B having overlapping objects of image A:
	run("3D MultiColoc", "image_a=" + imageB + " image_b=" + imageA + "");
	
	// If imageB is empty, output an empty table
	if (!isOpen("Colocalisation")){
		Table.create("Colocalisation");
	}
	
	selectWindow("Colocalisation");
	Table.rename("Colocalisation", "Colocalisation" + imageB);
	Table.setLocationAndSize(screenW*0.40, 0, screenW*0.15, screenH*0.20, "Colocalisation" + imageB);					
	nbRows = Table.size;
	headings = split(Table.headings); // Array of Colocalisation Table headings
	maxObjects = (lengthOf(headings)-1)/3; // Max number of objects A that can be found for a single Object B

	// Find out for each object A found if it exceeds the threshold, add those 
	// who do, and if you find at least one, also add the overlapped object B
	for (j = 0; j < nbRows; j++) {
		
		percArray = newArray();
		flag = false;
		
		for (k = 1; k < maxObjects + 1 ; k++) {
			
			if (Table.get("P" + k, j) > overlapThreshold) {
				
				labels = Array.concat(Table.get("O" + k, j), labels); // Add left of "X"
				flag = true; // We flag if at least one object A exceeds the threshold
			}
		}
						
		if (flag) { // Add flagged object to labels B
			
			labels = Array.concat(labels, Table.get("LabelObj", j)); // Add right of "X"		
		}
	}
	//print("Labels: ");
	//Array.print(labels);
	return labels;
}

//------------------------------------------------------------------------------
function makeIntAndSort(string) {
// This function is called "Oh IJ1, why must you make my life so miserable?"
// It takes a substring containing numbers that are of type "string", turns it 
// into an array, transforms each element into an integer, sorts the array, 
// removes duplicates, and returns it.

	labels = split(string, ", ");
	
	for (j = 0; j < labels.length; j++) {
		
		labels[j] = parseInt(labels[j]);
	}
	
	labels = Array.sort(labels);
	labelsNoDuplicates = newArray(); 
	labelsNoDuplicates = Array.concat(labelsNoDuplicates, labels[0]);
	
	for (j = 1; j < labels.length; j++) {
		
		if (labels[j] != labels[j-1]) {
			
			labelsNoDuplicates = Array.concat(labelsNoDuplicates, labels[j]);
		}
	}
	
	return labelsNoDuplicates;
}

//------------------------------------------------------------------------------
function save3DROIS(imageA, imageB, labelsImageA, labelsImageB, targetA, targetB, saveName) { 
// 	Saves 3D ROIs 
	
	//Send labels to 3D Manager
	
	selectWindow("ColocOverlapTh_" + imageA);
	Ext.Manager3D_AddImage();
	selectWindow("ColocOverlapTh_" + imageB);
	Ext.Manager3D_AddImage();
	
	// Rename objects with a Labels A or B tag
	Ext.Manager3D_DeselectAll();
	Ext.Manager3D_MonoSelect();
	for (j = 0; j < labelsImageA.length; j++) {
	
		Ext.Manager3D_Select(j);
		Ext.Manager3D_Rename("obj" + (j+1) + "-val" + labelsImageA[j] + targetA);
	}
	
	for (j = labelsImageA.length; j < (labelsImageA.length + labelsImageB.length); j++) {
	
		Ext.Manager3D_Select(j);
		Ext.Manager3D_Rename("obj" + (j+1) + "-val" + labelsImageB[j - labelsImageA.length] + targetB);
	}
		
	// Save 3D ROIs in the Results folder
	Ext.Manager3D_DeselectAll();
	Ext.Manager3D_SelectAll();
	Ext.Manager3D_Save(outputDirectory + sampleName + saveName);
	Ext.Manager3D_Reset();
	//Ext.Manager3D_Close();
}

//------------------------------------------------------------------------------
function countColoc(imageA, imageB, recount) { 
// Gets the colocalization results and displays them in a Results table

	// Get object counts and close Colocalisation tables
	selectWindow("Colocalisation" + imageA);
	target1Count = Table.size;
	close("Colocalisation" + imageA);
	selectWindow("Colocalisation" + imageB);
	target2Count = Table.size;
	close("Colocalisation" + imageB);
	
	// Get number of colocalizations found
	colocT1T2 = 0;
	colocT2T1 = 0;
	
	if (colocFound) {
	
		colocT1T2 = labelsA.length;
		colocT2T1 = labelsB.length;
	}
	
	if (!recount) {
		
		// Retrieve region name for this sample
		regionName = "";
		if (matches(sampleName, ".*" + region1 + ".*")) {
			
			regionName = region1;
		}
		
		else if (matches(sampleName, ".*" + region2 + ".*")) {
			
			regionName = region2;
		}
		
		// Fill the Results table	
		selectWindow(tableResults);
		Table.set("Group", Table.size, File.getName(File.getParent(parentDirectory)));
		Table.set("Sample", Table.size-1, sampleName);
		Table.set("Target Region", Table.size-1, regionName);
		Table.set("Nb slices", Table.size-1, slices);
		Table.set("Roi Area_(" + unit + "2)", Table.size-1, area);
		Table.set("Total Area(" + unit + "2)", Table.size-1, area*slices);
		Table.set("Roi Volume_(mm3)", Table.size-1, area*slices*depth/1000000000);
		Table.set(target1 + " count", Table.size-1, target1Count); 
		Table.set(target2 + " count", Table.size-1, target2Count);
		Table.set("Overlap % Threshold", Table.size-1, overlapThr)
		Table.set(target1 + " in " + target2 + " count", Table.size-1, colocT1T2);
		Table.set(target2 + " in " + target1 + " count", Table.size-1, colocT2T1);
		getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
		Table.set("Processed the ", Table.size-1, "" + year + "/" + IJ.pad(month + 1, 2) + "/" + IJ.pad(dayOfMonth,2) + " at " + IJ.pad(hour,2) + ":" + IJ.pad(minute, 2) + ":" +  IJ.pad(second, 2));
	}
	
 	if (recount) {
	 		
	 	targetRow = lookForRow(sampleName, tableResults);
		newT1Count = retrieveCount("New count for channel " + target1 + ":");
		newT2Count = retrieveCount("New count for channel " + target2 + ":");
		
		selectWindow(tableResults);
		Table.set("New Nb slices", targetRow, slices); 
		Table.set("New ROI Area", targetRow, area);
		Table.set("New ROI Volume mm3", targetRow, area*slices/1000000000);
		Table.set("Corrected Total Area", targetRow, 0); // placeholder
		Table.set("Corrected Volume mm3", targetRow, 0); // placeholder
		Table.set("New" + target1 + " count", targetRow, newT1Count); 
		Table.set("New" + target2 + " count", targetRow, newT2Count);
		Table.set("New Overlap % Threshold", targetRow, newOverlapThr);
		Table.set("New " + target1 + " in " + target2 + " count", targetRow, colocT1T2);
		Table.set("New " + target2 + " in " + target1 + " count", targetRow, colocT2T1);
		// Adding convenient checks here for what has been modified, comment them out if not interested
		Table.set("Resliced?", targetRow, reSlice);
		if (reSlice)
			Table.set("New stack", targetRow, "[" + fromSlice + "-" + toSlice + "]");
		
		Table.set("ROI changed?", targetRow, askSaveNewRoi);
		if (useNewOverlap == "No") 
			Table.set("OverlapThr changed?", targetRow, 0);
		else 
			Table.set("OverlapThr changed?", targetRow, 1);

		Table.set("Discard justification", targetRow, ""); // placeholder
		Table.update;
 	}
}

//------------------------------------------------------------------------------
function saveColocControl(imageA, imageB, recount) { 
// Saves verification images (one .jpg displaying the ROI 
// and the found colocalizations on the MIP, and one .tif composite image with 
// the binary segmentation for each channel, and the found colocalizations on a  
// third channel. These images will be reused in Macro 4.

	// Transform all images into 8-bit binaries
	imageList = getList("image.titles");
	imageList = Array.deleteValue(imageList, sampleName + "_VisualizationComposite.tif"); // If recount then the original composite should not be modified
	
	for (j = 0; j < imageList.length; j++) {
	
		makeBin(imageList[j]);
	}
	
	if (colocFound) {
		
		// Make an Overlap image from the two Overlap binary images
		imageCalculator("AND create stack", "ColocOverlapTh_" + imageA, "ColocOverlapTh_" + imageB);
		rename("ColocOverlap");
		
		// Prepare the MIP for the colocalization outline for the VisualizationMIP image
		selectImage("ColocOverlap");
		run("Z Project...", "projection=[Max Intensity]");
		rename("MIPColocOverlap");
	}
	
	else {
		
		// Make an empty Overlap image
		selectImage(imageList[0]);
		run("Duplicate...", "title=ColocOverlap duplicate");
		run("Select All");
		setForegroundColor(0, 0, 0);
		run("Fill", "stack");
	}
	
	// Create image with discarded overlapping objects
	imageCalculator("AND create stack", imageA, imageB);
	rename("DiscardedOverlap");
	imageCalculator("Subtract stack", "DiscardedOverlap", "ColocOverlap");	
	
	// Merge into the VisualizationComposite image and save
	run("Merge Channels...", "c1=" + imageB + " c2=" + imageA + " c3=ColocOverlap c4=DiscardedOverlap create ignore");
	
	Stack.setActiveChannels("1110");
	
	if (!recount) {
		
		saveAs(".zip", outputDirectory + sampleName + "_VisualizationComposite"); // If too heavy, change for a ".zip"	
	}
	
	else {
	
		saveAs(".zip", outputDirectory + sampleName + "_VisualizationComposite_Adjusted"); // If too heavy, change for a ".zip"	
	}

	close("DiscardedOverlap");
	
	// Create VisualizationMIP image and save
	open(pathMIP);
	openMIP = getTitle();
	Property.set("CompositeProjection", "Sum");
	Stack.setDisplayMode("composite");
	getDimensions(width, height, channels, slices, frames);
	
	for (c = 0; c < channels; c++) {
		
		String.append("1");
	}
	
	activeChannels = String.buffer;
	Stack.setActiveChannels(activeChannels); 
	roiManager("Select", 0); // OriginalROI
	wait(1000);
	run("Crop");
	if (!recount) {
		
		roiManager("Select", 1); // Cropped ROI
	}
	
	else {
		
		roiManager("Select", 2); // UpdatedROI
	}
	wait(1000);
	Overlay.addSelection("red", 5);
	
	if (colocFound) {

		selectImage("MIPColocOverlap");
		wait(1000);
		run("Create Selection");
		roiManager("add"); 
		roiManager("select", roiManager("count")-1);
		roiManager("rename", "MIPColocs");
		close("MIPColocOverlap");
		selectImage(openMIP);
		if (!recount) {
			
			roiManager("Select", 2);
		}
		else {
			
			roiManager("Select", 3);
		}
		run("Enlarge...", "enlarge=10");
		roiManager("update");
		Overlay.addSelection("red", 3);
	}
	
	if (!recount) {
		
		saveAs(".jpeg", outputDirectory + sampleName + "_VisualizationMIP");
	}
	
	else {
		
		saveAs(".jpeg", outputDirectory + sampleName + "_VisualizationMIP_Adjusted");
	}
	
	close();
}

//------------------------------------------------------------------------------
function makeBin(segImage) {
// Transforms a label image into a binary image
	
	selectImage(segImage);
	if (bitDepth() == 24) {
		run("8-bit");
	}
	Stack.getStatistics(voxelCount, mean, min, max, stdDev);
	setThreshold(1, max);
	run("Make Binary", "background=Dark black");
	run("Original Scale");
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Functions specific to Macro 1:
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//------------------------------------------------------------------------------
function GUIMacro1() { 
// Graphical user interface: source (input) directory + settings for the preprocessing
	
	sourceDirectory = getDirectory("Select the directory containing all the folders with images to project");
	lutChoice = newArray("Yellow", "Magenta", "Cyan", "Green", "Red", "Blue", "Grays", "None");
	
	Dialog.create("Parameters");
	Dialog.addRadioButtonGroup("How are your image files organized?", newArray("One subfolder per image", "One folder for all images"), 1, 2, folderOrganization); 
	Dialog.addMessage("Specify the files to look for");
	Dialog.addString("File name", "Scan1");
	Dialog.addToSameRow();
	Dialog.addString("Extension name", "nd");
	Dialog.addMessage("Parameters for the Maximum Intensity Projections (MIPs)");
	Dialog.addMessage("Choose Channel LUTs (choose \"None\" if your image does not have a third and/or fourth channel or if you do not want a channel to be in the MIP)");
	Dialog.addChoice("C1", lutChoice, "Yellow");
	Dialog.addChoice("C2", lutChoice, "Magenta");
	Dialog.addChoice("C3", lutChoice, "Cyan");
	Dialog.addChoice("C4", lutChoice, "None");
	Dialog.addCheckbox("Uncheck if you do not want channels to be displayed as a composite", makeComposite);
	Dialog.show();
	
	folderOrganization = Dialog.getRadioButton();
	nameToFind = Dialog.getString();
	extensionToFind = Dialog.getString();
	lutC1 = Dialog.getChoice();
	lutC2 = Dialog.getChoice();
	lutC3 = Dialog.getChoice();
	lutC4 = Dialog.getChoice();
	makeComposite = Dialog.getCheckbox();
	
	luts = newArray(lutC1, lutC2, lutC3, lutC4);
	
	imageFilesList = getFilesList(sourceDirectory, newArray("^(?!MAX_).*" + nameToFind + ".*\." + extensionToFind +"$")); // Excludes images that start with "MAX_"
	Array.show(imageFilesList);
	Table.setLocationAndSize(screenW*0.7, screenH*0.3, screenW*0.3, screenH*0.2, "imageFilesList");
	print(imageFilesList.length + " images to process");
}

//------------------------------------------------------------------------------
function maxIntensityProjection() { 
// Projects your images in Max Intensity and saves each MIP in the image folder
	
	dupChannel = newArray();

	for (i = 0; i <= 3; i ++) {
	
		if (luts[i] != "None") {
			
			dupChannel = Array.concat(dupChannel, i + 1);
		}
	}
	
	dupChannel = String.join(dupChannel);
	luts = Array.deleteValue(luts, "None"); 
	
	for (i=0; i<imageFilesList.length; i++) {
		
		setBatchMode(true);
		
		// Opens image number i and pauses until it is actually open
		run("Bio-Formats Importer", "open=[" + replace(imageFilesList[i], "/","\\") + "] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		
		while (nImages==0) {
			
			wait(1000);
		}
		
		// Duplicates and renames the open image according to the folder it is in
		oriName = getTitle();
		oriNameNoExt = File.getNameWithoutExtension(oriName);
		imageDirectory = getInfo("image.directory"); 
		directoryName = File.getName(imageDirectory); 
		run("Make Substack...", "channels=[" + dupChannel + "]");
		rename(directoryName); // Replaces the title of the duplicate image with the name of the directory
		close(oriName); // Closes the original image to save space

		// Projects in max intensity
		run("Z Project...", "projection=[Max Intensity]");
		close(directoryName);
			
		// Gets file infos so you can retrieve the number of channels
		getDimensions(imageWidth, imageHeight, imageChannels, imageSlices, imageFrames);
		
		// Sets the the LUT and the BrightnessContrast for each channels
		for(j=0; j<imageChannels; j++) {
			
			Stack.setChannel(j+1); 
			run(luts[j]);
			run("Enhance Contrast", "saturated=0.1");
		}
		
		// Shows all the channels at once
		if (makeComposite) {
			
			run("Make Composite");
			Property.set("CompositeProjection", "Sum");
			Stack.setDisplayMode("composite");
		}
		
		// Saves the preprocessing step, a Max intensity projection, into each image's original directory
		// If the organization is one subfolder per image:
		if (folderOrganization == "One subfolder per image") {
			
			saveAs("Tiff", imageDirectory + "MAX_"+ directoryName + ".tif");
			print("Image " + i+1 + "/" + imageFilesList.length + " processed: " + directoryName);
		}
		
		// Else if the organization is one folder for all images:
		else {
			
			saveAs("Tiff", imageDirectory + "MAX_"+ oriNameNoExt + ".tif");
			print("Image " + i+1 + "/" + imageFilesList.length + " processed: " + oriName);
		}

		
		
		run("Close All");
		call("java.lang.System.gc");
		
		setBatchMode("exit and display");
	}
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Functions specific to Macro 2:
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//------------------------------------------------------------------------------
function GUIMacro2() { 
// Asks the user for the input/output directories and the target informations. 
// The image directory can be a folder containing other folders with images.

	//Get source and output directories
	sourceDirectory = getDirectory("Please open the directory containing the images you wish to test your parameters on (same as in Macro 1).");
	outputDirectory = getDirectory("Select a results directory where you want to record your parameters and results");
	
	getTargets();
}

//------------------------------------------------------------------------------
function getTestROI() { 
// Allows the selection of a test ROI
	
	roiManager("Reset");
	maxName = getTitle();
	print("Selecting ROI on image " + maxName);
	setTool("polygon");
	Stack.setChannel(2); // Comment this out if you don't want that to happen
	waitForUser("1-Use the selection tool to draw a single region to analyze (the smaller, the faster!)\n2-Press the t key to add it to the RoiManager\n3-Finally, click on OK");
}

//------------------------------------------------------------------------------
function analyzeTestROI() { 
// Analyzes the test ROI

	setBatchMode(true);
	print("\\Clear");
	
	// If ask4ROIs was selected, opens the original image again
	if (ask4ROIs) {
	
		maxPath = getDirectory("image");
		maxName = getTitle();
		sampleName = substring(maxName, 4, lengthOf(maxName)-4);
		close();
		
		for (i = 0; i < imageFilesList.length ; i++) { // Look for the image corresponding to the open MIP
			
			if (matches(imageFilesList[i], ".*" + sampleName + ".*")) {
				
				run("Bio-Formats Importer", "open=[" + replace(imageFilesList[i], "/","\\") + "] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
				oriName = getTitle();
				rename("OriginalImage");
				
				// Duplicate and rename working channels 
				channelsString = String.join(newArray(substring(channel1, 1), substring(channel2, 1)));
				run("Make Substack...", "channels=[" + channelsString + "]");
				rename(oriName);
				run("Split Channels");
				selectImage("C1-" + oriName);
				rename(channel1 + "_Original");
				selectImage("C2-" + oriName);
				rename(channel2 + "_Original");
				close("OriginalImage");
				
				selectWindow(channel1 + "_Original");
				normalizeAndCrop();
				roiManager("select", 0);
				roiManager("Add"); //Becomes ROI 1
				roiManager("select", roiManager("count")-1);
				setSelectionLocation(0, 0);
				roiManager("update");
			}
		}
	}
	
	// Otherwise, directly process the open channels
	selectWindow(channel1 + "_Original");
	run("Duplicate...", "title=" + channel1 + " ignore duplicate");
	filterChannel(medT1x, medT1y, medT1z, gaussianT1x, gaussianT1y, gaussianT1z, sbBackgroundT1);

	if (indexOf(sampleName, region1) >=0) {

		segmentChannel(target1, lowThresholdT1R1, minSizeT1, watershedT1, watershedRadiusT1);
	}

	else {
	
		segmentChannel(target1, lowThresholdT1R2, minSizeT1, watershedT1, watershedRadiusT1);
	}
	
	makeVisualization(channel1, target1);
	close(sampleName + "_Seg" + target1);
	
	
	// Normalize and crop channel 2 image if first time opened
	if (ask4ROIs) {
		
		selectWindow(channel2 + "_Original");
		normalizeAndCrop();
	}
	
	selectWindow(channel2 + "_Original");
	run("Duplicate...", "title=" + channel2 + " ignore duplicate");
	filterChannel(medT2x, medT2y, medT2z, gaussianT2x, gaussianT2y, gaussianT2z, sbBackgroundT2);
	
	if (indexOf(sampleName, region1) >=0) {
	
		segmentChannel(target2, lowThresholdT2R1, minSizeT2, watershedT2, watershedRadiusT2);
	}
	
	else {
		
		segmentChannel(target2, lowThresholdT2R2, minSizeT2, watershedT2, watershedRadiusT2);
	}
	
	makeVisualization(channel2, target2);
	close(sampleName + "_Seg" + target2);
				
	setBatchMode("exit and display");
	
	organizeImages();
	run("Channels Tool...");
	selectWindow("Channels");
	setLocation(screenW*0.4, 0);
		
	call("java.lang.System.gc");
	beep();
}

//------------------------------------------------------------------------------
function makeVisualization(channelName, targetName) {
// Creates an image allowing the visualisation of the segmented objects for each 
// channel, outlined on the original and filtered images. 
	
	selectWindow(sampleName + "_Seg" + targetName);
	run("Label Boundaries"); // Gives 8-bit mask
	selectWindow("3D_Median");
	run("Merge Channels...", "c4=3D_Median c5=" + sampleName + "_Seg" + targetName + "-bnd create");
	rename(sampleName + "_Filtered_" + targetName);
	roiManager("select", roiManager("count")-1);
		
	selectWindow(sampleName + "_Seg" + targetName);
	run("Label Boundaries"); // Gives 8-bit mask
	run("Merge Channels...", "c1=" + channelName + " c2=" + sampleName + "_Seg" + targetName + "-bnd" + " create");
	rename(targetName + "_Visualization");
	roiManager("select", roiManager("count")-1);
}

//------------------------------------------------------------------------------
function organizeImages() { 
// Organizes visualization images

	sHeight = screenH*0.1;
	sWidth = screenW*0.7;
	
	// Get image size
	selectImage("C1_Original");
	run("Original Scale");
	imgWidth = getWidth();
	imgHeight = getHeight();
	
	// Get headers size
	getLocationAndSize(x, y, width, height);
	winWidth = width;
	winHeight = height;
	headerWidth = winWidth - imgWidth;
	headerHeight = winHeight - imgHeight;
	
	// Set ideal window width 
	if (imgHeight > 2*imgWidth) {
		
		idWinWidth = sWidth/6;
	}
	
	else {
		
		idWinWidth = sWidth/3;
	}
	
	idImgWidth = idWinWidth - headerWidth;
	
	// Set ideal window height
	idImgHeight = imgHeight*idImgWidth/imgWidth;
	idWinHeight = idImgHeight + headerHeight;
	
	// Prevent images from going under the taskbar
	if (imgHeight > 2*imgWidth) { // For tall images
		if (idWinHeight > screenH*0.9) {
			
			idWinHeight = screenH*0.85;
			idImgHeight = idWinHeight - headerHeight;
			idImgWidth = imgWidth*idImgHeight/imgHeight;
			idWinWidth = idImgWidth + headerWidth;
		}
	}
	else { // For normal or wide images
		if (2*idWinHeight > screenH*0.82) {
			
			idWinHeight = screenH*0.41;
			idImgHeight = idWinHeight - headerHeight;
			idImgWidth = imgWidth*idImgHeight/imgHeight;
			idWinWidth = idImgWidth + headerWidth;
		}
	}		
	
	// Place first image
	selectImage("C1_Original");
	setLocation(0, sHeight, idWinWidth, idWinHeight);
	
	// Get zoom, floor it and set it
	zoom = floor(getZoom()*100);
	run("Set... ", "zoom=" + zoom);
	
	// Place other images
	selectImage(target1 + "_Visualization");
	setLocation(idWinWidth, sHeight);
	run("Set... ", "zoom=" + zoom);
	// Get first row height
	getLocationAndSize(x, y, width, height);
	rowHeight = height;
	selectImage(sampleName + "_Filtered_" + target1);
	setLocation(2*idWinWidth, sHeight);
	run("Set... ", "zoom=" + zoom);
	
	if (imgHeight > 2*imgWidth) {
		
		selectImage(channel2 + "_Original");
		setLocation(3*idWinWidth, sHeight);
		run("Set... ", "zoom=" + zoom);
		selectImage(target2 + "_Visualization");
		setLocation(4*idWinWidth, sHeight);
		run("Set... ", "zoom=" + zoom);
		selectImage(sampleName + "_Filtered_" + target2);
		setLocation(5*idWinWidth, sHeight);
		run("Set... ", "zoom=" + zoom);
	}
	
	else {
		
		selectImage(channel2 + "_Original");
		setLocation(0, sHeight + rowHeight);
		run("Set... ", "zoom=" + zoom);
	
		selectImage(target2 + "_Visualization");
		setLocation(idWinWidth, sHeight + rowHeight);
		run("Set... ", "zoom=" + zoom);
		selectImage(sampleName + "_Filtered_" + target2);
		setLocation(2*idWinWidth, sHeight + rowHeight);
		run("Set... ", "zoom=" + zoom);
	}
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Functions specific to Macro 3:
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//------------------------------------------------------------------------------
function GUIMacro3() { 
// Asks for input/output directories, target parameters, segmentation parameters
// and creates a file that records the parameters used for the analysis of this 
// batch of images. 

	// Get source and output directories
	sourceDirectory = getDirectory("Choose the directory containing your experiment (ideally batch_number/sample)");
	outputDirectory = getDirectory("Select your Results directory, that may already contain saved test parameters");
	
	getTargets();
	getSegmentationParameters();
	
	// Records in a file the parameters used for the analysis
	detectionFile = File.open(outputDirectory + File.getName(sourceDirectory) + "_DetectionParameters.txt");
	getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
	print(detectionFile, "Detection parameters used for the folder " + sourceDirectory + " :");
	print(detectionFile, "\rLow Threshold " + target1 + " " + region1 + ": " + lowThresholdT1R1);
	print(detectionFile, "Low Threshold " + target1 + " " + region2 + ": " + lowThresholdT1R2);
	print(detectionFile, "Minimum Size " + target1 + ": " + minSizeT1);
	print(detectionFile, "Low Threshold " + target2 + " " + region1 + ": " + lowThresholdT2R1);
	print(detectionFile, "Low Threshold " + target2 + " " + region2 + ": " + lowThresholdT2R2);
	print(detectionFile, "Minimum Size " + target2 + ": " + minSizeT2);
	print(detectionFile, "Minimum % of Overlap for Colocalization: " + overlapThr);
	print(detectionFile, "\rFiltering parameters for " + target1 + " :");
	print(detectionFile, target1 + " Median: x = " + medT1x + ", y = " + medT1y + ", z = " + medT1z);
	print(detectionFile, target1 + " Gaussian: x = " + gaussianT1x + ", y = " + gaussianT1y + ", z = " + gaussianT1z);
	print(detectionFile, target1 + " Subtract Background Radius: " + sbBackgroundT1);
	print(detectionFile, "Watershed used on " + target1 + " : " + watershedT1 + " Radius : " + watershedRadiusT1);
	print(detectionFile, "\rFiltering parameters " + target2 + " :");
	print(detectionFile, target2 + " Median: x = " + medT2x + ", y = " + medT2y + ", z = " + medT2z);
	print(detectionFile, target2 + " Gaussian: x = " + gaussianT2x + ", y = " + gaussianT2y + ", z = " + gaussianT2z);
	print(detectionFile, target2 + " Subtract Background Radius: " + sbBackgroundT2);
	print(detectionFile, "Watershed used on " + target2 + " : " + watershedT2 + " Radius : " + watershedRadiusT2);
	print(detectionFile, "\rDate of processing: " + year + "/" + IJ.pad(month + 1, 2) + "/" + IJ.pad(dayOfMonth, 2) + " Time: " + IJ.pad(hour, 2) + ":" + IJ.pad(minute, 2) + ":" + IJ.pad(second, 2));
	File.close(detectionFile);
}

//------------------------------------------------------------------------------
function getROIs() { 
// Sequentially opens each MIP found in the source folder in order to select all 
// ROIs and saves them in one .zip file per animal/sample.
	
	for(i=0; i<maxFilesList.length; i++) { // List of MAX intensity projections

		roiManager("Reset");
		
		// Open max intensity projection
		open(maxFilesList[i]);
			
			while (nImages==0) {
			
				wait(1000);
			}

		maxName = getTitle();
		parentDirectory = File.getParent(maxFilesList[i]);
		groupName = File.getName(File.getParent(parentDirectory));
		batchName = File.getName(File.getParent(File.getParent(parentDirectory)));
		
		print("Selecting ROI " + i+1 + "/" + maxFilesList.length + " on image " + maxName + " from group " + groupName + " " + batchName);
		Stack.setChannel(2); // Comment this feature out or change it if you don't want the channel 2 to be preselected for drawing the ROI
		setTool("polygon");
		waitForUser("1-Use the selection tool to draw a single region to analyze (if you want to analyze the whole image, use Ctrl + A to make the selection)\n2-Press the t key to add it to the RoiManager\n3-Finally, click on OK to proceed to the next image");

			if(roiManager("Count") > 0) { //Saves a .zip file of the ROIs
				
				roiManager("Save", outputDirectory + replace(substring(maxName, 4, lengthOf(maxName)), ".tif", "_ROI.zip")); 
			}
			
		close();
	}
}

//------------------------------------------------------------------------------
function analyzeROIs() { 
// Analyzes ROIs
	
	setBatchMode(true);
	tableResults = File.getName(sourceDirectory) + "_Results";
	Table.create(tableResults);
	Table.setLocationAndSize(screenW*0.7, screenH*0.3, screenW*0.3, screenH*0.5, tableResults);
	
	for(i=0; i<maxFilesList.length; i++) { // Opens image + corresponding ROI

		showProgress((i+1) / maxFilesList.length); 
		print("\\Clear");
		roiManager("Reset");

		print("Processing image " + i+1 + "/" + maxFilesList.length);
		
		maxName = File.getName(maxFilesList[i]);
		sampleName = substring(maxName, 4, lengthOf(maxName)-4);
		roiAdjusted = false;
		if (File.exists(outputDirectory + sampleName + "_ROIAdjusted.zip")) {
			
			roiFile = outputDirectory + sampleName + "_ROIAdjusted.zip";
			roiAdjusted = true;
		}
		
		else {
			
			roiFile = outputDirectory + sampleName + "_ROI.zip";
		}
		
		if(File.exists(roiFile)) { // If ROI .zip file exists, opens the corresponding image and the ROI

			run("Bio-Formats Importer", "open=[" + replace(imageFilesList[i], "/","\\") + "] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
			oriName = getTitle();
			rename("OriginalImage");
			Stack.getDimensions(width, height, channels, slices, frames); // Need "slices"
			
			roiManager("Open", outputDirectory + sampleName + "_ROI.zip"); // Opens the original ROI .zip file
			parentDirectory = File.getParent(imageFilesList[i]);
			roiManager("select", 0);
			getStatistics(area, mean, min, max, std, histogram); 
			getVoxelSize(width, height, depth, unit);
				
			// Duplicate and rename working channels 
			channelsString = String.join(newArray(substring(channel1, 1), substring(channel2, 1)));
			run("Make Substack...", "channels=[" + channelsString + "]");
			rename(oriName);
			run("Split Channels");
			selectImage("C1-" + oriName);
			rename(channel1 + "_Original");
			selectImage("C2-" + oriName);
			rename(channel2 + "_Original");
			close("OriginalImage");
				
			selectWindow(channel1 + "_Original");
			normalizeAndCrop(); // Crops around OG ROI
			
			if (roiAdjusted) {

				roiManager("Open", roiFile); // Opens Adjusted ROI
				roiManager("select", 1);
			}
			
			else {

				roiManager("Add"); // Becomes ROI 1
				roiManager("select", roiManager("count")-1);
				setSelectionLocation(0, 0);
				roiManager("update");
			}
						
			filterChannel(medT1x, medT1y, medT1z, gaussianT1x, gaussianT1y, gaussianT1z, sbBackgroundT1);

			if (indexOf(sampleName, region1) >=0) {
			
				segmentChannel(target1, lowThresholdT1R1, minSizeT1, watershedT1, watershedRadiusT1);
			}
			
			else {
				
				segmentChannel(target1, lowThresholdT1R2, minSizeT1, watershedT1, watershedRadiusT1);
			}
			
			close("3D_Median*");
			
			selectWindow(channel2 + "_Original");
			normalizeAndCrop(); // Crops around OG ROI			
			filterChannel(medT2x, medT2y, medT2z, gaussianT2x, gaussianT2y, gaussianT2z, sbBackgroundT2);
			
			if (indexOf(sampleName, region1) >=0) {
			
				segmentChannel(target2, lowThresholdT2R1, minSizeT2, watershedT2, watershedRadiusT2);
			}
			
			else {
				
				segmentChannel(target2, lowThresholdT2R2, minSizeT2, watershedT2, watershedRadiusT2);
			}
			
			close("3D_Median*");
			close("C*");	

			segImage1 = sampleName + "_Seg" + target1;
			segImage2 = sampleName + "_Seg" + target2;
			pathMIP = maxFilesList[i];
			colocOverlapAnalysis(segImage1, segImage2, overlapThr, "_Coloc3DROIs.zip", false);
		}
		
		selectWindow(tableResults);
		Table.update; 
		Table.save(outputDirectory + File.getName(sourceDirectory) + "_Results.csv");
		
		close("*");
		call("java.lang.System.gc");
	}
	
	setBatchMode("exit and display");
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Functions specific to Macro 4:
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//------------------------------------------------------------------------------
function GUIMacro4() { 
// Asks for the results directory and target parameters
	
	// Gets results directory and shows the verification images list
	sourceDirectory = getDirectory("Please open the images directory containing the MIPs of your batch.");
	outputDirectory = getDirectory("Please open the results directory containing the results, ROIs and verification images of your batch.");
	verificationFilesList = getFilesList(outputDirectory, newArray(".*VisualizationComposite\.zip$", ".*VisualizationMIP\.jpg$")); //Should always be the same if 1st macro was used
	Array.show(verificationFilesList);
	Table.setLocationAndSize(screenW*0.7, screenH*0.5, screenW*0.3, screenH*0.45, "verificationFilesList");
	Table.setSelection(-1, -1);
	
	// Loads Test Parameters if any are saved
	getSavedParameters(outputDirectory + "Test_Parameters.txt");
	
	Dialog.create("Specify target names, channels and the % overlap threshold used for the analysis");
	Dialog.addString("Target 1", target1);
	Dialog.addToSameRow();
	Dialog.addString("Channel", channel1);
	Dialog.addToSameRow();
	Dialog.addNumber("min Size", minSizeT1, 0, 3, "px");
	Dialog.addString("Target 2", target2);
	Dialog.addToSameRow();
	Dialog.addString("Channel", channel2);
	Dialog.addToSameRow();
	Dialog.addNumber("min Size", minSizeT2, 0, 3, "px");
	Dialog.addNumber("Original Overlap Threshold: ", overlapThr, 0, 3, "%");
	Dialog.addCheckbox("Save parameters", false);
	
	Dialog.show();
	
	target1 = Dialog.getString();
	channel1 = Dialog.getString();
	minSizeT1 = Dialog.getNumber();
	target2 = Dialog.getString();
	channel2 = Dialog.getString();
	minSizeT2 = Dialog.getNumber();
	overlapThr = Dialog.getNumber();
	saveTargets = Dialog.getCheckbox();

	
	// Creates or updates list to save target parameters
	if (saveTargets) saveParameters(outputDirectory + "Test_Parameters.txt");
}

//------------------------------------------------------------------------------
function getResultsFileName(dir, lookingFor) {
// Retrieves the name of the .csv results file that is in the results folder
	
	list = getFileList(dir); // Makes list of what's inside the directory
	
	for (i = 0; i < list.length; i++) {
		
		if (matches(list[i], lookingFor)) { // If the file name contains what you are lookingFor return it
			
			return list[i];
		}
	}
}

//------------------------------------------------------------------------------
function reprocessStack() { 
// Allows the reslicing of the z-stack by creating a substack of the composite 
// image, and reprocesses the stack, recounting the segmented objects, according
// to the new ROI if any has been saved. Corrects the volume, whether 
// modifications have been made or not (gives a truer volume based on what has
// been segmented, rather than based on the ROI).
	
	// Initialize corrections parameters
	stackChanged = true;
	reSlice = false;
	askSaveNewRoi = false;
	
	// Initialize z-stack parameters
	Stack.getDimensions(width, height, channels, slices, frames);
	fromSlice = 1;
	toSlice = slices;
	getVoxelSize(width, height, depth, unit);
		
	// Opens corresponding ROI 
	selectImage(imageList[0]);
	roiFile = outputDirectory + sampleName + "_ROI.zip";
	roiManager("Open", roiFile); // Opens the OG ROI .zip file
	roiManager("Select", 0);
	roiManager("rename", "OriginalROI");
	if (!File.exists(outputDirectory + sampleName + "_ROIAdjusted.zip")) {
		 
		roiManager("add");
		roiManager("select", roiManager("count")-1);
		setSelectionLocation(0, 0);
		roiManager("update");
		roiManager("rename", "OriginalROIcrop");
	}
	else {
	
		roiManager("Open", outputDirectory + sampleName + "_ROIAdjusted.zip"); // Opens the Adjusted ROI .zip file
		roiManager("select", roiManager("count")-1);
		roiManager("rename", "OriginalUpdatedROI");
	}
	
	getSelectionCoordinates(oriX, oriY);
	
	// Show GUI for corrections parameters
	
	do {
		Dialog.createNonBlocking("Corrections options");
		Dialog.setLocation(screenW*0.65, screenH*0.3);
		Dialog.addMessage("Check the ROI and modify it if needed");
		Dialog.addMessage("Check the z-stack for empty slices, and reslice if you want to remove top/bottom slices");
		Dialog.addSlider("Top slice: ", 1, slices, 1);
		Dialog.addSlider("Bottom slice: ", 1, slices, slices);
		Dialog.addMessage("Toggle Channel 3 and 4 that respectively hold above threshold (kept) and under threshold (discarded) colocalizations");
		Dialog.addRadioButtonGroup("Do you want to change the overlap threshold?", newArray("No", "Yes"), 1, 2, useNewOverlap);
		if (useNewOverlap == "Yes") {
			
			Dialog.addNumber("New threshold: ", newOverlapThr, 0, 3, "%");
		}
		else {
			
			Dialog.addNumber("New threshold: ", overlapThr, 0, 3, "%");
		}
		Dialog.addString("Optional Comment: ", "", 50);
		Dialog.show();
		
		fromSlice = Dialog.getNumber();
		toSlice = Dialog.getNumber();
		optionalComment = Dialog.getString();
	}	while (fromSlice >= toSlice);
	
	// Check if the stack has been resliced
	nbSlices = toSlice - fromSlice + 1;
	if (slices != nbSlices) {
	
		reSlice = true; 
	}
	
	// Check if the overlap has been changed		
	if (Dialog.getRadioButton() == "Yes") {
		
		useNewOverlap = "Yes"; // flag when it has been used once during the macro
		newOverlapThr = Dialog.getNumber();
	}
	
	else {
		
		useNewOverlap = "No"; // Switches it back to no in case had been yes once before
		newOverlapThr = overlapThr;
	}

	// Checks if the ROI has been changed
	getSelectionCoordinates(newX, newY);
	coorDiffX = ArrayDiff(oriX, newX);
	coorDiffY = ArrayDiff(oriY, newY);
		
	if (coorDiffX.length > 0 || coorDiffY.length > 0) {
		
		askSaveNewRoi = getBoolean("Do you want to use and save this modified ROI?");
		
	}
	
	if (askSaveNewRoi) {
			
		roiManager("add");
		roiManager("select", roiManager("count")-1);
		roiManager("rename", "UpdatedROI");
		newRoiName = sampleName + "_ROIAdjusted.zip";
		roiManager("save selected", outputDirectory + newRoiName);
	}
		
	else {
		
		roiManager("select", 1);
		roiManager("add");
		roiManager("select", roiManager("count")-1);
		roiManager("rename", "UpdatedROI");
	}
	
	if (!reSlice && !askSaveNewRoi && useNewOverlap == "No") {
		
		stackChanged = false;
	}
	
	setBatchMode(true);
	if (stackChanged) {
		
		// Make a new substack with reslicing parameters	
		run("Make Substack...", "channels=1-3 slices=" + fromSlice + "-" + toSlice + "");
		close("\\Others"); // Close the original Composite for now	
		
		// Reprocess stack
		run("Split Channels");
		imageList = getList("image.titles");
		
		// Make new segmentation images
		close("C3*");
		close("C4*");
		makeSeg("^" + channel1 + ".*", target2, minSizeT2);
		makeSeg("^" + channel2 + ".*", target1, minSizeT1);
		roiManager("Select", 2); // UpdatedROI
		Stack.getDimensions(width, height, channels, slices, frames);
		getStatistics(area, mean, min, max, std, histogram);
	
		// Recount colocalizations and make new control images
		maxFilesList = getFilesList(sourceDirectory, newArray("^MAX_" + sampleName + ".*"));
		pathMIP = maxFilesList[0];	
		colocOverlapAnalysis("Seg_" + target1, "Seg_" + target2, newOverlapThr, "_Coloc3DROIs_Adjusted.zip", true);
	
		// Perform volume correction	
		selectImage(sampleName + "_VisualizationComposite_Adjusted.tif");
		wait(1000);
		run("RGB Color", "slices keep");
		rename("RGB");
		correctVolume("RGB");
		close("RGB");
		
		// Close everything and reopen original and modified composite so they tile as a before/after
		close("*");
		open(outputDirectory + sampleName + "_VisualizationComposite.zip");
		roiManager("select", 1);
		open(outputDirectory + sampleName + "_VisualizationComposite_Adjusted.zip");
		roiManager("select", 2);
	}
	else {
		
		// Fill in Results table with previous values
		targetRow = lookForRow(sampleName, tableResults);
		
		selectWindow(tableResults);
		Table.set("New Nb slices", targetRow, Table.get("Nb slices", targetRow)); 
		Table.set("New ROI Area", targetRow, Table.get("Roi Area_(" + unit + "2)", targetRow));
		Table.set("New ROI Volume mm3", targetRow, Table.get("Roi Volume_(mm3)", targetRow));
		Table.set("Corrected Total Area", targetRow, 0); // placeholder
		Table.set("Corrected Volume mm3", targetRow, 0); // placeholder
		Table.set("New" + target1 + " count", targetRow, Table.get(target1 + " count", targetRow)); 
		Table.set("New" + target2 + " count", targetRow, Table.get(target2 + " count", targetRow));
		Table.set("New Overlap % Threshold", targetRow, newOverlapThr);
		Table.set("New " + target1 + " in " + target2 + " count", targetRow, Table.get(target1 + " in " + target2 + " count", targetRow));
		Table.set("New " + target2 + " in " + target1 + " count", targetRow, Table.get(target2 + " in " + target1 + " count", targetRow));
		// Adding convenient checks here for what has been modified, comment them out if not interested
		///*
		Table.set("Resliced?", targetRow, reSlice);
		Table.set("New stack", targetRow, "");
		Table.set("ROI changed?", targetRow, askSaveNewRoi);
		Table.set("OverlapThr changed?", targetRow, 0);
		// */
		Table.set("Discard justification", targetRow, ""); // placeholder
		Table.update;
				
		// Perform volume correction
		selectImage(sampleName + "_VisualizationComposite.tif");
		run("RGB Color", "slices keep");
		rename("RGB");
		correctVolume("RGB");
		close("RGB");				
	}
				
	setBatchMode("exit and display");
}

//------------------------------------------------------------------------------
function makeSeg(pattern, channelName, minSize) {
// Makes new label images based on the (possibly new) ROI in the ROI 
// manager and the possibly resliced stack
	
	for (i = 0; i < imageList.length ; i++) {
	
		if (matches(imageList[i], pattern)) {
		
			selectImage(imageList[i]);
			print("New count for channel " + channelName + ":");
			roiManager("Select", 2); // For some reason doesn't work if I directly select "UpdatedROI"...
			wait(1000);
			setBackgroundColor(0, 0, 0);
			run("Clear Outside", "stack");	
			run("3D Simple Segmentation", "low_threshold=1 min_size=" + minSize + " max_size=-1");
			close(imageList[i]);
			close("Bin*");
			selectImage("Seg");
			rename("Seg_" + channelName);			
		}
	}
}

//------------------------------------------------------------------------------
function correctVolume(pattern) {
// Corrects the volume result: on an merged image comprising all the segmented 
// channels, creates a convex hull selection on each z slice, and recalculates 
// the volume according to the sum of these selections' areas.

	imageList = getList("image.titles");
	for (i = 0; i < imageList.length ; i++) {
	
		if (matches(imageList[i], pattern)) {
		
			makeBin(imageList[i]);
			Stack.getDimensions(width, height, channels, slices, frames);
			getVoxelSize(width, height, depth, unit);
			
			for (j=0; j<slices; j++) {
			
				Stack.setSlice(j+1);
			 	run("Create Selection");
			 	
			 	if (getValue("selection.size") > 0) {
			 		
			 		run("Convex Hull");
					roiManager("add");
					roiManager("Select", newArray(2, roiManager("count")-1)); // ROI 2 is supposed to be the UpdatedROI
					roiManager("AND");
					run("Properties... ", "name=0001-1841-1724 position=" + j+1 + " group=none stroke=none width=0 fill=none");
					roiManager("add"); 
					roiManager("select", roiManager("count")-1);	
					roiManager("measure");
					roiManager("Select", newArray(roiManager("count")-2, roiManager("count")-1));
					roiManager("delete");
			 	}
			}
			
			// Warns the user if an "empty" slice was found
			if (nResults != slices) {
				waitForUser("/!\\ WARNING /!\\", "It seems that " + (slices - nResults) +  " empty slice(s) has(ve) been skipped in the volume analysis.\nIf an empty slice is not at one extremity of the stack, your volume calculation may be wrong.\nIf there are no empty slices in the middle, try to redo the analysis while excluding the empty stack extremities when you make the substack.");
			}
			
			// Recalculates the volume based on the area of each slice selection	
			totalArea = 0;
		    for (n=0; n < nResults; n++) {
		
		    	totalArea += getResult("Area", n);
		    }
		    
			volume = totalArea*depth/1000000000;
	    	close("Results");
	    	
	    	selectWindow(tableResults);
			targetRow = lookForRow(sampleName, tableResults);
			Table.set("Corrected Total Area", targetRow, totalArea);
			Table.set("Corrected Volume mm3", targetRow, volume);
			getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
			Table.set("Appended the", targetRow, "" + year + "/" + IJ.pad(month + 1, 2) + "/" + IJ.pad(dayOfMonth, 2) + " at " + IJ.pad(hour, 2) + ":" + IJ.pad(minute, 2));
			Table.set("Comment", targetRow, optionalComment);
			Table.update; 
		}
	}
}

//------------------------------------------------------------------------------
function lookForRow(target, table) { 
// Looks in the original results table for the index of the row containing the 
// target name

	selectWindow(table);
	for (i = 0; i < Table.size; i++) {
		
		sName = Table.getString("Sample", i);
		if (sName == target) {
  			
  			return i;
		}
	}
}

//------------------------------------------------------------------------------
function retrieveCount(pattern) {
// Retrieves the corrected results from the log window

	logString = split(getInfo("log"), "\n"); 
	
	str = newArray();
	
	for (i=0; i<lengthOf(logString); i++) {
		
		if (endsWith(logString[i], pattern)) {
			
			str = logString[i+2];
		}
	}
	
	tmp = split(str, " ");
	countVariable = replace(tmp[lengthOf(tmp)-1], "=", "");
		
	return countVariable;
}

//------------------------------------------------------------------------------
function ArrayDiff(array1, array2) { 
// From Rainer M. Engel, 2012: returns the difference between two arrays
	
	diffA	= newArray();
	unionA 	= newArray();	
	
	for (i=0; i<array1.length; i++) {
		
		for (j=0; j<array2.length; j++) {
			
			if (array1[i] == array2[j]){
				
				unionA = Array.concat(unionA, array1[i]);
			}
		}
	}
	
	counter = 0;	
	for (i=0; i<array1.length; i++) {
		
		for (j=0; j<unionA.length; j++) {
			
			if (array1[i] == unionA[j]){
				
				counter++;
			}
		}
		
		if (counter == 0) {
			
			diffA = Array.concat(diffA, array1[i]);
		}
		
		counter = 0;
	}
	
	for (i=0; i<array2.length; i++) {
		
		for (j=0; j<unionA.length; j++) {
			
			if (array2[i] == unionA[j]){
				
				counter++;
			}
		}
		
		if (counter == 0) {
			
			diffA = Array.concat(diffA, array2[i]);
		}
		
		counter = 0;
	}	
	
	return diffA;
}
