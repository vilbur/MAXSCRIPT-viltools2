fn ExplodeInstances_v  =	
(
/*
ExplodeInstances_v ( selection as array)
/*	
	*/
	objArray = for o in selection where superclassof o == GeometryClass collect o
	objArray = vilTools_InstanceTest objArray
	for o in objArray where classof o != editable_poly do maxOps.CollapseNodeTo o 1 off
	
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
			
			wirecolor = color (random 100 255) (random 100 255) (random 100 255)
			for o in Clones do o.wirecolor = wirecolor
				
			for c=1 to Clones.count do Clones[c].name = (obj.name + "_Expl_"+ c as string)
			
		)
		
		delete instances
	)
	
)