
filein ( getFilenamePath(getSourceFileName()) + "/../../../../includes.ms" )
clearListener()

--(EpolySelection_v()).getSelection #face
(EpolySelection_v()).setSelection #face #{1..4}

redrawViews()
