/** Unity export node
 */
struct UnityExportNode_v
(
	_node,
	name	= if( maxFileName != "" ) then ( ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_-]\d+$" ).Replace (getFilenameFile maxFileName) "" ) else ""  ,
	path	= @"c:\Samdosoft\Test Prototype Internal Assets\Assets\FBX - MODEL\_vilbur\ExportTest",

	
	/** Construct
	 */
	function _construct =
	(
		--messageBox "_construct" beep:false
	),
	/** Create
	 */
	function create =
	(
		_node = text text:name isSelected:on
			setUserProp _node "unity-export-node" true

	),
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	function test =
	(
		messagebox "UnityExportNode.test()"
	),
	
	__construct = this._construct()
)
