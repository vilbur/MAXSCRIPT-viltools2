macroScript Enter_Subobject_vertex
	category:"_EditPoly"
	buttontext:"Enter Subobject 1"	
(
	
	include @"$userscripts\\_MainUI\\Instance_Test_v.ms"	
	include @"$userscripts\\_EditPoly\\Enter_Subobject_v.ms"
	
	Enter_Subobject_v 1
)
macroScript Enter_Subobject_edge
	category:"_EditPoly"
	buttontext:"Enter Subobject 2"
(
	include @"$userscripts\\_MainUI\\Instance_Test_v.ms"	
	include @"$userscripts\\_EditPoly\\Enter_Subobject_v.ms"	
	Enter_Subobject_v 2
)
macroScript Enter_Subobject_border
	category:"_EditPoly"
	buttontext:"Enter Subobject 3"	
(
	include @"$userscripts\\_MainUI\\Instance_Test_v.ms"	
	include @"$userscripts\\_EditPoly\\Enter_Subobject_v.ms"
	
	Enter_Subobject_v 3
)
macroScript Enter_Subobject_face
	category:"_EditPoly"
	buttontext:"Enter Subobject 4"	
(
	include @"$userscripts\\_MainUI\\Instance_Test_v.ms"	
	include @"$userscripts\\_EditPoly\\Enter_Subobject_v.ms"
	
	Enter_Subobject_v 4
)
macroScript Enter_Subobject_element
	category:"_EditPoly"
	buttontext:"Enter Subobject 5"
(
	include @"$userscripts\\_MainUI\\Instance_Test_v.ms"	
	include @"$userscripts\\_EditPoly\\Enter_Subobject_v.ms"
	
	Enter_Subobject_v 5
)
