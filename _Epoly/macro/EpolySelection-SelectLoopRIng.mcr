/*------------------------------------------------------------------------------
	LOOP
--------------------------------------------------------------------------------*/

macroscript	epolyselection_select_loop_up
category:	"_Epoly-EpolySelection"
buttontext:	"Select loop up"
toolTip:	"Select loop up"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).select_loop 1 true
)

macroscript	epolyselection_deselect_loop_up
category:	"_Epoly-EpolySelection"
buttontext:	"Select loop up"
toolTip:	"Deselect loop up"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).select_loop -1 false 
)


macroscript	epolyselection_select_loop_down
category:	"_Epoly-EpolySelection"
buttontext:	"Select loop down"
toolTip:	"Select loop down"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).select_loop -1 true
)

macroscript	epolyselection_deselect_loop_down
category:	"_Epoly-EpolySelection"
buttontext:	"Select loop down"
toolTip:	"Deselect loop down"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).select_loop 1 false   
)


/*------------------------------------------------------------------------------
	RING
--------------------------------------------------------------------------------*/

macroscript	epolyselection_select_ring_up
category:	"_Epoly-EpolySelection"
buttontext:	"Select ring up"
toolTip:	"Select ring up"
--icon:	"#(path, index)"
(
	--$.setRingShift 9 false true
	(EpolySelection_v()).select_ring 1 true
)

macroscript	epolyselection_deselect_ring_up
category:	"_Epoly-EpolySelection"
buttontext:	"Select ring up"
toolTip:	"Deselect ring up"
--icon:	"#(path, index)"
(
	--$.setRingShift 9 false true
	(EpolySelection_v()).select_ring -1 false
)

macroscript	epolyselection_select_ring_down
category:	"_Epoly-EpolySelection"
buttontext:	"Select ring down"
toolTip:	"Select ring down"
--icon:	"#(path, index)"
(
	--$.setRingShift 9 false true
	(EpolySelection_v()).select_ring -1 true
)

macroscript	epolyselection_deselect_ring_down
category:	"_Epoly-EpolySelection"
buttontext:	"Select ring down"
toolTip:	"Deselect ring down"
--icon:	"#(path, index)"
(
	--$.setRingShift 9 false true
	(EpolySelection_v()).select_ring 1 false
)

