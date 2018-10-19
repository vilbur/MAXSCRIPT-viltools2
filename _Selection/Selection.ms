/* Import sub substructs */
filein ( (getThisScriptFilename()) + "/../Lib/Instance/Instance.ms" );
 
/** Selection_v
 */
struct Selection_v
(
	
	Instance = Instance_v parent:this,
	
	function test =
	(
		messagebox "Selection_v.test()"
	),
	/** Get selection of geometry 
	 *	@return	collection	
	 */
	function geometry =
	(
		for o in selection where superclassof o == GeometryClass collect o
	),
	/** Collapse selection
	 */
	function collapse =
	(
		for o in this.geometry() do
			maxOps.CollapseNodeTo o 1 off
	),
	/** Name
	 */
	function name _name =
	(
		_selection	= this.geometry()
		
		if( _name=="file" ) then
			_name = getFilenameFile maxFileName 
		
		_name	= ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_-]\d+$" ).Replace _name "" -- remove 
		
		if( _selection.count == 1 ) then 
			selection[1].name = _name
		
		else
			for o in _selection do
				o.name = uniqueName _name
	),
	/**  
	 *	
	 */
	function get =
	(
		--print (this.geometry())
		this.geometry() --return
	),
	/**  
	 *	
	 */
	function test =
	(
		messagebox "Selection.test()"
	)
	
	--function Instance_Test_v doSel _selection =
	--(
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
	--)

	
)