/** Unity export node
 */
struct UnityExportNode_v
(
	_node,
	name	= if( maxFileName != "" ) then ( ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_-]\d+$" ).Replace (getFilenameFile maxFileName) "" ) else ""  ,
	path	= @"c:\Samdosoft\Test Prototype Internal Assets\Assets\FBX - MODEL\_vilbur\ExportTest",

	/* PRIVATE */
	_export_layer,
	_export_layer_name = "Export-Unity",
	
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
		_node = text name:name text:name isSelected:on
		
		setUserProp _node "unity-export-node" true

		this.createExportLayer()
		
		this.addCallback()
	),
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	/** Add callback
	 */
	function addCallback =
	(
		try( callbacks.removeScripts #selectionSetChanged	                           id:#onUnityExportNodeSelected )catch()
		try( callbacks.addScript     #selectionSetChanged "onUnityExportNodeSelected()" id:#onUnityExportNodeSelected )catch()
	),
	
	/*---------------------------------------
		LAYER
	-----------------------------------------*/
	/** Create export layer
	 */
	function createExportLayer =
	(
		_export_layer = this._findExportLayer()
		
		if( _export_layer == undefined ) then
			_export_layer	= LayerManager.newLayerFromName _export_layer_name
		
		print ( "_export_layer = " + _export_layer as string )
		
		_export_layer.addNode _node
		
	),
	/** _find export layer
	 */
	function _findExportLayer =
	(
		(for layer in this._allLayers() where layer.name == _export_layer_name collect layer)[1] --return first item from collection
	),
	/** All layers
	 */
	function _allLayers =
	(
		for i = 0 to LayerManager.count - 1 collect LayerManager.getLayer i
	),
	
	
	
	function test =
	(
		messagebox "UnityExportNode.test()"
	),
	
	__construct = this._construct()
)
