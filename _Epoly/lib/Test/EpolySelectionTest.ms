
filein ( getFilenamePath(getSourceFileName()) + "/../../../includes.ms" )


/** Get epoly test
 */
function getCurrentEpolyTest =
(
	epoly_type =(EpolySelection_v()).getCurrentEpoly()
	
	--print ( "epoly_type = " + epoly_type as string )
	print ( "getCurrentEpolyTest() epoly_type="+epoly_type as string+"	TEST = " + (epoly_type != undefined ) as string )	
)
/** Get epoly test
 */
function findEpolyTest =
(
	epoly =(EpolySelection_v()).findEpoly()

)

/*---------------------------------------
	RUN TESTS
-----------------------------------------*/

clearListener()

--getCurrentEpolyTest()
findEpolyTest()