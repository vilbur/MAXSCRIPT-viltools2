/** Filein *.mcr files
  * Only files which path is matching items in _inlcudes array
  *
  *
  */
struct MacroAutoLoader_v
(
	_path	= getFilenamePath(getSourceFileName()) + "..",
	_all_files	= #(),
	_import_files	= #(),
	_inlcudes      = #(
		@"macro\\"
	),
	/** Import scripts 
	 *	
	 */
	function importScripts =
	(
		this._setAllFiles()
		this._filterIncludes()

		for file in _import_files do
			filein file
	),
	/** Set files
	 */
	function _setAllFiles =
	(
		_all_files	= this._getFilesRecursive _path "*.mcr"
	),
	/**  Get files in folder and subfolders
	 */
	function _getFilesRecursive root pattern =
	(
		--print ( "root = " + root as string )
		dirs	= getDirectories (root + "/*")
		files	= getFiles (root + pattern )
		
		for dir in dirs do
		  join dirs (getDirectories (dir + "/*"))
		
		for file in dirs do
		  join files (getFiles ( file + pattern ))
		
		files --return
	),
	/** Filter includes
	 */
	function _filterIncludes =
	(
		includes_rx	     = "(" + (this._joinArray _inlcudes  "|") + ")"
		
		for file in _all_files where  ( dotNetObject "System.Text.RegularExpressions.Regex" "").IsMatch file includes_rx do
			append _import_files file
	),
	/**  
	 */
	function _joinArray array delimeter =
	(
		_string = ""
		for item in array do
			_string += item + delimeter
			
		substring _string 1 (_string.count-delimeter.count)
	),
	
	function test =
	(
		messagebox "MacroAutoLoader.test()"
	)
)