/** Edit poly
 */
struct EditPoly_v
(
	obj,
	final_sel = #(),

	/** Explode
	  * @param	[bitArray]	poly_selections	Array of bitarrays to detach
	  * @return	selection	
	  *
	 */
	function explode poly_selections =
	(
		print ( "poly_selections=" + poly_selections as string )
		
		for poly_selection in poly_selections do
			this.detach poly_selection
			
		final_sel --return
		--append final_sel detObj
	),
	/** Detach
	  *
	  * 
	 */
	function detach poly_selection =
	(
		--select obj
		--print ( "poly_selection=" + poly_selection as string )
		--print ( "polyop.getNumFaces obj=" + polyop.getNumFaces obj as string )
		--print ( "poly_selection.count =" + poly_selection.count  as string )

		--if( polyop.getNumFaces obj > poly_selection.count ) then
		--(
			polyop.detachFaces obj poly_selection delete:false asNode:true name: "TempDet"
			detObj = getnodebyname "TempDet" 
			detObj.name = (uniquename (obj.name + "_detach"))
			detOBj.wirecolor =  color (random 0 255) (random 0 255) (random 0 255)
			append final_sel detObj

		--)
	),
	/**  
	 *	
	 */
	function explodeBySG =
	(
		print ( "----explodeBySG" )
		--sel = #()				
		print ( "polyop.getNumFaces obj=" + polyop.getNumFaces obj as string )

		face_num	= polyop.getNumFaces obj
		--objName = obj.name
		--sg = 1;
		--poly_selections = #{};
		poly_selections = #()
		
		
		maxops.CollapseNode obj off
		--smGroupsArray = polyop.getFaceSmoothGroup obj firstFace;
		FaceCount = polyop.getNumFaces obj;
		

		for sg = 1 to 32 do
		(
			--print ( "sg=" + sg as string )
			poly_selection = #()

			for i=1 to FaceCount do 
							
				if ((polyop.getFaceSmoothGroup obj i) == sg) then 
					append poly_selection i; 
					
				
			--print ( "------( poly_selections.count < face_num )=" + ( poly_selections.count < face_num ) as string )
			--print ( "poly_selections=" + poly_selections as string )
			--print ( "poly_selections as array)[1] =" + ((poly_selections as array)[1]) as string )
			--print ( "poly_selections as array)[1] > 1  =" + ((poly_selections as array)[1] > 1) as string )
			--print ( "poly_selections.count =" + poly_selections.count  as string )
		
			if  (  poly_selection.count > 0 and ( (poly_selection as array)[1] == 1 and poly_selection.count == face_num)==false ) then
				append poly_selections poly_selection
					--print ( "poly_selections=" + poly_selections as string )
					
				--polyop.detachFaces obj poly_selections delete:true asNode:false -- name:(uniquename objNane)
			--print ( "poly_selections=" + smooth_group_all as string )
		)
		
		for poly_selection in poly_selections do
			--print ( "poly_selection=" + poly_selection as string )
			this.detach poly_selection
			--Explode_Elements_v obj
				
		final_sel --return

	),

	
	
	function test =
	(
		messagebox "EditPoly.test()"
	)
)
