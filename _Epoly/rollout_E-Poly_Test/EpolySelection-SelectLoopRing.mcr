/*------------------------------------------------------------------------------
	LOOP
--------------------------------------------------------------------------------*/

macroscript	epolyselection_select_loop_up
category:	"_Epoly-EpolySelection"
buttontext:	"Loop forward"
toolTip:	"Select loop forward"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).selectLoopRing #loop #forward #select
)
--
--macroscript	epolyselection_deselect_loop_up
--category:	"_Epoly-EpolySelection"
--buttontext:	"Loop forward"
--toolTip:	"Deselect loop forward"
----icon:	"#(path, index)"
--(
--	--(EpolySelection_v()).select_loop -1 false 
--)


macroscript	epolyselection_select_loop_down
category:	"_Epoly-EpolySelection"
buttontext:	"Loop reverse"
toolTip:	"Select loop reverse"
--icon:	"#(path, index)"
(
	--(EpolySelection_v()).select_loop -1 true
	(EpolySelection_v()).selectLoopRing #loop #reverse #select

)

--macroscript	epolyselection_deselect_loop_down
--category:	"_Epoly-EpolySelection"
--buttontext:	"Loop reverse"
--toolTip:	"Deselect loop reverse"
----icon:	"#(path, index)"
--(
--	(EpolySelection_v()).select_loop 1 false   
--)
--
--
--/*------------------------------------------------------------------------------
--	RING
----------------------------------------------------------------------------------*/

macroscript	epolyselection_select_ring_up
category:	"_Epoly-EpolySelection"
buttontext:	"Ring forward"
toolTip:	"Select ring forward"
--icon:	"#(path, index)"
(
	--$.setRingShift 9 false true
	--(EpolySelection_v()).select_ring 1 true
	(EpolySelection_v()).selectLoopRing #ring #forward #select

)

--macroscript	epolyselection_deselect_ring_up
--category:	"_Epoly-EpolySelection"
--buttontext:	"Ring forward"
--toolTip:	"Deselect ring forward"
----icon:	"#(path, index)"
--(
--	--$.setRingShift 9 false true
--	(EpolySelection_v()).select_ring -1 false
--)

macroscript	epolyselection_select_ring_down
category:	"_Epoly-EpolySelection"
buttontext:	"Ring reverse"
toolTip:	"Select ring reverse"
--icon:	"#(path, index)"
(
	--$.setRingShift 9 false true
	--(EpolySelection_v()).select_ring -1 true
	(EpolySelection_v()).selectLoopRing #ring #reverse #select

)

--macroscript	epolyselection_deselect_ring_down
--category:	"_Epoly-EpolySelection"
--buttontext:	"Ring reverse"
--toolTip:	"Deselect ring reverse"
----icon:	"#(path, index)"
--(
--	--$.setRingShift 9 false true
--	(EpolySelection_v()).select_ring 1 false
--)
--
