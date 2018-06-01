fn Instance_Test_v doSel selObj =
(
	if classof selObj != array then
		selObj = for o in selection where superclassof o == GeometryClass collect o

	instances	= #();
	unSelInstances	= #();
	finSel	= #();

	if selObj.count > 0 then
	(
		for o in selObj do
		(
			obj_instance
			testInst = (InstanceMgr.GetInstances o &obj_instance)
			if testInst > 1 then
			(
				join instances obj_instance
	
				for inst in instances do
				(
					if (finditem unSelInstances inst == 0 ) then
						appendifunique finSel o

					appendifunique unSelInstances inst
				)
			)
			else
				appendifunique finSel o
		)
	)
-- 		print ("finSel: " + finSel as string)
		if doSel == 1 then select	finSel
	finSel	
)
