macroscript enter_subobject_toggle
category:	"_Subobject" 
buttonText:	"Enter\Exit"
tooltip:	"Enter\Exit subobject"
(
	(Subobject_v()).enter 0
)

macroscript enter_subobject_1
category:	"_Subobject" 
buttonText:	"Enter 1"
tooltip:	"Enter to subobject 1"
(
	(Subobject_v()).enter 1
)

macroscript enter_subobject_2
category:	"_Subobject" 
buttonText:	"Enter 2"
tooltip:	"Enter to subobject 2"
(
	(Subobject_v()).enter 2
)

macroscript enter_subobject_3
category:	"_Subobject" 
buttonText:	"Enter 3"
tooltip:	"Enter to subobject 3"
(
	(Subobject_v()).enter 3
)


macroscript enter_subobject_4
category:	"_Subobject" 
buttonText:	"Enter 4"
tooltip:	"Enter to subobject 4"
(
	(Subobject_v()).enter 4
)

macroscript enter_subobject_4
category:	"_Subobject" 
buttonText:	"Enter 4"
tooltip:	"Enter to subobject 4"
(
	(Subobject_v()).enter 4
)

macroscript enter_subobject_5
category:	"_Subobject" 
buttonText:	"Enter 5"
tooltip:	"Enter to subobject 5"
(
	(Subobject_v()).enter 5
)

macroscript	enter_subobject_circle
category:	"_Subobject" 
buttonText:	"Enter circle"
tooltip:	"Circle subobjects  1, 2, 4"
(
	Subobject	= Subobject_v()
	
	Subobject.circle #( 1, 2, 4)
)