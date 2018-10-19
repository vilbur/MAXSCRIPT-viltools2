filein ( (getThisScriptFilename()) + "/../../lib/Selection.ms");


try(DestroyDialog SelectionRollTest)catch() -- must be above rollout definition

/** Edit poly test
 */
rollout SelectionRollTest "Edit poly test"
(
	local Selection	= (Selection_v())
	local Instance	= Selection.Instance

	groupbox Selection_gb "Selection" 	
	
	button SelectionTest_btn "Selection.geometry()" 
		on SelectionTest_btn pressed do ( Selection.get() )
		
	button InstanceTest_btn "Instance Test" 
		on InstanceTest_btn pressed do ( Instance.test() )
		
		
)

CreateDialog SelectionRollTest width:128 pos:[( (getMAXWindowPos()).x + 512 ), ( (getMAXWindowPos()).y + 256 ) ]