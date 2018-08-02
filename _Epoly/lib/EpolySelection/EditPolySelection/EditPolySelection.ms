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
	function setSelection sub_obj facelist_array =
	(
		_objs = this._objects()
		
		for o=1 to _objs.count do
		(
			sub_selection	= if( classOf facelist_array == Array )then facelist_array[o] else facelist_array
			_mod.SetSelection	sub_obj #{}	node: _objs[o]
			_mod.Select	sub_obj sub_selection	node: _objs[o]
		)
	),
	
	/** Get ausing b
	 */
	function getAusingB subo_A subo_B subobjects =
	(
		subobjects_b = #{}
		
		case of
		(
			( subo_A == #Vertex	and subo_B == #Edge	): _mod.getVertsUsingEdge &subobjects_b subobjects
			( subo_A == #Vertex	and subo_B == #Face	): _mod.getVertsUsingEdge &subobjects_b subobjects
			( subo_A == #Edge	and subo_B == #Vertex	): _mod.getEdgesUsingVert &subobjects_b subobjects
			( subo_A == #Edge	and subo_B == #Face	): this.getEdgesUsingFace subobjects_b subobjects
			( subo_A == #Face	and subo_B == #Vertex	): _mod.getFacesUsingVert &subobjects_b subobjects
			( subo_A == #Face	and subo_B == #Edge	): _mod.getFacesUsingEdge &subobjects_b subobjects
		)
		print ( "subobjects_b = " + subobjects_b as string )
		subobjects_b --return
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
	/** _objects
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
	function getEdgesUsingFace return_barray subobjects =
	(
		iFaceDeg = 0
		
		for iFace in (subobjects as array) do
		(
			iFaceDeg = mod.getFaceDegree iFace
			--print ("faceIndex: " + iface as string + " degree: " + iFaceDeg as string)
			for i = 1 to iFaceDeg do 
				return_barray[_mod.getFaceEdge iFace i] = true
		)
		return_barray
	),
	function test =
	(
		messagebox "EditPolySelection.test()"
	)
)
