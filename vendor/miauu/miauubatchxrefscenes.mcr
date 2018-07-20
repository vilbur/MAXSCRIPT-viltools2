--******************************************************************************************************
-- Created: 		25-03-2014
-- Last Updated:	25-03-2014
-- Version:			1.00
--
-- Author :  Kostadin Kotev / miau_u@yahoo.com / http://miauumaxscript.blogspot.com/
-- Version:  3ds max 2009 (10) (should work in older versions too!)
--
-- Discription: batch load xRef Scenes. 
-- Usage: You can load all files in given directory and to choose to load the files in the sub-folders of that directory
--	You can load single file, or randomly selected file using the GET FILE button
--	Only files, which checkboxes in the list view is checked will be loaded as xRef Scenes
--	Click in the file in the list view with RMB will open the folder where the file is placed
--	Click in the file in the list view with MMB will remove the file from the list
--
-- Script idea; Bruno Lopes  /http://www.3dbybrunolopes.com//
--
--	Credits to Denis "denisT" Trofimov, Peter "LoneRobot" Addington, Josef "spacefrog" Wienerroither
--
--******************************************************************************************************
-- MODIFY THIS AT YOUR OWN RISK

macroscript miauuBatchLoadXRefScenes
category:"miauu"
tooltip:"Batch Load xRef Scenes"
buttonText:"Batch Load xRef Scenes"
(
	global rol_miauuBatchLoadXRefScenes
    try(destroyDialog rol_miauuBatchLoadXRefScenes)catch()
    rollout rol_miauuBatchLoadXRefScenes "miauu's Batch Load xRef Scenes"
    (
		local ConvertClass = dotnetclass "system.convert"
		local ImageClass = dotnetclass "system.drawing.image"
		local logoIcon = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAAJcEhZcwAACxIAAAsSAdLdfvwAAALcSURBVDhPbZJLSFRhGIa/1C6IMmmQFNownplzv8y5zIzOqGPimE5hFxfeZxQzu0AXDbtsXHWBwNpWaIt2lQWBFSS0qCholbsW7QwiiKBNRDlv//xTWtjiO9+B77zP+37/+QkA7QxXULu7mZLmVmq1K2lvtIzSjm/A0Wt/NjdEl0d62w+eGe2gyUyCTvXHaawnSRNDTVy7AuhwfdTt+Kg1XBFIWNVLmqZj/ryGc90yVN1CZ3vjx9PDLWpS3UJH+pI0nv0L0MaEaa+cYnr1M0OVIKkWNN0AXsQxe0KCIkvwCxI818bgvsTL8eFWmhpLrgLq9Korri4si4oJVTNg6Covy5RhGQrrOusqQqIEQVSQqI/mjvY1T68AhJCc0wwLuqbwmuwKAfdcDkl4MvAmjr1NEgNpMA0NghCEFXZzKwBRFHP54WhawudbNpbuePg+5+DVBR3vZlxgIYrFqwY+zNjoSckcbNvhVYAkhnIWI4/36czZRiNzzX/07kYYl7MSd812qsC8h96UxFOy81gLOLSHxX3ooi4scsBb5jrVL3PAGJt9u2uju7Wwpuc6awEne1mChRganALgy/0oprMiB5wdsXiCgV1yAeD8B3B8P0vwOIJUfWGFL7ct3DymcsDxLgV45GEo/SfBXyvIssQPcWKQ/XsGaP8NeP+gHtdGFA6YHLOBJxFkdv1nhUBtMOc4Nhflh/lusuKdifPp8j1fYWaksJtpOLFVgFNbOltd44fCLpFpsdiHJbZvhAPa6tj763pkUiJ000JIjzATGW12xfMVQIuygbZv2bhJ2uFbDAYFXDrh4dP1MAMoSCU14GkMnc0Wu+Immqyqz/2xdXXDsYKWPxqkUvJvKyM3UEJ6TUlc8ld+9QsqNNNmrg4ExUHEqPlxwF1/6nAD0WgjUU+0+F9ATVU5WYFSigY3kreDKOIvuaiGqpdNNYTdbtncSJzoYIIoGy+mTLyIAYqYFvQLPey9qVeXvysAAAAASUVORK5CYII="
		local curMaxVersion = ((maxVersion())[1] / 1000)
		local openFileRoll = dotNetObject "System.Windows.Forms.OpenFileDialog"	
        local disableForeColor = (dotNetClass "System.Drawing.Color").white
        local maxFiles = #()         
		
        dotNetControl lv_Batch "system.windows.forms.listView" height:200 width:273 pos:[10,10]
		
		button btn_getDir "Get Directory" width:108 pos:[290,10] tooltip:"Select all .max files in the given folder and/or its sub-folders"
        button btn_getFile "Get file(s)" width:108 pos:[290,35] tooltip:"Select one or multiple files in given folder"
        button btn_Clear "Cear" width:108 pos:[290,60]  
		
		groupbox gb_set "Settings" width:108 height:180 pos:[290,85]	
			checkbox chkbox_autoUpdate "Auto update" pos:[gb_set.pos.x+5, gb_set.pos.y+15] checked:true
			checkbox chkbox_boxDisp "Display as Box" pos:[gb_set.pos.x+5, gb_set.pos.y+33]
			checkbox chkbox_hidden "Visible" pos:[gb_set.pos.x+5, gb_set.pos.y+51] checked:true
			checkbox chkbox_disabled "Disabled" pos:[gb_set.pos.x+5, gb_set.pos.y+69]
			checkbox chkbox_ignoreLights "Ignore Lights" pos:[gb_set.pos.x+5, gb_set.pos.y+87]
			checkbox chkbox_ignoreCameras "Ignore Cameras" pos:[gb_set.pos.x+5, gb_set.pos.y+105]
			checkbox chkbox_ignoreShapes "Ignore Shapes" pos:[gb_set.pos.x+5, gb_set.pos.y+123]
			checkbox chkbox_ignoreHelpers "Ignore Helpers" pos:[gb_set.pos.x+5, gb_set.pos.y+141]
			checkbox chkbox_ignoreAnimation "Ignore Animation" pos:[gb_set.pos.x+5, gb_set.pos.y+159] width:100
			
		checkbox chkBox_showFullPath "Show Full Path" pos:[10,215]
		label lbl_select "Select:" pos:[120,215]
		button btn_all "All" pos:[157,214] width:40 height:18
		button btn_none "None" pos:[200,214] width:40 height:18
        button btn_invert "Invert"	 pos:[243,214]	width:40 height:18
		button btn_loadXRefScenes "Load xRef Scenes" width:275 height:30 pos:[10,235]
		hyperLink http_miauu "miauu's MaxScripts" address:"http://miauumaxscript.blogspot.com/" pos:[300,270] color:(color 7 231 251)
		progressBar pb_xRefprogress value:0 color:green width:275 pos:[10,270]
        
		--	Credist to Peter Addington - http://lonerobot.net/?p=314
		function String2Bmp string =
		(
			local clipboardClass = dotNetClass "System.Windows.Forms.Clipboard"
			local ConvertClass = dotnetclass "system.convert"
			local imageclass = dotNetclass "System.Drawing.image"
			local bytearr = convertclass.FromBase64String string
			local memstream = dotnetobject "System.IO.MemoryStream" bytearr
			local DecodedImg = ImageClass.fromstream memstream
			memstream.close()
			DecodedImg
		)
		--	credits to Denis Trofimiv - http://forums.cgsociety.org/showpost.php?p=7708817&postcount=21
		function LoadMyLogoAsTitlebarIcon =
		(
			d = (windows.getChildHWND 0 rol_miauuBatchLoadXRefScenes.title)[1]
			WM_SETICON = 0x0080
			ICON_SMALL = 0
			bm = dotnetobject "System.Drawing.Bitmap" (String2Bmp logoIcon)			
			ptr = bm.GetHicon()
			icon = (dotnetclass "System.Drawing.Icon").FromHandle (dotnetobject "IntPtr" ptr)			
			windows.SendMessage d WM_SETICON ICON_SMALL icon.handle
		)
		
        function AddColumns theLv columnsAr=
        (
            if chkBox_showFullPath.state == false then
                w=(theLv.width)-6
            else
                w=(theLv.width)+400
            for x in columnsAr do
            (
                theLv.columns.add x w
            )
        )
        function PopulateListView theLv=
        (
            rows=#()
            for x=1 to maxFiles.count do
            (
                if chkBox_showFullPath.state == false then
                    mapName = (getFilenameFile maxFiles[x])
                else
                    mapName = maxFiles[x]
                
                li = dotNetObject "System.Windows.Forms.ListViewItem" mapName
                append rows li
            )
            theLv.items.addRange rows
        )
        function InitListView theLv=
        (            
            theLv.clear()
			theLv.headerStyle = theLv.headerStyle.none
            theLv.view = (dotNetClass "system.windows.forms.view").details
            theLv.FullRowSelect = true    
            theLv.MultiSelect = true    
            theLv.checkBoxes = true                
            theLv.backcolor = (dotNetClass "System.Drawing.Color").DimGray
            theLv.forecolor = (dotNetClass "System.Drawing.Color").lightGray
        )
        function BatchListViewReIinit =
        (
            InitListView lv_Batch
            AddColumns lv_Batch #("")    
            PopulateListView lv_Batch
        )
        function TurnBatchLVchkBoxOn =
        (
            for i = 0 to lv_Batch.Items.count-1 do
                lv_Batch.Items.Item[i].checked = true
            lv_Batch.forecolor = disableForeColor
        )    
        function OpenFolders folderToOpen =
        (
            local checkFolderName = substring folderToOpen 1 (folderToOpen.count-1)
            if (symbolicPaths.isPathName checkFolderName) then
            (
                folderToOpen = symbolicPaths.getPathValue checkFolderName
            )                
            shellLaunch "explorer.exe" folderToOpen
        )        
        
        function GetFilesRecursive root pattern =
        (        
            dir_array = GetDirectories (root+"\*")
            for d in dir_array do
                join dir_array (GetDirectories (d+"*"))    
            
            my_files = #()                
            for f in dir_array do
                join my_files (getFiles (f + pattern))
                    
            my_files
        )
		
        on btn_getDir pressed do
        (
            dir = getSavePath caption:"Select the directory" initialDir:"$scenes"
            if dir != undefined do
            (
                maxFiles = #()
                --    get all max files
                maxFiles = getFiles (dir+"\*.max")
                --    check for subfolders
                subFiles = GetFilesRecursive dir "*.max"
                if subFiles.count != 0 then
                (
                    msg = "The selected folder have subfolders!\n"
                    msg += "Do you want to include the files from the subfolders too?"
                    if queryBox  msg title:"Sub-folders found" do
                        join maxFiles subFiles
                )
				makeUniqueArray maxFiles
                PopulateListView lv_Batch
                TurnBatchLVchkBoxOn()
            )
        )
        
        on btn_getFile pressed do
        (
			result = openFileRoll.showDialog()
			result.ToString() 
			if (result.Equals result.OK) do 
			(
				filePath = (openFileRoll.fileNames)
				join maxFiles filePath
				makeUniqueArray maxFiles
                BatchListViewReIinit()
                TurnBatchLVchkBoxOn()
			)
        )
		
		on btn_all pressed do
		(
			for i = 0 to lv_Batch.Items.count-1 do lv_Batch.Items.Item[i].checked = true
		)
		
		on btn_none pressed do
		(
			for i = 0 to lv_Batch.Items.count-1 do lv_Batch.Items.Item[i].checked = false
		)
		
		on btn_invert pressed do
		(
			for i = 0 to lv_Batch.Items.count-1 do lv_Batch.Items.Item[i].checked = not lv_Batch.Items.Item[i].checked
		)
		
        on btn_Clear pressed do
        (
            maxFiles = #()
            BatchListViewReIinit()
        )
	
        on lv_Batch MouseDown arg do
        (
            --    delete selected max file from the listview
            if arg.button==arg.button.middle then
            (                
                if (hitNode = lv_Batch.GetItemAt arg.x arg.y) != undefined do
                (
                    deleteItem maxFiles (hitNode.index+1)
                    BatchListViewReIinit()
                )                
            )
            --    open folder of selected max file
            if arg.button==arg.button.right then
            (                
                if (hitNode = lv_Batch.GetItemAt arg.x arg.y) != undefined do
                (
                    f = (hitNode.index+1)
                    folderToOpen = (getFilenamePath maxFiles[f])
                    OpenFolders folderToOpen
                )                
            )
        )
        
        on chkBox_showFullPath changed state do
        (
			cbState = for i = 0 to lv_Batch.Items.count-1 collect lv_Batch.Items.Item[i].checked
            BatchListViewReIinit()
            for i = 0 to lv_Batch.Items.count-1 do lv_Batch.Items.Item[i].checked = cbState[i + 1]
        )    
		
		on btn_loadXRefScenes pressed do
		(	
			local xRefCnt = (lv_Batch.Items.count - 1)
			setWaitCursor()
			suspendEditing()
			for i = 0 to xRefCnt where (lv_Batch.Items.Item[i].checked == true) do with redraw off
			(
				local fileExist = false
				local stopLoop = false
				local xRefFilesArr = xrefs.getXRefFileCount()
				for j = 1 to xRefFilesArr where ((xrefs.getXRefFile j).fileName == maxFiles[i + 1]) while stopLoop == false do
				(
					fileExist = true
					stopLoop = true
				)
				if fileExist == false do
				(
					xRefFile = xrefs.addNewXRefFile maxFiles[i + 1]
					if xRefFile != undefined do
					(
						xRefFile.autoUpdate = chkbox_autoUpdate.state
						xRefFile.boxDisp = chkbox_boxDisp.state
						xRefFile.hidden = not chkbox_hidden.state
						xRefFile.disabled = chkbox_disabled.state
						xRefFile.ignoreLights = chkbox_ignoreLights.state
						xRefFile.ignoreCameras = chkbox_ignoreCameras.state
						xRefFile.ignoreShapes = chkbox_ignoreShapes.state
						xRefFile.ignoreHelpers = chkbox_ignoreHelpers.state
						xRefFile.ignoreAnimation = chkbox_ignoreAnimation.state
					)
				)
				pb_xRefprogress.value = 100.0 * i / xRefCnt
				if curMaxVersion > 12 do
					windows.processPostedMessages()
			)
			--	fix the problem in max2014 and nitros. Credits to Josef "spacefrog" Wienerroither  http://www.frogsinspace.at/
			completeRedraw()
			with redraw off
			(
				local xRefIdx
				local oldSaveRequired = getSaveRequired() 
				xRefCnt = xRefs.getXRefFileCount()
				for i = 1 to xRefCnt while ( classOf (xRefIdx = xRefs.getXrefFile i) == XrefScene ) do
				(
					xRefIdx.boxDisp = not (xRefIdx.boxDisp = not xRefIdx.boxDisp)
					xRefIdx.hidden = not (xRefIdx.hidden = not xRefIdx.hidden)
				)
				setSaveRequired oldSaveRequired
			)
			completeRedraw()
			resumeEditing()
			setArrowCursor()
		)
        
        on rol_miauuBatchLoadXRefScenes open do
        ( 
			try(LoadMyLogoAsTitlebarIcon())catch()
				
			openFileRoll.title = "Select Files"
			openFileRoll.Multiselect = true
			openFileRoll.Filter = "MAX (*.max)|*.max"
			openFileRoll.FilterIndex = 1
			openFileRoll.RestoreDirectory = true	
			
            InitListView lv_Batch
            AddColumns lv_Batch #("Files")
        )
    )
    createdialog rol_miauuBatchLoadXRefScenes width:405 
)