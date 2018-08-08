macroscript	objectcleaner_test
category:	"_Exporter"
buttontext:	"Prepare"
toolTip:	"Prepare opbjects in layer 'Export'\n\n 1) Fix Mirrored Object Normals\n 2) Reset Xform\n 3) Reset Smooth\n 4) Reset Pivot\n 5) Convert To EditablePoly\n 6) Rename Objects\n 7) Set One Side Faces"
--icon:	"#(path, index)"
(
	ObjectCleaner 	= (ObjectCleaner_v())
	
	ObjectCleaner.prepareObjectsForExport()
)