/** Layer
 */
struct Layer_v
(
	current,
	
	/** Toggle
	  * @param	string|name|array	_layers_A|_layers_B
	  * @example 
			_layers_A = "Layer name"  
			_layers_A = #Layer_name 
			_layers_A = #( "Layer name A", #Layer_name_B )
	  
	 */
	function toggle _layers_A _layer_B =
	(
		clearListener()
		this.setCurrentLayer()
		print ( "_layers_A = " + _layers_A as string )
		layers_A = this._getLayers (this._sanitizeLayerNames _layers_A)
		
		layers_A_visible = this._getVisibleLayers layers_A
		
		this.turnOnAllLayers()
		--print ( "layers_A_visible = " + layers_A_visible as string )
		--print ( "layers_A = " + layers_A as string )
		--print ( "this._sanitizeLayerNames _layers_A = " + (this._sanitizeLayerNames _layers_A) as string )
		this.hideAllLayers excludes:( if layers_A_visible.count > 0 then layers_A else ( this._getLayers (this._sanitizeLayerNames _layers_B) ) )
		--print ( "this.allLayers() = " + this.allLayers() as string )
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
	),
	/** Set current layer
	 */
	function setCurrentLayer =
	(
		current = LayerManager.current
		
		--layer = LayerManager.getLayer current
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
