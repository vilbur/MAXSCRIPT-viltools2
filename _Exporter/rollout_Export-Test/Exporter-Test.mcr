macroscript	exporter_test_find_export_node_test
category:	"_Exporter"
buttontext:	"Find export node"
toolTip:	"Find export node"
--icon:	"#(path, index)"
(
	(Exporter_v()).findExportNode()
)

macroscript	exporter_test_choose_export_node_dialog_test
category:	"_Exporter"
buttontext:	"Choose Node"
toolTip:	"Choose NodeDialog"
--icon:	"#(path, index)"
(
	(Exporter_v()).chooseNodeDialog()
)


macroscript	exporter_export_test
category:	"_Exporter"
buttontext:	"Export"
toolTip:	"Export selected node"
--icon:	"#(path, index)"
(
	(Exporter_v()).FBX_Export()
)
