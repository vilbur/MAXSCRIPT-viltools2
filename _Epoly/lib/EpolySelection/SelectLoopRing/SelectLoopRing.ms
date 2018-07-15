/** Select loop ring
 */
struct SelectLoopRing_v
(
	
	/**  
	 *	
	 */
	function getAUsingB modOrObj bInVar aType:#currentLevel bType:#currentLevel =
	(
		print ("this.getAUsingB" + " bInVar: " + bInVar as string + " aType: " + aType as string + " bType: " + bType as string)
		local bBitArray = #{}
		local returnBitArray = #{}
		--class conversion
		case classOf bInVar of
		(
			Integer:	bBitArray = #{bInVar}
			BitArray:	bBitArray = bInVar
			Array:	bBitArray = bInVar as BitArray
			default:	(print "invalid inVar class"; return())
		)
		--currentLvl conversion
		if aType == #currentLevel do (aType = modOrObj.GetMeshSelLevel())
		if bType == #currentLevel do (bType = modOrObj.GetMeshSelLevel())
		--if both a and b are of the same type return b
		if aType == bType do (return bBitArray)
		print ("Get "+ aType as string + " From " + bType as string)
		print (bType as string + " bitarray: " + bBitArray as string)
		case aType of
		(
			#vertex: case bType of
			(
				#Edge: case classof modOrObj of
						(
							Editable_Poly:(returnBitArray = polyOp.getVertsUsingEdge modOrObj bBitArray)
							Edit_Poly:(modOrObj.getVertsUsingEdge &returnBitArray bBitArray)
						)
				#Face: case classof modOrObj of
						(
							Editable_Poly:(returnBitArray = polyOp.getVertsUsingFace modOrObj bBitArray)
							Edit_Poly:(modOrObj.getVertsUsingFace &returnBitArray bBitArray)
						)
				default:(print "invalid bType")
			)
			#Edge: case bType of
			(
				#Vertex: case classof modOrObj of
						(
							Editable_Poly:(returnBitArray = polyOp.getEdgesUsingVert modOrObj bBitArray)
							Edit_Poly:(modOrObj.getEdgesUsingVert &returnBitArray bBitArray)
						)
				#Face: case classof modOrObj of
						(
							Editable_Poly:(returnBitArray = polyOp.getEdgesUsingFace modOrObj bBitArray)
							Edit_Poly:
							(--thanks to: IllusionCatalyst
								local iFaceDeg = 0
								for iFace in (bBitArray as array) do
								(
									iFaceDeg = modOrObj.getFaceDegree iFace
									--print ("faceIndex: " + iface as string + " degree: " + iFaceDeg as string)
									for i = 1 to iFaceDeg do 
									(
										--print("degree: " + i as string)
										returnBitArray[modOrObj.getFaceEdge iFace i] = true
									)
								)
							)
						)
				default:(print "invalid bType")
			)
			#Face: case bType of
			(
				#Vertex: case classof modOrObj of
						(
							Editable_Poly:(returnBitArray = polyOp.getFacesUsingVert modOrObj bBitArray)
							Edit_Poly:(modOrObj.getFacesUsingVert &returnBitArray bBitArray)
						)
				#Edge: case classof modOrObj of
						(
							Editable_Poly:(returnBitArray = polyOp.getFacesUsingEdge modOrObj bBitArray)
							Edit_Poly:(modOrObj.getFacesUsingEdge &returnBitArray bBitArray)
						)
				default:(print "invalid bType")
			)
			default:(print "invalid aType")
		)
		print ("returnArray:"+ returnBitArray as string)
		--Final return
		return returnBitArray
	),
	/**  
	 *	
	 */
	function GetNextRingLoop oEdge_selection modOrObj:(Filters.GetModOrObj()) =
	(
		--make sure we have the correct variable type for edge
		
		case classof oEdge_selection of
		(
			--BitArray:	if oEdge.numberset > 1 then oEdge = #{(oEdge as array)[1]}
			BitArray:	oEdge = #{ ( oEdge_selection as Array )[(oEdge_selection as Array ).count]  }
			Integer:	oEdge	= #{oEdge_selection}
			Array:	oEdge	= #{oEdge_selection[1]}
			default:	(print "unhandled oEdge variable"; return #{})
		)
		
		forwardLoopEdges	= #{}
		reverseLoopEdges	= #{}
		forwardRingEdges	= #{} 
		reverseRingEdges	= #{}
		ringFilterEdges	= #{}
		loopFilterEdges	= #{}
		
		edgeVerts = this.getAUsingB modOrObj oEdge aType:#Vertex bType:#Edge --edgeVerts should always be 2
	
		if edgeVerts.numberSet == 2 then
		(	
			reverseLoopVert = (edgeVerts as array)[1]
			forwardLoopVert = (edgeVerts as array)[2]
			print ("edgeVerts:	" + edgeVerts as string)
			
			reverseLoopEdges = this.getAUsingB modOrObj reverseLoopVert aType:#Edge bType:#Vertex
			forwardLoopEdges = this.getAUsingB modOrObj forwardLoopVert aType:#Edge bType:#Vertex
			
			ringFilterEdges = (forwardLoopEdges + reverseLoopEdges) --union and store these for later
		) else
			return #{} --should be an impossible abortcondition unless passed something other than an Edge
		
		edgeFaces = this.getAUsingB modOrObj oEdge aType:#Face bType:#Edge --edgeFaces can be either 2 or 1(for border oEdge)
	
		if (numFaces = edgeFaces.numBerset) > 0 then
		(
			reverseRingEdges = this.getAUsingB modOrObj (edgeFaces as array)[1] aType:#Edge bType:#Face
			
			if numFaces == 2 then
				forwardRingEdges = this.getAUsingB modOrObj (edgeFaces as array)[2] aType:#Edge bType:#Face
			
			else
				print "is border Edge"
			
			loopFilterEdges = (forwardRingEdges + reverseRingEdges)  --union and store these for later
		) else
			return #{}--should also be an impossible abortcondition unless passed something other than an oEdge
		
		--do subtraction ops to get rid of most of the junk
		forwardLoopEdges -= loopFilterEdges
		reverseLoopEdges -= loopFilterEdges
		forwardRingEdges -= ringFilterEdges
		reverseRingEdges -= ringFilterEdges
		
		print ("candidate forward loop edges: " + forwardLoopEdges as string)
		print ("candidate reverse loop edges: " + reverseLoopEdges as string)
		print ("candidate forward ring edges: " + forwardRingEdges as string)
		print ("candidate reverse ring edges: " + reverseRingEdges as string)
		
		print "selecting the new edges just for testing"
		--modOrObj.SetSelection #Edge (forwardLoopEdges + reverseLoopEdges + forwardRingEdges + reverseRingEdges)
		--***From here on the code is incomplete***
		--print ( "oEdge = " + oEdge as string )
		print "-------------------"
		print ( "oEdge = " + oEdge as string )
		print ( "forwardLoopEdges = " + forwardLoopEdges as string )
		print ( "Edge + forwardLoopEdges = " + (oEdge + forwardLoopEdges) as string )
		
		--modOrObj.SetSelection #Edge ( forwardLoopEdges )
		--modOrObj.SetSelection #Edge ( oEdge )
		modOrObj.SetSelection #Edge ( oEdge_selection + forwardLoopEdges )
	),
	/**  
	 *	
	 */
	function testGNRL =
	(
		if ( GetCommandPanelTaskMode() != #modify) then
			SetCommandPanelTaskMode #modify
		
		
		modOrObj = Filters.GetModOrObj()
		
		subObjectLevel	= 2
		
		edgeBitArray = modOrObj.GetSelection #Edge
		
		if edgeBitArray.numberset > 0 then
		(
			print ("selected edges: " +  (edgeBitArray) as string )
			print ("selected edges FIRST: " + (edgeBitArray as Array)[1] as string )
			print ("selected edges LAST: " + (edgeBitArray as Array)[(edgeBitArray as Array).count] as string )
			GetNextRingLoop edgeBitArray modOrObj:modOrObj
		)
		else
		(
			print "nothing selected"
		)
	),

	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	function test =
	(
		messagebox "SelectLoopRing.test()"
	)
)
