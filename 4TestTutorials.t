[ ] // 4TestTutorials.t
[ ] // Author: Minuk Park
[ ] use "..\..\CaseWare.inc"
[ ] use "..\..\CaseView.inc"
[ ] use "C:\SilkTestCode\silktestclassic\zz_Reorg\Common Files\FileSetup.inc"
[ ] 
[+] testcase part5a() appstate ApplicationOpen
	[ ] CaseWare.EngagementProperties.Invoke()
	[+] if (CaseWare.EngagementProperties.Exists())
		[ ] CaseWare.EngagementProperties.Close()
	[ ] 
	[ ] print("Tutorial 5a Successful!")
	[ ] 
[ ] 
[+] testcase part5b() appstate ApplicationOpen
	[ ] CaseWare.Ribbon2.Engagement.EngagementProperties.Click()
	[+] if (CaseWare.Ribbon2.Engagement.EngagementProperties.Exists())
		[ ] CaseWare.EngagementProperties.Cancel.Click()
	[ ] 
	[ ] print("Tutorial 5b Successful!")
[ ] 
[+] testcase part5c() appstate ApplicationOpen
	[ ] CaseWare.EngagementProperties.Invoke()
	[ ] sleep(5)
	[ ] CaseWare.EngagementProperties.Close()
	[ ] 
	[ ] print("Tutorial 5c Successful!")
[ ] 
[ ] STRING newOperatingName = "Berkovitz & Co."
[+] testcase part6a() appstate ApplicationOpen
	[ ] 
	[+] with CaseWare.EngagementProperties
		[ ] .Invoke()
		[ ] .Name.SetText(newOperatingName)
		[ ] .OK.Click()
	[ ] 
	[ ] // WINDOW OperatingNameTextField = CaseWare.Find("//DialogBox[@caption='Engagement Properties [20693]']//TextField[@caption='Operating Name:']")
	[ ] // OperatingNameTextField.SetText(newOperatingName)
	[ ] // CaseWare.EngagementProperties.Accept()
	[ ] 
[ ] 
[+] testcase part6b() appstate ApplicationOpen
	[+] if (MatchStr("*{newOperatingName}*", CaseWare.CWStatusBar.MessagePane.GetText()))
		[ ] Print("tutorial 6 Successful!")
	[+] else
		[ ] LogError("The Operating Name hasn't been verified.")
	[ ] 
[ ] 
[+] testcase part7a() appstate ApplicationOpen
	[ ] const STRING defaultLocation = "C:\Program Files (x86)\CaseWare\Data\"
	[ ] const STRING dirName = "TestingYearEndClose"
	[ ] 
	[+] with CaseWare.YearEndClose
		[ ] .Invoke()
		[ ] .FilePath.SetText(defaultLocation)
		[ ] .FileName.SetText(dirName)
		[ ] .RollForwardBudgets.Check()
		[ ] .RollForwardForecasts.Check()
		[ ] .Accept()
		[ ] 
		[+] with .FileExists
			[+] if (.isWindowOpened())
				[ ] .OK.Click()
				[ ] WaitReady(CaseWare)
		[ ] // CaseWare.WaitReady2()
		[ ] 
		[ ] .Invoke()
		[ ] Verify(.RollForwardBudgets.IsChecked() && .RollForwardForecasts.IsChecked(), TRUE, "Check Boxes")
		[ ] .Close()
[ ] 
[+] testcase part8a() appstate ApplicationOpen
	[ ] LIST of DATACLASS dataClasses = {}
	[ ] LIST of LIST of STRING allWindows = {}
	[ ] LIST of WINDOW subWindows = {}
	[ ] WINDOW w
	[ ] INTEGER i = 0, len = 0
	[ ] 
	[+] with CaseWare.YearEndClose
		[ ] .Invoke()
		[ ] subWindows = .GetChildren()
		[ ] 
		[+] for each w in subWindows
			[ ] i = ListFind(dataClasses, w.GetClass())
			[ ] 
			[+] if (i == 0)
				[ ] ListAppend(dataClasses, w.GetClass())
				[ ] ListAppend(allWindows, {w.GetCaption()})
			[+] else
				[ ] ListAppend(allWindows[i], w.GetCaption())
		[ ] 
		[ ] len = ListCount(dataClasses)
		[+] for i = 1 to len
			[ ] Print ("--------------------------------------------------")
			[ ] Print ("|||||----========{dataClasses[i]}========----||||")
			[ ] Print ("--------------------------------------------------")
			[ ] ListPrint(allWindows[i])
		[ ] 
		[ ] .Close()
[ ] 
[+] testcase part9a() appstate ApplicationOpen
	[+] with CaseWare.EngagementProperties
		[ ] .Invoke()
		[ ] INTEGER pgSize = .PageList1.GetPageCount()
		[ ] 
		[ ] INTEGER i = 0
		[ ] 
		[+] for i = 1 to pgSize
			[ ] .PageList1.Select(i)
			[ ] LIST of WINDOW childrenList = .GetChildren()
			[ ] WINDOW w
			[ ] 
			[+] for each w in childrenList
				[+] if (w.GetClass() != StaticText && w.GetClass() != RibbonDropDownButton && !w.IsEnabled())
					[ ] LogWarning ("{w.GetClass()} {w.GetCaption()} is disabled!")	
		[ ] 
		[ ] .Close()
