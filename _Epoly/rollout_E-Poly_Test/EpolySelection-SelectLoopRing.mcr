

/*------------------------------------------------------------------------------
	LOOP
--------------------------------------------------------------------------------*/
macroscript	epolyselection_move_loop_up
category:	"_Epoly-EpolySelection"
buttontext:	"Loop move"
toolTip:	"Move loop forward"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).selectLoopRing #loop #forward #move
)
macroscript	epolyselection_move_loop_down
category:	"_Epoly-EpolySelection"
buttontext:	"Loop move"
toolTip:	"Move loop reverse"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).selectLoopRing #loop #reverse #move
)

macroscript	epolyselection_select_loop_up
category:	"_Epoly-EpolySelection"
buttontext:	"Loop forward"
toolTip:	"Select loop forward"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).selectLoopRing #loop #forward #select
)

macroscript	epolyselection_deselect_loop_up
category:	"_Epoly-EpolySelection"
buttontext:	"Loop forward"
toolTip:	"Deselect loop forward"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).selectLoopRing #loop #forward #deselect
)


macroscript	epolyselection_select_loop_down
category:	"_Epoly-EpolySelection"
buttontext:	"Loop reverse"
toolTip:	"Select loop reverse"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).selectLoopRing #loop #reverse #select
)

macroscript	epolyselection_deselect_loop_down
category:	"_Epoly-EpolySelection"
buttontext:	"Loop reverse"
toolTip:	"Deselect loop reverse"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).selectLoopRing #loop #reverse #deselect
)


/*------------------------------------------------------------------------------
	RING
--------------------------------------------------------------------------------*/
macroscript	epolyselection_move_ring_up
category:	"_Epoly-EpolySelection"
buttontext:	"Ring move"
toolTip:	"Move ring forward"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).selectLoopRing #ring #forward #move
)
macroscript	epolyselection_move_ring_down
category:	"_Epoly-EpolySelection"
buttontext:	"Ring move"
toolTip:	"Move ring reverse"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).selectLoopRing #ring #reverse #move
)

macroscript	epolyselection_select_ring_up
category:	"_Epoly-EpolySelection"
buttontext:	"Ring forward"
toolTip:	"Select ring forward"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).selectLoopRing #ring #forward #select
)

macroscript	epolyselection_deselect_ring_up
category:	"_Epoly-EpolySelection"
buttontext:	"Ring forward"
toolTip:	"Deselect ring forward"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).selectLoopRing #ring #forward #deselect
)

macroscript	epolyselection_select_ring_down
category:	"_Epoly-EpolySelection"
buttontext:	"Ring reverse"
toolTip:	"Select ring reverse"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).selectLoopRing #ring #reverse #select
)

macroscript	epolyselection_deselect_ring_down
category:	"_Epoly-EpolySelection"
buttontext:	"Ring reverse"
toolTip:	"Deselect ring reverse"
--icon:	"#(path, index)"
(
	(EpolySelection_v()).selectLoopRing #ring #reverse #deselect
)

