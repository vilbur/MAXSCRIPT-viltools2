macroscript	selection_random
category:	"_Selection"
buttontext:	"Random"
toolTip:	"Random"
--icon:	"#(path, index)"
(
	every = 2
	select (for obj in selection where random 1 every == every collect obj)
)

macroscript	selection_select_instances
category:	"_Selection"
buttontext:	"Instances"
toolTip:	"Select instances of object"
--icon:	"#(path, index)"
(
	only_visible	= false
	global instances		= #()
	
	for obj in selection do
	(	
		local obj_instance
		InstanceMgr.GetInstances obj &obj_instance
		join instances obj_instance	
	)
	
	if only_visible == 1 then for o in instances where  o.visibility == false do deleteitem instances (finditem instances o )
	
	
	select instances	
)

