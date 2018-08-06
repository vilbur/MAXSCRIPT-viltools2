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
		print ( "UnityExportNode_v._construct() = " + (this.isExportNodeSelected()) as string )
		if( this.isExportNodeSelected() ) then
			this.setSelectedNode()
		
	),
	/** Create
	 */
	function create =
	(
		print "create()"
		this.setNode()

		this.createExportLayer()
		
		this.addCallback()
	),
	/** Assign
	 */
	function assign =
	(
	 
	),
	
	/** Set node
	 */
	function setNode =
	(
		print "setNode()"

		 if( this.isExportNodeSelected()  ) then
			this.setSelectedNode()
		
		else
			this.createNodeObject()
	),
	/** Create node object
	 */
	function createNodeObject =
	(
		_node = text name:name text:name isSelected:on size:1000
		--print ( "path = " + path as string ) 
		this._setUserProp "unity-export-node"	true
		this.setExportDir path

		(SelectionSets_v()).create name _node
		
		--_node --return
	),
	/** Set selected node
	 */
	function setSelectedNode =
	(
		--print ( "setSelectedNode = " + setSelectedNode as string )
		--print ( "selection = " + selection[1] as string )
		_node = selection[1]

		name	= _node.name
		path	= getUserProp _node "export-dir"
		
		_node.text = name
	),
	/** Is export node selectedtt
	 */
	function isExportNodeSelected =
	(
		classOf selection[1] == text and getUserProp selection[1] "unity-export-node" != undefined 
	),
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	/** Remove callback
	 */
	function removeCallback =
	(
		try( callbacks.removeScripts #selectionSetChanged id:#onUnityExportNodeSelected )catch()
	),
	/** Add callback
	 */
	function addCallback =
	(
		this.removeCallback()
		
		try( callbacks.addScript #selectionSetChanged "onUnityExportNodeSelected()" id:#onUnityExportNodeSelected )catch()
	),
	
	/*---------------------------------------
		NODE USER PROPERTIES
	-----------------------------------------*/
	/** Set export dir
	 */
	function setExportDir dir =
	(
		this._setUserProp "export-dir"	dir
	),
	
	/** Set user prop
	 */
	function _setUserProp key value =
	(
		setUserProp _node key	value
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
