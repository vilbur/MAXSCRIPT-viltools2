/** Edit poly selection
 */
struct EditPolySelection_v
(
	Epoly,

	_mod,	-- set by EpolySelection_v
	--_objects,
	
	/** Get current selection of subobject
	  * @param	name	sub_obj
	  * @return	bitArray|[bitArray]	bitArray of selected elements or array of bitArrays for each object if Edit_Poly
	  */
	function getSelection sub_obj =
	(		
		for o in this._objects() collect ( _mod.GetSelection sub_obj node:o) --return
	),	
	/** Set edit poly selection of subobjects 
	  * @param	name	sub_obj
	 */
	function setSelection sub_obj sub_objs =
	(
		print ("EditPolySelection_v.setSel()" + " sub_obj: " + sub_obj as string + " sub_objs: " + sub_objs as string )
		_objs = this._objects()
		--print ( "_objs = " + _objs as string )
		sub_obj = Epoly.Subobject.getIndex sub_obj
		print ( "sub_obj = " + sub_obj as string )
		print ( "_mod = " + _mod as string )
		for o=1 to _objs.count do
		(
			sub_selection	= if( classOf sub_objs == Array ) then sub_objs[o] else sub_objs
			print ( "_objs[o] = " + _objs[o] as string )
			print ( "sub_selection = " + sub_selection as string )
			_mod.SetSelection	sub_obj #{}	node: _objs[o]
			_mod.Select	sub_obj sub_selection	node: _objs[o]
		)
	),
	
	
	/** Get ausing b
	 */
	function getAusingB subo_A subo_B subobjects =
	(
		print ("EditPolySelection_v.getAUsingB" + " subo_A: " + subo_A as string + " subo_B: " + subo_B as string + " subobjects: " + subobjects as string)
		subobjects_b = #{}
		
		case of
		(
			( subo_A == #Vertex	and subo_B == #Edge	): _mod.getVertsUsingEdge &subobjects_b subobjects
			( subo_A == #Vertex	and subo_B == #Face	): _mod.getVertsUsingEdge &subobjects_b subobjects
			( subo_A == #Edge	and subo_B == #Vertex	): _mod.getEdgesUsingVert &subobjects_b subobjects
			( subo_A == #Edge	and subo_B == #Face	): this.getEdgesUsingFace &subobjects_b subobjects
			( subo_A == #Face	and subo_B == #Vertex	): _mod.getFacesUsingVert &subobjects_b subobjects
			( subo_A == #Face	and subo_B == #Edge	): _mod.getFacesUsingEdge &subobjects_b subobjects
		)
		--print ( "subobjects_b = " + subobjects_b as string )
		subobjects_b --return
	),
	/** Convert current subobject to given subobject
	  * This method is there because of match methods in EditablePolySelection_v & EditPolySelection_v
	  */
	function convertSelection from_sub_obj to_sub_obj =
	(
		_objs = this._objects()

		for obj in _objs do 
		(
			select obj
			_mod.convertSelection  from_sub_obj to_sub_obj 
		)
		
		select _objs
	),
	/** Get outline edges of faces
	 */
	function getOutlineEdgesOfFaces faces_obj =
	(
		for faces in faces_obj collect 
		(
			edges_of_faces	= this.getAusingB #Edge #Face faces
			edges_of_inverted_faces	= this.getAusingB #Edge #Face (-faces)
			
			edges_of_faces * edges_of_inverted_faces
		)
	),
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** Set mod
	  * mod is set by EpolySelection_v
	  */
	function setMod __mod =
	(
		_mod = __mod
	),
	/** Get objects from Epoly
	 */
	function _objects =
	(
		Epoly._objects --return
	),
	--/** Set object
	-- */
	--function _setObjects =
	--(
	--	_objects = (Selection_v()).get()
	--	--_objects	= for obj in selection where superClassOf obj == GeometryClass collect obj
	--),
	/** Get edges using face
	 */
	function getEdgesUsingFace &return_barray subobjects =
	(
		print ( "EditPolySelection_.vgetEdgesUsingFace() return_barray:" + return_barray as string + " subobjects:" + subobjects as string  )
		face_deg = 0
		
		for face in (subobjects as Array ) do
		(
			face_deg = _mod.getFaceDegree face
			--print ("faceIndex: " + iface as string + " degree: " + face_deg as string)
			for i = 1 to face_deg do 
				return_barray[_mod.getFaceEdge face i] = true
		)
		return_barray
	),
	
	function test =
	(
		messagebox "EditPolySelection.test()"
	)
)
