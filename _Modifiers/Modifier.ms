/** Modifier
 */

struct Modifier_v
(
	name,
	type,
	
	Modifiers	= Modifiers_v(),
	--type="Edit_Poly",
	
	_modifier,
	
	/** Get
	 */
	function add =
	(
		type = type as string
		
		this._setModifier()
		
		this._getName()
		
		modPanel.addModToSelection _modifier ui:on
		
		_modifier --return
	),
	
	/** Get instances
	 */
	function getInstances _objects _modifier =
	(
		for o in _objects where (refhierarchy.isRefTargetInstanced _modifier ) collect o
	),
	/** _set modifier
	 */
	function _setModifier =
	(
		if( hasProperty Modifiers type ) then
			_modifier = getProperty Modifiers type --return 
		else
			_modifier = execute (type+"()") --return

	),
	/** _get name
	 */
	function _getName =
	(
		
		if( name!=undefined ) then
			_modifier.name = name
		
		--print ( "classOf type=" + type as string )
	),
	function test =
	(
		messagebox "Modifiers.test()"
	)
)



