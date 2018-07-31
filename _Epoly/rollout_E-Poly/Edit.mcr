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
 *		#edge	- Connect edges
 *		#border	- Do nothing
 *		#face	- Connect middles of edges
 */
macroscript	epoly_connect
category:	"_Epoly-Edit"  
buttonText:	"Connect"
tooltip:	"Connect subobject"
(
	undo "Connect subobject" on
	(
		Epoly = Epoly_v()

		if not ( Epoly.Mod.current() or subObjectLevel ) then
			return false
			
		if( subObjectLevel == 1 ) then
		(
			Epoly.selection.get #vertex
			
			
		)
	
		

		--(Epoly_v()).connect()
	)
)