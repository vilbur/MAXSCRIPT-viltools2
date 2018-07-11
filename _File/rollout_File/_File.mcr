macroscript	_file_save_objects_to_files
category:	"_File"
buttontext:	"Objects to files"
toolTip:	"Save objects to files"
--icon:	"#(path, index)"
(
	dir="c:\\temp\\"	-- the target directory
	typ=".max"	-- change this to the filetype you want
	
	for s in selection do
	(
		select s
		f=dir+s.name+typ
		MaxFileDir
		print f
		if typ==".max" then
		(
			saveNodes selection f quiet:true
		)
		else
		(
			exportfile f selectedOnly:true --#noprompt
		)
	)
)
