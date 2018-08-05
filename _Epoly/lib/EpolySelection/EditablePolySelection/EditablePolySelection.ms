/** Editable poly selection
 */
struct EditablePolySelection_v
(
	Epoly,

	obj,
	_mod,	-- set by EpolySelection_v
	
	/** Get current selection of subobject
	  * @param	name	sub_obj
	  * @return	bitArray|[bitArray]	bitArray of selected elements or array of bitArrays for each object if Edit_Poly
	  */
	function getSelection sub_obj =
	(		
		--this._setObject()
		_mod.GetSelection sub_obj --return
	),	
	/** Set editable poly selection of subobjects
	  * @param	name	sub_obj
	 */
	function setSelection sub_obj facelist =
	(
		_mod.SetSelection sub_obj facelist
	),
	
	/** Get ausing b
	  * @param	name	subo_A	Subobject convert FROM
	  * @param	name	subo_B	Subobject convert TO
	  *
	  * @param	BitArray|[BitArray]	subobjects for converting 
	 */
	function getAusingB subo_A subo_B subobjects =
	(
		print ("EditablePolySelection_v.getAUsingB" + " subo_A: " + subo_A as string + " subo_B: " + subo_B as string + " subobjects: " + subobjects as string)
		--this._setObject()
		--this.init()
		obj = this._obj()
		print ( "obj = " + obj as string )
		case of
		(
			( subo_A == #Vertex	and subo_B == #Edge	): polyop.getVertsUsingEdge obj subobjects
			( subo_A == #Vertex	and subo_B == #Face	): polyop.getVertsUsingFace obj subobjects
			( subo_A == #Edge	and subo_B == #Vertex	): polyop.getEdgesUsingVert obj subobjects
			( subo_A == #Edge	and subo_B == #Face	): polyop.getEdgesUsingFace obj subobjects
			( subo_A == #Face	and subo_B == #Vertex	): polyop.getFacesUsingVert obj subobjects
			( subo_A == #Face	and subo_B == #Edge	): polyop.getFacesUsingEdge obj subobjects
		)
	),
	/** Convert current subobject to given subobject
	  * This method is there because of match methods in EditablePolySelection_v & EditPolySelection_v
	  */
	function convertSelection from_sub_obj to_sub_obj =
	(
		_mod.convertSelection from_sub_obj to_sub_obj
	),
	/** Get outline edges of faces
	 */
	function getOutlineEdgesOfFaces faces =
	(
		edges_of_faces	= this.getAusingB #Edge #Face faces
		edges_of_inverted_faces	= this.getAusingB #Edge #Face (-faces)
		
		edges_of_faces * edges_of_inverted_faces --return
	),
	
	
	/*------------------------------------------------------------------------------
		PRIVATE
	------------------------------------------------------------------------------*/
	/** Set mod
	  * mod is set by EpolySelection_v
	 */
	function setMod __mod =
	(
		_mod = __mod
	),
	--/** Set object
	-- */
	--function _setObject =
	--(
	--	obj = ((Selection_v()).get())[1]
	--),
	/** _objects
	 */
	function _obj =
	(
		Epoly._objects[1] --return
	),	
	
	
	
	
	function test =
	(
		messagebox "EditablePolySelection.test()"
	)
)
