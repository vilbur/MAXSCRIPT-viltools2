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
		
		epoly_infos = #(
			#("Info_ignoreBackfacing",	((Epoly_v()).ignoreBackfacing state:#get),	"color:green" ),
			#("Info_constrain",	((Epoly_v()).constrain state:#get),	"color:orange" )			   
		)
		
		_ViewportText = (ViewportText_v()).instance "epoly_info"
		
		--_ViewportText.test()
		_ViewportText.box epoly_infos
		
		_ViewportText.update()
		
		--print ( "epoly_infos = " + epoly_infos as string )
		--for epoly_info in epoly_infos do
		--	(
		--		_ViewportText 	= (ViewportText_v()).instance epoly_info[1]
		--		
		--		
		--		if( epoly_info[2] == true or epoly_info[2] == 1 ) then
		--			_ViewportText.show epoly_info[1]	
		--		else
		--			_ViewportText.hide()
		--		
		--
		--	)
			
		
		
		
		--print ( "ignoreBackfacing " + ((Epoly_v()).ignoreBackfacing state:#get) as string  )
		--print ( "constrain " + ((Epoly_v()).constrain state:#get) as string  )
		--print ( "preserveUvs " + ((Epoly_v()).preserveUvs state:#get) as string  )
		
		--if(Epoly.ignoreBackfacing state:#get == true ) then
		--	_ViewportText.show "Backfacing"
		--
		--else			
		--	_ViewportText.hide()
		
		--print ( "ignoreBackfacing " +	Epoly.ignoreBackfacing state:#get as string  )
		--print ( "constrain " +	Epoly.constrain state:#get as string  )
		--print ( "preserveUvs " +	Epoly.preserveUvs state:#get as string  )			
		
	)
	
	
)
	



