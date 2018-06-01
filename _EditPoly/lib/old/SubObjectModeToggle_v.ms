fn Enter_Subobject_CallBackFN =
(	
-- 		subObj = 4
		subObj = subobjectlevel
		curmod = modpanel.getcurrentobject ()
				print ("------------Enter_Subobject_CallBackFN-----------------------------")

		if SubObj_new == undefined or SubObj_old == undefined then 
		(
				global SubObj_old = 4
				global SubObj_new = 1
				print ("1-SubObj_old :" + SubObj_old as string)
				print ("1-SubObj_new :" + SubObj_new as string)
		)
		else
		(
			if classof curmod == Unwrap_UVW  and SubObj_old == 4 then subobjectlevel = 3
		)
		
		
		if subObj != 0 and subObj != SubObj_new and subObj != SubObj_old then
		(
			global SubObj_old = SubObj_new
			global SubObj_new = subObj
		)
		else if subObj != 0 and subObj != SubObj_old then  -- switch subobect variables
		(
			global SubObj_new = subobjectlevel

		)
		else if subObj != 0 and subObj == SubObj_old then  -- switch suboject variables
		(
			global SubObj_old = SubObj_new
			global SubObj_new = subobjectlevel
			
		)
		
		if classof curmod == Unwrap_UVW  and SubObj_new == 3 then SubObj_new == 4 
	
				print ("2-SubObj_old :" + SubObj_old as string)
				print ("2-SubObj_new :" + SubObj_new as string)
		
	
)
-- global  Enter_Subobject_CallBack = undefined
/*

fn Enter_Subobject_CallBack = 
(
			print ("------------Enter_Subobject_CallBack-----------------------------")
	
-- 		 	try(callbacks.RemoveScripts  #selectionSetChanged id:#SelectionChange_vilTools_MatID)catch()
-- 			try(callbacks.addScript #selectionSetChanged "SelectionChange_vilTools_MatIDFN()" id: #SelectionChange_vilTools_MatID)catch()
	global Enter_Subobject_CallBack = undefined
	fn Enter_Subobject_CallBack_event ev nd  = Enter_Subobject_CallBackFN()
	Enter_Subobject_CallBack = nodeEventCallback subobjectSelectionChanged:Enter_Subobject_CallBack_event
-- 	global  Enter_Subobject_CallBack_ON = true
-- 	global  Enter_Subobject_CallBack_ON = false

-- 	Enter_Subobject_CallBack = undefined	
-- 	gc()
)
*/

fn Enter_Subobject_CallBack = 
(
			print ("------------Enter_Subobject_CallBack-----------------------------")
	
-- 		 	try(callbacks.RemoveScripts  #selectionSetChanged id:#SelectionChange_vilTools_MatID)catch()
-- 			try(callbacks.addScript #selectionSetChanged "SelectionChange_vilTools_MatIDFN()" id: #SelectionChange_vilTools_MatID)catch()
-- 	global Enter_Subobject_CallBack = undefined
-- 	gc()
	
	fn Enter_Subobject_CallBack_event ev nd  = Enter_Subobject_CallBackFN()
	global Enter_Subobject_CallBack = nodeEventCallback subobjectSelectionChanged:Enter_Subobject_CallBack_event
-- 	global  Enter_Subobject_CallBack_ON = true
-- 	global  Enter_Subobject_CallBack_ON = false

-- 	Enter_Subobject_CallBack = undefined	
-- 	gc()
)

fn Enter_Subobject_CallBackKill = 
(
	global Enter_Subobject_CallBack = undefined
	gc()
	
)	
-- 	
fn SubObjectModeToggle_v = 
(
	
	if selection.count > 0 then
	(
		print ("------------SubObjectModeToggle_v-----------------------------")
		Enter_Subobject_CallBackKill()

-- 		print "SubObjectModeToggle_v"
		
		if SubObj_new == undefined or SubObj_old == undefined then 
		(
				global SubObj_old = 4
				global SubObj_new = 1
		)
		
	-- 	global SubObjSwitch --= (getFilenamePath (getSourceFileName()))+ "SubObjINI.ini"
		curObj = modPanel.getCurrentObject ()
		if  curObj == undefined do ( Max Modify Mode; curObj = modPanel.getCurrentObject ())
		if  CurModTest_v() == true   then 
		(
			finSel = vilTools_InstanceTest (selection as array)
			addmodifier  finSel (Edit_Poly ()) 	
			select finSel
	
		)	 	
		
		if classof curObj == Unwrap_UVW  then
			(
				case SubObj_new of
				(				
					4:(SubObj_new=3)
					5:(SubObj_new=3)
					default:subObj=subObj
				)	
			)
		
		
		
		if subobjectlevel != 0 then subobjectlevel = 0
		else subobjectlevel = SubObj_new
		
-- 		print "SubObjectModeToggle_v"
	
-- 		print( "SubObj_old HOVNO:" + SubObj_old as string)
		print ("3-SubObj_old :" + SubObj_old as string)
		print ("3-SubObj_new :" + SubObj_new as string)
		
-- 		print ("------------Enter_Subobject_CallBack VARIABLE: " + Enter_Subobject_CallBack)
		

		
-- 		if Enter_Subobject_CallBack_ON != true then Enter_Subobject_CallBack()		
			fn Enter_Subobject_CallBack_event ev nd  = Enter_Subobject_CallBackFN()
			global Enter_Subobject_CallBack = nodeEventCallback subobjectSelectionChanged:Enter_Subobject_CallBack_event
	)
)


fn SubObjectModeSwitch_v = 
(
	Enter_Subobject_CallBackKill()	
	
	if selection.count > 0 then
	(	
		
		if SubObj_new == undefined or SubObj_old == undefined then 
		(
				global SubObj_old = 4
				global SubObj_new = 1
		)
		

-- 		if Enter_Subobject_CallBack == undefined then  Enter_Subobject_CallBack ()
		
		curObj = modPanel.getCurrentObject ()
		if  curObj == undefined do ( Max Modify Mode; curObj = modPanel.getCurrentObject ())
		
		 if CurModTest_v() == true  then
		(
			finSel = vilTools_InstanceTest (selection as array)
			addmodifier  finSel (Edit_Poly ()) 
			select finSel
-- 			modPanel.addModToSelection (Edit_Poly ()) ui:on
		)			
			
		
		if subobjectlevel == SubObj_new then 
		(
			subobjectlevel = SubObj_old 
			global SubObj_old = SubObj_new
			global SubObj_new = subobjectlevel		
			
		)

		else
		(
			subobjectlevel = SubObj_new 
			
				
		)
	
		print ("------------SubObjectModeSwitch_v-----------------------------")
	
		print( "4-SubObj_old :" + SubObj_old as string)
		print ("5-SubObj_new :" + SubObj_new as string)
		
-- 		if Enter_Subobject_CallBack_ON != true then Enter_Subobject_CallBack()		
		fn Enter_Subobject_CallBack_event ev nd  = Enter_Subobject_CallBackFN()
		global Enter_Subobject_CallBack = nodeEventCallback subobjectSelectionChanged:Enter_Subobject_CallBack_event
	)
	
)




