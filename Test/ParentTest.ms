filein ( getFilenamePath(getSourceFileName()) + "/ClassA.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/ClassB.ms" )


/** Parent test
 */
struct ParentTest_v
(
	testA = (ClassA_v()).testA,
	testB = (ClassB_v()).testB,
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	function test =
	(
		messagebox "ParentTest.test()"
	)
)
