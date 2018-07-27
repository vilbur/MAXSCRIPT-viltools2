/** Layer
 */
struct Layer_v
(
	current,
	
	/** Toggle
	  * @param	string|name|array	layer_name
	  * @example 
			layer_name = "Layer name"  
			layer_name = #Layer_name 
			layer_name = #( "Layer name A", #Layer_name_B )
	  
	 */
	function toggle layer_names =
	(
		clearListener()
		--this.setCurrentLayer()
		--print ( "layer_names = " + layer_names as string )
		layers = this._getLayers (this._sanitizeLayerNames layer_names)
		
		--layers_A_visible	= this._getVisibleLayers layers
		--layers_to_on	= if layers_A_visible.count > 0 then layers else ( this._getLayers (this._sanitizeLayerNames _layers_B) )
		--this.turnOnAllLayers()
		--print ( "layers_A_visible = " + layers_A_visible as string )
		print ( "layers = " + layers as string )


		state	= layers[1].on != true
		
		
		for layer in layers do
			layer.on = state
		
	),
	/** Hide all layers
	 */
	function hideAllLayers excludes:#() =
	(
		--print ( "this._sanitizeLayerNames excludes = " + (this._sanitizeLayerNames excludes) as string )
		excludes = this._getLayers (this._sanitizeLayerNames excludes)
		--print ( "excludes = " + excludes as string )
		for layer in this.allLayers() do
			if( findItem excludes layer == 0 ) then
				layer.on = false
				--layer.on = false
	),
	/** Activate layer
	 */
	function activate layer_name =
	(
		layer	= this.getLayer layer_name
		
		if( layer == undefined ) then
			return false
			
		print ( "Layer = " + layer as string )
		layer.current	= true
		layer.on	= true
		--layer.visibility	= 1.0
	),
	/** Set current layer
	 */
	function setCurrentLayer =
	(
		current = LayerManager.current
	),
	--/** Set count
	-- */
	--function count =
	--(
	--	for i = 1 to (LayerManager.count - 1) collect i
	--
	--),
	/** Turn on all layers
	 */
	function turnOnAllLayers =
	(
		for layer in this.allLayers() do
			layer.on = true

	),
	/** All layers
	 */
	function allLayers =
	(
		for i = 0 to LayerManager.count - 1 collect LayerManager.getLayer i
	),
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** _get layers
	 */
	function _getLayers names =
	(
		print ( "names = " + names as string )
		for layer in this.allLayers() where findItem names layer.name > 0 collect layer
	),
	/** Get layer by index or name
	  * classOf name is converted to lowercase string E.G.: #LayerName become "LayerName"
	  *
	  * @param	integer|string|name	layer_name_index
	  * return [LayerProperties MixinInterface](http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_78B79975_7BA5_4A03_8FEF_27E78D14B575_htm)
	 */
	function getLayer layer_name_index =
	(
		print ( "getLayer = " + layer_name_index as string )
		if( classOf layer_name_index == integer ) then
			LayerManager.getLayer layer_name_index --return
		
		else
		--print ( "getLayerFromName = " + ( LayerManager.getLayerFromName ( layer_name_index as string ) ) as string )
			LayerManager.getLayerFromName ( layer_name_index as string ) --return
		--print ( "layer = " + layer as string )
		--layer --return 
	),
	/** Sanitize layer names
	 */
	function _sanitizeLayerNames names =
	(
		if( classOf names != Array ) then
			names = #( names )
			
		 for _name in names collect ( _name as string ) --return
		 
		--print ( "names = " + names as string )
		--sanitized = for _name in names collect ( _name as string )
		--print ( "sanitized = " + sanitized as string )
		--sanitized --return
	),
	/** Is any lyaer visible
	 */
	function _getVisibleLayers layers =
	(
		for layer in layers where layer.ishidden == false collect layer 
	),
	/** Is visible
	 */
	function _isVisible index =
	(
		
	),
	function test =
	(
		messagebox "Layer.test()"
	)
)
