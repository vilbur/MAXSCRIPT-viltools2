/** Epoly callbacks
 */
struct EpolyCallbacks_v
(
	

	/** Remove edpoly callbacks
	 */
	function remove =
	(
		try( callbacks.removeScripts #selectionSetChanged id:#onSelectionChangengeCallback_selectionSetChanged )catch()
		try( callbacks.removeScripts #modPanelObjPostChange id:#onSelectionChangengeCallback_modPanelObjPostChange )catch()
	),
	
	/** Add edpoly callbacks
	 */
	function add =
	(
		print "====== EpolyCallbacks_v.add()"
		this.remove()
		
		--try( callbacks.addScript     #selectionSetChanged "onSelectionChangengeCallback()" id:#onSelectionChangengeCallback_selectionSetChanged )catch()
		try( callbacks.addScript     #modPanelObjPostChange "onSelectionChangengeCallback()" id:#onSelectionChangengeCallback_modPanelObjPostChange )catch()
	),
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	function test =
	(
		messagebox "EpolyCallbacks.test()"
	)
)

	/** On selection changenge callback
	 */
	function onSelectionChangengeCallback =
	(
		current_mod	= modPanel.getCurrentObject() 
		
		if( classOf current_mod == Editable_Poly or classOf current_mod == Edit_Poly ) then
		(
			print ("onSelectionChangengeCallback " + modPanel.getCurrentObject() as string )
			
			print ( "ignoreBackfacing " + ((Epoly_v()).ignoreBackfacing state:#get) as string  )
			
			
		)
		
		
	)
	



