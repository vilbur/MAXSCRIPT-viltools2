macroscript	wirecolor_random
category:	"_Selection"
buttontext:	"Random color"
toolTip:	"Random wirecolor to selected object"
--icon:	"#(path, index)"
(
 	--mode	= "perObj"
 	mode	= "perSel"

	if selection.count > 0 then
	(
		objArray = selection as array
		AllobjArray =  selection as array

-- 		allInstance = Instance_Test_v objArray
		instancesPerObj = #()
		instances  = #()

		for o in objArray do
			(	
-- 					local addmod = #()
-- 				o=$
				obj_instance = #()
				testInst = (InstanceMgr.GetInstances o &obj_instance)

				if testInst > 1 then 
				(
					instancesPerObjTmp = #()
					join instances obj_instance	
-- 				 inst = instances[1]
					for inst in instances do
					(
						if (finditem objArray inst != 0 ) then 
						(
							appendifunique instancesPerObjTmp inst
							deleteitem objArray (finditem objArray inst)
						)
-- 							if (finditem objArray inst != 0 ) then deleteitem objArray (finditem objArray inst)
					)
					append instancesPerObj instancesPerObjTmp

				)
				else append instancesPerObj #(o)
			)
		/*		
			(mode = "perSel")
			for a=1 to instancesPerObj.count do print (instancesPerObj[a] as string)
		*/
		case of
		(
			(mode == "perObj") : (for obj in AllobjArray do obj.wirecolor = color (random 100 255) (random 100 255) (random 100 255))
			(mode == "perSel") :(

									wirecolor = color (random 100 255) (random 100 255) (random 100 255)
									for oSel in instancesPerObj do
									(
										for o in oSel do o.wirecolor = wirecolor
									)
								)
		)
	)
-- 	select sel
)

macroscript	wirecolor_select_by
category:	"_Selection"
buttontext:	"Select by"
toolTip:	"Select by wirecolor"
--icon:	"#(path, index)"
(
	selColor=#()		
	for o in selection do appendifunique selColor o.wirecolor
	
	theObject = modPanel.GetCurrentObject()
	Max create mode

	i=1
	for c in selColor do
	(
		
		for o in objects where o.wirecolor == selColor[i] and  o.isNodeHidden == false and 	o.layer.on == true do selectmore o
		
		i=i+1
		
	)
	
	max modify mode
)

