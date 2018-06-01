macroScript Detach_v
	category:"_EditPoly"
	buttontext:"Detach"
(
		--scriptFile = ((GetDir #userScripts ) + "\\Detach_v.ms")
		--filein scriptFile
		--include @"c:\Users\vilbur\AppData\Local\Autodesk\3dsMax\2013 - 64bit\ENU\scripts\\Detach_v.ms"
		include "$userScripts\\_EditPoly\\Detach_v.ms"	
	(Detach_v true true)
)

macroScript Detach_v_copy
	category:"_EditPoly"
	buttontext:"Detach copy"
(
		include "$userScripts\\_EditPoly\\Detach_v.ms"
		(Detach_v false true)
)

macroScript Detach_v_Element
	category:"_EditPoly"
	buttontext:"Detach to Element"
(
		include "$userScripts\\_EditPoly\\Detach_v.ms"

		(Detach_v true false )
)

macroScript Detach_v_Element_Copy
	category:"_EditPoly"
	buttontext:"Detach to Element Copy"
(
		include "$userScripts\\_EditPoly\\Detach_v.ms"

		(Detach_v false false )
)

/*
Detach_v true true 	-- editable poly -- detach
Detach_v false true	-- editable poly -- detach copy
Detach_v true false 	-- editable poly -- detach to element
Detach_v false false   -- editable poly -- detach to element copy


*/