[ ] 
[+] testcase part10a() appstate ApplicationOpen
	[ ] const STRING location = "C:\Program Files (x86)\CaseWare\Data"
	[+] with CaseWare.CopyComponentsWizard
		[ ] .Invoke()
		[+] with .CopyComponentsWizard
			[ ] .NewFile.Click()
			[ ] 
			[ ] RECT browse = .Browse.GetRect(TRUE)
			[ ] Desktop.Click(1, browse.xPos + browse.xSize - 2, browse.yPos)
			[ ] Desktop.Click(1, browse.xPos + browse.xSize - 2, browse.yPos + (browse.ySize * 2))
			[ ] 
			[ ] Verify(.Location.GetText(), location, "Default Location")
		[ ] .Close()
[ ] 
[+] testcase part11a() appstate ApplicationOpen
	[ ] const STRING newName = "Dunbar & Co."
	[+] with CaseWare.GoTo
		[ ] .Invoke()
		[ ] .DocumentNumberJumpCode.SetText("TRAIN.1")
		[ ] .OK.Click()
	[+] with CaseView
		[ ] .ClickCell("C1")
		[+] with .ClientProfile
			[ ] Verify(.isWindowOpened(), TRUE)
			[ ] .Name.SetText(newName)
			[ ] .OK.Click()
			[ ] 
	[+] with CaseWare
		[ ] .SetActive()
		[+] with .EngagementProperties
			[ ] .Invoke()
			[ ] Verify(.Name.GetText(), newName)
			[ ] .Close()
[ ] 
[+] testcase part11b() appstate ApplicationOpen
	[+] with CaseWare.GoTo
		[ ] .Invoke()
		[ ] .DocumentNumberJumpCode.SetText("TRAIN.1")
		[ ] .OK.Click()
	[ ] 
	[+] with CaseView
		[ ] .View.DesignMode.Check()
		[ ] .HighlightParagraph(2)
		[ ] .Ribbon2.Home.Bold.Click()
[ ] 
[+] testcase part12a() appstate ApplicationOpen
	[ ] const STRING sampleDir = "C:\Program Files (x86)\CaseWare\Data\Samp01"
	[ ] const STRING targetDir = "DataBackup"
	[ ] const STRING targetDir2 = "Samp01Backup"
	[ ] 
	[+] if (!SYS_DirExists(sampleDir))
		[ ] LogError("The sample directory doesn't exist!")
	[+] else
		[+] if (!SYS_DirExists("C:\{targetDir}\{targetDir2}"))
			[ ] SYS_SetDir("C:\")
			[ ] SYS_MakeDir(targetDir)
			[ ] SYS_MakeDir("C:\{targetDir}\{targetDir2}")
			[ ] // SYS_MakeDir(targetDir2)
		[ ] 
		[ ] LIST of FILEINFO files = SYS_GetDirContents(sampleDir)
		[ ] integer fileCount = ListCount(files)
		[ ] integer i = 0
		[ ] 
		[ ] SYS_SetDir("C:\{targetDir}\{targetDir2}")
		[+] for i = 1 to fileCount
			[+] if (!SYS_FileExists("{files[i].sName}.bak"))
				[ ] SYS_CopyFile("{sampleDir}\{files[i].sName}", "{files[i].sName}.bak")
[ ] 
[+] testcase part12b() appstate ApplicationOpen
	[ ] const STRING sPath = "Software\CaseWare International\Working Papers\2017.00\Settings"
	[ ] const STRING sName = "DefaultPath"
	[ ] const STRING defaultValue = "C:\Program Files (x86)\CaseWare\Data"
	[ ] const STRING tempValue = "C:\Training\SilkTest\Data"
	[ ] INTEGER iKey = HKEY_CURRENT_USER
	[ ] 
	[ ] SYS_SetRegistryValue(iKey, sPath, sName, tempValue)
	[ ] 
	[+] with CaseWare.Options
		[ ] .Invoke()
		[ ] .PageList1.Select(2)
		[+] with .DefaultPaths.ClientFilePath
			[ ] Verify(.GetText(), tempValue)
			[ ] .SetText(defaultValue)
		[ ] .OK.Click()
	[ ] 
	[ ] Verify(SYS_GetRegistryValue(iKey, sPath, sName), defaultValue)
[ ] 
[+] void OpenAndCloseDialog(STRING dialog)
	[ ] CaseWare.@(dialog).Invoke()
	[ ] sleep(2)
	[ ] CaseWare.@(dialog).Close()
[+] testcase part13a() appstate ApplicationOpen
	[ ] LIST OF STRING windows = {"GoTo", "YearEndClose", "ImportAccountingSoftware", "UserIdentification"}
	[ ] STRING w
	[ ] 
	[+] for each w in windows
		[ ] OpenAndCloseDialog(w)
[ ] 
[+] testcase setup() appstate ApplicationOpen
	[ ] const STRING srcLocation = "\\broadview\qa\Brendan\SilkTest\SilkTest_Tutorial\tutorial"
	[ ] const STRING destLocation = "C:\Training\SilkTest\SilkTestTraining"
	[ ] 
	[+] if !FileSetup.CopyDir(srcLocation, destLocation, FALSE, TRUE)
		[ ] LogError("Failed to copy files!")
		[ ] 
	[ ] CaseWare.Startup(TRUE, "tutorial.ac", "C:\Program Files (x86)\CaseWare\Data\tutorial")
[ ] 
[+] testcase shutdown() appstate ApplicationOpen
	[+] if CaseView.isWindowOpened()
		[ ] CaseView.Shutdown(True)
	[+] if CaseWare.isWindowOpened()
		[ ] CaseWare.Shutdown(True)
[ ] 
