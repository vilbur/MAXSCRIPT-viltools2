/*
subObj = 4
subObj = 1
Enter_Subobject_v 1
*/
	--start
-- include  @"$userscripts\\_MainUI\\LazyWall\\Wall_Cut.ms"
filein  @"$userscripts\\_MainUI\\Instance_Test_v.ms"
include  @"$userscripts\\_MainUI\\CurModTest_v.ms"

fn Enter_Subobject_v subObj =
(

	objArray = for o in selection where superclassof o  == geometryclass collect o
	
	if objArray.count >= 1 then
	(

		curObj = modPanel.getCurrentObject ()
		ModClass = classof curObj
-- 		subObj = subobjectLevel
		
		if  curObj == undefined do ( Max Modify Mode)

-- 		if subobjectLevel != 0 then 
-- 		(
			------------------Exeption for Wall Object
-- 			if  wObjType == "Wall" then 
-- 			(
-- 				subobjectLevel = 0 
-- 			)
-- 			else 
-- 			(
-- 				WallEditExit ()
-- 			)
-- 		)

		 if CurModTest_v() == true  then
		(
			finSel = Instance_Test_v 0 objArray
			addmodifier  finSel (Edit_Poly ()) 
-- 			modPanel.addModToSelection (Edit_Poly ()) ui:on
			select finSel
			subobjectLevel = subObj
	
		)
		else
		(
			if ModClass == Unwrap_UVW  then
			(
				case subObj of
				(				
					4:(subObj=3)
					5:(subObj=3)
					default:subObj=subObj
				)	
				subobjectLevel = subObj
			)
			else if ModClass == ProBoolean  then
			(
				if getUserProp objArray[1] "theWallobjID" != undefined then  WallEdit ()
				subobjectLevel = subObj

			)
			else
			(

				if subobjectLevel == subObj then (
					subobjectLevel = 0
				)else(
					try (subobjectLevel = subObj) catch()
				)
				
				
				
				
			)
		)
	)
)	--end

