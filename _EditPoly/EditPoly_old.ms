
/** Edit poly
 */
struct EditPoly_v_old
(
	obj,

	EditPoly,
	EditablePoly,

	final_sel = #(),

	/** Explode
	  * @param	[bitArray]	poly_selections	Array of bitarrays to detach
	  * @return	selection	
	  *
	 */
	function explode poly_selections =
	(
		print ( "EditPolyExplode_v.explode() poly_selections=" + poly_selections as string )
		final_sel = #()

		for poly_selection in poly_selections do
			this.detach poly_selection

		--print ( "final_sel=" + final_sel as string )
		final_sel --return
		--append final_sel detObj
	),
	/** Detach
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
	/** Explode object by elements
	 */
	function explodeByElement =
	(	
		this.explode ( this.getElements() ) --return
		final_sel
	),
	/**  
	 */
	function explodeBySG =
	(
		this.explode ( this._getSmoothGroups() ) --return
	),
	/** Explode by material id
	 */
	function explodeByMaterialId =
	(
		this.explode ( this._getMaterialElements() ) --return
	),
	/**  
	 */
	function explodeByHardEdges =
	(
		--print "explodeByHardEdges()"
		this.selectHardEdges()

		this.splitEdges()

		this.explodeByElement() --return

		--#(obj)
		--undefined --return
	),
	/** Split edges
	 */
	function splitEdges =
	(
		this.setEditPoly()

		if( EditPoly!=undefined ) then
			EditPoly.ButtonOp #SplitEdges
			--print "!!!EditPoly!!!!"
		else if( EditablePoly!=undefined ) then
			EditablePoly.splitEdges ()
			--print "!!!EditablePoly!!!!"
	),
	/** Set edit poly
	 */
	function setEditPoly =
	(
		this.setEditablePoly()
		--print "setEditPoly"
		--print( classOf obj.modifiers[1] == #Edit_Poly )
		for _modifier in obj.modifiers do
			if( classOf _modifier == Edit_Poly and EditPoly==undefined) then
				EditPoly = _modifier
				--print ( "Edit_Poly=" + (classOf _modifier == Edit_Poly ) as string )
	),
	/** Set edit poly
	 */
	function setEditablePoly =
	(
		EditablePoly = obj.EditablePoly
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
	/** Get smooth groups
	 */
	function _getSmoothGroups =
	(
		smooth_groups = #()
		maxops.CollapseNode obj off
		--smGroupsArray = polyop.getFaceSmoothGroup obj firstFace;
		face_num = polyop.getNumFaces obj

		for sg_id = 1 to 32 do
		(
			smooth_group_face = #()

			for f=1 to face_num do
			--(
				if (( polyop.getFaceSmoothGroup obj f) == sg_id) then
					append smooth_group_face f
			--)
			--smooth_group_face = smooth_group_face as bitArray

			print ( "smooth_group_face=" + smooth_group_face as string )
			if  (  smooth_group_face.count > 0 and ( (smooth_group_face as array)[1] == 1 and smooth_group_face.count == face_num)==false ) then
				append smooth_groups smooth_group_face
		)
		smooth_groups --return
	),
	/** Select hard edges
	 */
	function selectHardEdges =
	(
		print "----selectHardEdges----"

		select obj
		--setCommandPanelTaskMode #modify
		max modify mode

		subobjectLevel = 2   
		macros.run "PolyTools" "SharpEdges"

		this --return
	),
	/** Auto smooth
	 */
	function autoSmooth value =
	(
		this.setEditPoly()

		if( EditPoly!=undefined ) then
		(
			--EditPoly.autoSmoothThreshold = value
			EditPoly.ButtonOp #Autosmooth
		)
		else if( EditablePoly!=undefined ) then
		(
			--EditablePoly.autoSmoothThreshold = value

			EditablePoly.autosmooth()
		)
	),
	/** Clear smooth groups
	 */
	function clearSmoothGroups =
	(
		this.setEditPoly()

		if( EditPoly!=undefined ) then(
			--EditPoly.ButtonOp #Autosmooth
			EditPoly.SetOperation #SetSmooth
			EditPoly.smoothingGroupsToSet = 0
			EditPoly.smoothingGroupsToClear = -1

		)else if( EditablePoly!=undefined ) then
		(
			--EditablePoly.SetSelection #Face (this._allFaces())
			--EditablePoly.setSmoothingGroups 0

			theObj = obj.baseObject
			facelist = polyop.getnumfaces theObj

			for i = 1 to facelist do
				polyop.setFaceSmoothGroup theObj i 0

		)
	),

	/** Set smooth group
	 */
	function setSmoothGroup smooth_group facelist:undefined =
	(
		polyop.setFaceSmoothGroup obj #all 0

		if( facelist==undefined ) then
			facelist = this._allFaces()
		--print ( "facelist=" + facelist as string )
		polyop.setFaceSmoothGroup obj facelist smooth_group
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
