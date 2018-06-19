
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
		print ( "explode() poly_selections=" + poly_selections as string )
		final_sel = #()

		for poly_selection in poly_selections do
			this.detach poly_selection
			
		--print ( "final_sel=" + final_sel as string )
		final_sel --return
		--append final_sel detObj
	),
	/** Detach
	  *
	  * 
	 */
	function detach poly_selection =
	(
		polyop.detachFaces obj poly_selection delete:false asNode:true name: "TempDet"
		
		detObj = getnodebyname "TempDet" 
		detObj.name = (uniquename (obj.name + "_detach"))
		detOBj.wirecolor =  color (random 0 255) (random 0 255) (random 0 255)
		
		append final_sel detObj
	),

	/** Attach
	 */
	function attachSelection weld =
	(
		if selection.count > 1 do
		(
			undo "Attach_Selected_v" on
			(
				for o=1 to (selection.count - 1 ) where superclassof selection[o] == geometryclass do 
				(
					AddModifier selection[o] (Edit_Poly())
					maxOps.CollapseNode selection[o] off
				)
	
				maxOps.CollapseNodeTo  selection[selection.count] 1 off
	
				while selection.count > 1 do
				(
					selcount = selection.count
					for i = selcount to 2 by -2 do
						polyop.attach selection[i] selection[i-1]
				)
				update selection[1]
	
				if weld == true do
					(polyop.weldVertsByThreshold selection[1] #{1..( polyop.getNumVerts selection[1])}) --weld vetices
	
			)
		)
	),
	/** Explode
	 */
	function explodeByElement =
	(
		instances = #()		
		obj_instance = #()
		if classof obj != editable_poly do 
		(
			addmodifier obj (Edit_Poly ())
			maxOps.CollapseNodeTo obj 1 off
		)
		
		InstanceMgr.GetInstances obj &obj_instance
		join instances obj_instance		
			
		this.explode ( this.getElements() ) --return

	),
	/** Get elements
	 */
	function getElements =
	(

		faces = #{}
		objFaces = this._allFaces()
		objFaces_count = objFaces.count
		CurObj = polyop

		getElement = CurObj.getElementsUsingFace

		elements = for i in objFaces where objFaces[i] == true collect
		(
			element = getElement obj i
			objFaces -= element
			element
		)

		elements --return		
	),
	/** Explode by material id
	 */
	function explodeByMaterialId =
	(
			--print ( "Detaching: " + obj.name as string)
			final_sel = #()

			if (classOf obj != Editable_Poly) do
			(
				convertTo obj Editable_Poly
				polyop.deleteIsoVerts obj
			)
			
			try ( maxops.CollapseNodeTo obj 1 off) catch ()
			
			--print ( "this._getMaterialElements() =" + this._getMaterialElements()  as string )
			--final_sel = this.explode ( this._getMaterialElements() )
			--print ( "final_sel=" + final_sel as string )	
			--final_sel
			this.explode ( this._getMaterialElements() ) --return
		--)
	),
	/** Get material elements
	  * @return	[bitArray]	Array of faces by material
	 */
	function _getMaterialElements =
	(
		all_ids	= #()
		material_faces	= #();

		--print "_getMaterialElements"
		for f=1 to polyop.getNumFaces obj do
			appendIfUnique all_ids ( polyop.getFaceMatID obj f)
		
				id = 1
		for id in all_ids do
			append material_faces ((for f=1 to polyop.getNumFaces obj where polyop.getFaceMatID obj f == id collect f) as bitarray)

		material_faces --return
	),
	/**  
	 *	
	 */
	function explodeBySG =
	(
		print ( "----explodeBySG" )
		--print ( "polyop.getNumFaces obj=" + polyop.getNumFaces obj as string )
		--final_sel = #()
		--face_num	= polyop.getNumFaces obj

		poly_selections = #()
		maxops.CollapseNode obj off
		--smGroupsArray = polyop.getFaceSmoothGroup obj firstFace;
		face_num = polyop.getNumFaces obj
		
		for sg_id = 1 to 32 do
		(
			--print ( "sg_id=" + sg_id as string )
			--poly_selection = #{}
			poly_selection = #()

			for f=1 to face_num do
			(
				--print ( "face=" + f as string )
				--sg_f = polyop.getFaceSmoothGroup obj f
			--print ( "sg_f=" + sg_f as string )
				if (( polyop.getFaceSmoothGroup obj f) == sg_id) then
				(
					--print ( "id=" + ( polyop.getFaceSmoothGroup obj f ) as string )
					append poly_selection f
					--poly_selection[sg_id] = true; 
					
				)
			)
			--poly_selection = poly_selection as bitArray
			
			print ( "poly_selection=" + poly_selection as string )
			if  (  poly_selection.count > 0 and ( (poly_selection as array)[1] == 1 and poly_selection.count == face_num)==false ) then
				append poly_selections poly_selection
		)
		--print ( "poly_selections=" + poly_selections as string )
		--print ( "poly_selections=" + poly_selections as bitArray )
		this.explode ( poly_selections ) --return

		--for poly_selection in poly_selections do
			--this.detach poly_selection
				
		--#() --return
	),




	/** Set smooth group
	 */
	function setSmoothGroup facelist smooth_group =
	(
		polyop.setFaceSmoothGroup obj #all 0

		--print ( "facelist=" + facelist as string )
		polyop.setFaceSmoothGroup obj (this._allFaces()) smooth_group
	),
	/** Set mat id
	 */
	function setMatId id =
	(
		print ( "setMatId=" + id as string )
		--if (classOf obj != Editable_Poly) do
		--(
		--	convertTo obj Editable_Poly
		--	polyop.deleteIsoVerts obj
		--)
		
		polyop.setFaceMatID obj #{1..( polyop.getNumFaces obj)} id
   
	),
	/** _all faces
	 */
	function _allFaces =
	(
		#{1..( polyop.getNumFaces obj)} --return
	),

	function test =
	(
		messagebox "EditPoly.test()"
	)
)
filein ( getFilenamePath(getSourceFileName()) + "/lib/EditPolyObjects/EditPolyObjects.ms" )
