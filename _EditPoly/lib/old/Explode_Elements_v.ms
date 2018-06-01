function Explode_Elements_v  =
(
	include @"$userscripts\\_EditPoly\\GetElementsEpoly.ms"	

	undo "Explode_Elements_v" on

	(
	/*
	ExplodeInstances_v ( selection as array)
	/*	
		*/
-- 		max create mode
		objArray = for o in selection where superclassof o == GeometryClass collect o
		objArray = vilTools_InstanceTest objArray
		finalSel = #()
		for o in objArray where classof o != editable_poly do 
		(
			addmodifier o (Edit_Poly ())

			maxOps.CollapseNodeTo o 1 off
		)
		for obj in objArray do
		(
		-- 	/*local*/ obj = selection[1]
			/*local*/ instances = #()		
			/*local*/ obj_instance
			InstanceMgr.GetInstances obj &obj_instance
			join instances obj_instance		
				
			Elements = (GetElementsEpoly #(obj))[1]
			ElementsCount = Elements.Count
			
			for i=1 to ElementsCount do 
			(
				Clones = #()
				maxOps.cloneNodes instances cloneType:#copy newNodes:&Clones
				copyObj = Clones[1]
				polyop.deleteFaces copyObj -Elements[i] delIsoVerts:true
				
-- 				wirecolor = color (random 100 255) (random 100 255) (random 100 255)
				wirecolor	= obj.wirecolor
				for o in Clones do o.wirecolor = wirecolor
					
				for c=1 to Clones.count do Clones[c].name = (obj.name + "_Expl_"+ c as string)
				
				for c in Clones do append finalSel c
			)
			
			delete instances
		)
		select finalSel
		
	)
)