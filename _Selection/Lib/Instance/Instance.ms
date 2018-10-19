
/** Instance
 */
struct Instance_v 
(
    parent,

--	fn init parent = (
--        self = parent
--    ),
	function test =
	(
		--messagebox "Instance.test()"
		print (parent.geometry())
		--parent.geometry()
	),
	/**  
	 */
	function instanceSelection =
	(
		messagebox "instanceSelection()" beep:false;
	--	if classof _selection != array then
	--		_selection = for o in selection where superclassof o == GeometryClass collect o
	--
	--	instances	= #();
	--	unSelInstances	= #();
	--	finSel	= #();
	--
	--	if _selection.count > 0 then
	--	(
	--		for o in _selection do
	--		(
	--			obj_instance
	--			testInst = (InstanceMgr.GetInstances o &obj_instance)
	--			if testInst > 1 then
	--			(
	--				join instances obj_instance
	--	
	--				for inst in instances do
	--				(
	--					if (finditem unSelInstances inst == 0 ) then
	--						appendifunique finSel o
	--
	--					appendifunique unSelInstances inst
	--				)
	--			)
	--			else
	--				appendifunique finSel o
	--		)
	--	)
	---- 		print ("finSel: " + finSel as string)
	--		if doSel == 1 then select	finSel
	--	finSel	
	)

	
)
