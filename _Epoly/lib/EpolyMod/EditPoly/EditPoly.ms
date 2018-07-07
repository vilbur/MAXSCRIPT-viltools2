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

		true --return
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
		(EpolySelection_v()).setSel #Face facelist
		mod.SetOperation #SetMaterial
		mod.materialIDToSet = id
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
		print ( "all_faces = " + all_faces as string )
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
		mod = modPanel.getCurrentObject()
	),
	function test =
	(
		messagebox "EditPoly_v.test()"
	)
)
