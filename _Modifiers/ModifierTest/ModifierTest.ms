filein ( getFilenamePath(getSourceFileName()) + "/../../includes.ms" )
clearListener()



/** Get objects in selection sharing instance of modifier
 */
function getInstancesInSelectionTest =
(
	current_modifier	= modPanel.getCurrentObject()
	instaneces_in_selection	= (Modifier_v()).getInstances selection	current_modifier
	
	print ( "instaneces_in_selection = " + instaneces_in_selection as string )
)

/** Get objects in all objects sharing instance of modifier
 */
function getInstancesInObjectsTest =
(
	current_modifier	= modPanel.getCurrentObject()
	instaneces_in_objects	= (Modifier_v()).getInstances objects	current_modifier
	
	print ( "instaneces_in_objects = " + instaneces_in_objects as string )
)

/*---------------------------------------
	RUN TESTS
-----------------------------------------*/

getInstancesInSelectionTest()
getInstancesInObjectsTest()