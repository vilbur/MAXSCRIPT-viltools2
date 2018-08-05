plugin helper vil_unity_exporter
name:"Export"
category:"Unity"
(
	local _node
	local export_filename_placeholder = if( maxFileName != "" ) then ( ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_-]\d+$" ).Replace (getFilenameFile maxFileName) "" ) else ""  
	local export_path_placeholder     = @"c:\Samdosoft\Test Prototype Internal Assets\Assets\FBX - MODEL\_vilbur\ExportTest"

	tool create
	(
		on mousePoint click do
		(
			--clickAt = worldPoint
			--boxes =for i in 1 to 10 collect box pos:([i*20,0,0] + clickAt)
			_node = text text:export_filename_placeholder

			#stop
		)
	)
	
	rollout params "Parameters"
	(
	 
		edittext export_filename "Name" text:export_filename_placeholder
		
		button btn_browse "Path" toolTip:"Test"

		edittext export_path "" text:export_path_placeholder 
		
		on btn_browse pressed do (
			local dir = getSavePath caption:"Browse export dir"
			if (dir != undefined) do
			(
				export_path.text	= dir
				btn_browse.tooltip	= dir
			)
		)
		on export_filename changed val do (
				_node.text	= val
			
		)
		--spinner frab_value "Frabulate" range:[-1000,1000,20]
		--on frab_value changed val do
		--for i in 1 to boxes.count do
		--boxes[i].pos = [i*val,0,0] + clickAt
	)
	
	
)