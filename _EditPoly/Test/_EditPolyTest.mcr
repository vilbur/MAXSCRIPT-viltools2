filein ( (getThisScriptFilename()) + "/../../lib/EditPoly.ms");
try(DestroyDialog EditPolyTest_roll)catch() -- must be above rollout definition

/** Edit poly test
 */
rollout EditPolyTest_roll "Edit poly test"
(
		
	button Test_btn "Test" 
		on Test_btn pressed do ( (EditPoly_v_old()).test() )
)

CreateDialog EditPolyTest_roll width:128 pos:[( (getMAXWindowPos()).x + 512 ), ( (getMAXWindowPos()).y + 512 ) ]