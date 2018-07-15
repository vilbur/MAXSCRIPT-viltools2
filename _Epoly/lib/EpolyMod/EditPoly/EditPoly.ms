/** Methods for Edit_Poly modifier
 */
struct EditPoly_v
(
	mod,
	_selection,

	/** Init
	  * @return	boolean 	
	 */
	function init =
	(
		--print "EditPoly_v.init()"
		this._setObjects()
		this._setMod()

		this --return
	),
	/** Get facelist or all faces
	 */
	function getSelectedOrAllFaces  =
	(
		_selection_sub = (EpolySelection_v()).getSel #Face --return
		--print ( "EditPoly_v _selection_sub = " + _selection as string )
		if( _selection_sub.count == 1 and _selection_sub[1].isEmpty ) then
			this._allFaces() --return
		else
			_selection_sub --return
	),
	/** Quickslice
	 */
	function quickslice =
	(
		mod.EnterCommandMode #QuickSlice 
	),
	/** Connect subobject
	 */
	function connect =
	(
		sub_obj = subObjectLevel
		
		if sub_obj == 4 or sub_obj == 5 then
		(
			mod.ConvertSelection #face #vertex
			subObjectLevel = 1
			mod.ButtonOp #ConnectVertices
		)
		else if sub_obj == 1 then
			mod.ButtonOp #ConnectVertices

		else if sub_obj == 2 then	
		    mod.ButtonOp #ConnectEdges
	),
	/** Remove subobject
	 */
	function remove =
	(
		for obj in _selection do
		(
			case subObjectLevel of
			(
				1:( for_remove = #RemoveVertex )
				2:( for_remove = #RemoveEdgeRemoveVertices )
				3:( for_remove = #RemoveEdgeRemoveVertices )
				4:( mod.ConvertSelection #Face #Edge; for_remove = #RemoveEdgeRemoveVertices )
			)
			if( for_remove != undefined ) then
				mod.ButtonOp for_remove
		)
	),
	/** Extrude
	 */
	function extrude to_extrude options:true height:20 =
	(
		if options == true then
		(
			mod.PopupDialog to_extrude
			mod.extrudeEdgeWidth	= 20
			mod.extrudeEdgeHeight	= height
		)
		else
			mod.EnterCommandMode to_extrude
	),
	/** Target weld
	 */
	function targetWeld =
	(
		this.init()
		
		treshold = 1.0
		
		sel_count = _selection.count
		--if sel_count == 0 then 
			--(actionMan.executeAction 0 "40021"  -- Selection: Select All
		 
		--subObjectLevel = 1
	
		--oldTres = mod.weldVertexThreshold
		--messageBox "message" beep:false
		--mod.weldVertexThreshold  = treshold
		--mod.ButtonOp #WeldVertex
		mod.ButtonOp #TargetWeldVertex
		--mod.weldVertexThreshold = oldTres
		
		--if sel_count == 0 then mod.SetSelection #Vertex #{}
	),
	/** Face count
	 */
	function faceCount =
	(		
		face_counts = #()
		
		for obj in _selection do
			append face_counts ( polyop.getNumFaces obj )
		
		face_counts --return	
	),
	
	/** Set mat id
	 */
	function setMatId facelist id =
	(
		--messageBox "setMatId" beep:false
		subObjectLevel = 4
		(EpolySelection_v()).setSel #Face facelist

		mod.SetOperation #SetMaterial
		mod.materialIDToSet = (id - 1)
	),
	/** Make planar
	 */
	function makePlanar axis =
	(
		case axis of
		(
			#x: mod.ButtonOp #MakePlanarInX
			#y: mod.ButtonOp #MakePlanarInY
			#z: mod.ButtonOp #MakePlanarInZ
			default:	#MakePlanar
		)
	),
	/*---------------------------------------
		SMOOTH GROUPS
	-----------------------------------------*/
	/** Set smooth group
	  * @param	integer	smooth_group	
	  * @param	bitArray	facelists 	All faces used if facelist==undefined
	 */
	function setSmoothGroup smooth_group facelist:undefined =
	(
		
		--if( facelist == undefined ) then
		--	facelist = this._allFaces()
		--	
		--(EpolySelection_v()).setSel #Face facelist

		
		mod.SetOperation #SetSmooth
		mod.smoothingGroupsToSet = smooth_group
	),
	/** Auto smooth
	  * @param	integer	_angle
	 */
	function autoSmooth _angle =
	(
		mod.autoSmoothThreshold = _angle
		mod.ButtonOp #Autosmooth
	),
	/** Clear smooth groups
	 */
	function clearSmoothGroups =
	(
		mod.SetOperation #SetSmooth
		mod.smoothingGroupsToSet	= 0
		mod.smoothingGroupsToClear	= -1
	),
	/*---------------------------------------
		SELECTION
	-----------------------------------------*/
	/** Get current subobejct selection
	  * @param	name	sub_obj
	  * @return	bitArray|[bitArray]	bitArray of selected elements or array of bitArrays for each object if Edit_Poly
	  */
	function getSel sub_obj =
	(		
		this.init()
		for o in _selection collect (mod.GetSelection sub_obj node:o) --return

		------mod.GetSelection sub_obj --return
	),
	/** Set edit poly selection of subobjects 
	  * @param	name	sub_obj
	 */
	function setSel sub_obj facelist_array =
	(
		--print "======= _setEditPolySelection()"

		for o=1 to _selection.count do
		(
			sub_selection	= if( classOf facelist_array == Array )then facelist_array[o] else facelist_array
			mod.SetSelection	sub_obj #{}	node: _selection[o]
			mod.Select	sub_obj sub_selection	node: _selection[o]
		)
	),
	/** Get ausing b
	 */
	function getAusingB aType bType subobjects =
	(
		this.init()
		
		returnBitArray = #{}
		
		case of
		(
			( aType == #Vertex	and bType == #Edge	): mod.getVertsUsingEdge &returnBitArray subobjects
			( aType == #Vertex	and bType == #Face	): mod.getVertsUsingEdge &returnBitArray subobjects
			( aType == #Edge	and bType == #Vertex	): mod.getEdgesUsingVert &returnBitArray subobjects
			( aType == #Edge	and bType == #Face	): this.getEdgesUsingFace returnBitArray subobjects
			( aType == #Face	and bType == #Vertex	): mod.getFacesUsingVert &returnBitArray subobjects
			( aType == #Face	and bType == #Edge	): mod.getFacesUsingEdge &returnBitArray subobjects
		)
		returnBitArray --return

	),
	/** Get edges using face
	 */
	function getEdgesUsingFace returnBitArray subobjects =
	(
		iFaceDeg = 0
		
		for iFace in (subobjects as array) do
		(
			iFaceDeg = mod.getFaceDegree iFace
			--print ("faceIndex: " + iface as string + " degree: " + iFaceDeg as string)
			for i = 1 to iFaceDeg do 
				returnBitArray[mod.getFaceEdge iFace i] = true
		)
		returnBitArray
	),
	/*---------------------------------------
		PRIVATE 
	-----------------------------------------*/
	/** _all faces
	 */
	function _allFaces =
	(
		all_faces	= #()
		face_counts	= this.faceCount()

		for face_count in face_counts do
			append all_faces ( #{1..( face_count )} )
		--print ( "all_faces = " + all_faces as string )
		all_faces --return
	),

	/** Set object
	 */
	function _setObjects =
	(
		_selection = (Selection_v()).get()
	),
	/** Set current modifier
	 */
	function _setMod =
	(
		if( mod == undefined ) then
		(
			print ( "----------------------------------\n\tEditPoly_v._setMod()\n----------------------------------" )
			mod = modPanel.getCurrentObject()
		)
		
	),
	function test =
	(
		messagebox "EditPoly_v.test()"
	)
)
