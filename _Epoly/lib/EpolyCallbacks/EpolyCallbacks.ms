/** Epoly callbacks
 */
struct EpolyCallbacks_v
(
	id	= #onSelectionChangengeCallback_modPanelObjPostChange,

	/** Remove edpoly callbacks
	 */
	function remove =
	(
		--try( callbacks.removeScripts #selectionSetChanged id:#onSelectionChangengeCallback_selectionSetChanged )catch()
		try( callbacks.removeScripts #modPanelObjPostChange id:id )catch()
	),
	
	/** Add edpoly callbacks
	 */
	function add =
	(
		print "====== EpolyCallbacks_v.add()"
		this.remove()
		
		--try( callbacks.addScript     #selectionSetChanged "onSelectionChangengeCallback()" id:#onSelectionChangengeCallback_selectionSetChanged )catch()
		try( callbacks.addScript     #modPanelObjPostChange "onSelectionChangengeCallback()" id:id )catch()
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
		Epoly	= Epoly_v()
		--_ViewportText 	= (ViewportText_v()).instance "ViewportTexTest" 

		print ("\n\n====== onSelectionChangengeCallback " + modPanel.getCurrentObject() as string )
		
		_ViewportText = (ViewportText_v()).instance "epoly_info"

		_ViewportText.box (Epoly.getEpolyInfo())
		
		_ViewportText.update()
	
	)
	
	
)
	



