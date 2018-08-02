macroscript	epoly_remove
category:	"_Epoly-Edit"  
buttonText:	"Remove"
tooltip:	"Remove subobject"
(
	undo "Remove subobject" on
	(
		(Epoly_v()).remove()
	)
)

macroscript	epoly_target_weld
category:	"_Epoly-Edit"  
buttonText:	"Target Weld"
tooltip:	"Target Weld"
(
	Epoly = Epoly_v()

	if( subObjectLevel != 1  ) then
		subObjectLevel = 1

	Epoly.targetWeld()

)
/**  
 *	If subobject:
 *		#vertex	- A) Connect to last selected vertex, if selected vertices are on one face
 *			  B) Connect all vertices if vertices does not share one face
 *		#edge	- Connect edges, if one selected then select ring
 *		#border	- Do nothing
 *		#face	- Convert to #vertex and connect vertices
 */
macroscript	epoly_connect
category:	"_Epoly-Edit"  
buttonText:	"Connect"
tooltip:	"Connect subobject"
(
	
	
	On Execute Do (
		
		undo "Connect subobject" on
		(
			Epoly	= Epoly_v()
			connect_method	= #polyToolsConnect
			
			if not ( Epoly.Mod.setCurrent() or subObjectLevel ) then
				return false
			
			if( subObjectLevel == 4 ) then
				Epoly.convertSelection #vertex
			
			else if( subObjectLevel == 1 ) then
			(
				_selection	= Epoly.Sel.getSel #vertex
				shared_faces	= Epoly.Sel.getSharedAwithB #face #vertex _selection
				
				if( ( shared_faces as array ).count == 1 ) then 
					connect_method	= #ConnectToLastSelVert -- connect to last vertex if all faces shared one face
			)
			else if( subObjectLevel == 2 ) then
			(
				_selection	= Epoly.Sel.getSel #edge
				
				if( ( _selection as array ).count == 1 ) then 
					(Epoly.Mod.get()).SelectEdgeRing()
					
				connect_method = #ConnectEdges
			)
			print ( "connect_method = " + connect_method as string )
			case connect_method of
			(
				(#polyToolsConnect):	macros.run "Editable Polygon Object"	"EPoly_Connect"
				(#ConnectToLastSelVert):	macros.run "miauu"	"miauu_ConnectToLastSelVertAlt"
				(#ConnectEdges):	macros.run "Ribbon - Modeling"	"ConnectEdges"

			)
		)
	)
	
	/** Options menu item 
	 */
	On AltExecute type do (
		Try (
			If SubObjectLevel == undefined then Max Modify Mode
			local A = Filters.GetModOrObj()
			A.popupDialog #ConnectEdges
		)
		Catch()
	)
			
		
	
)