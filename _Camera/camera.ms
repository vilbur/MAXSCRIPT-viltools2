global camera_match_last_viewport -- fire up baground change only if viewport camera is changed
global camera_match_backgrounds = #( #(), #() )
	
/** Set viewport background
 */
function setViewportBackground bmpImg =
(
	if( backgroundimagefilename == bmpImg.fileName ) then
		return ()
	
	format "setViewportBackground	= % \n" bmpImg.fileName
	
	setAsBackground bmpImg.bitmap
	viewport.DispBkgImage = true
	setBkgImageAspect  #bitmap -- Match Bitmap 
)

/** Get match camera background
 */
function setCameraMatchBackground camera_name =
(
	print "------------\ncamera.setCameraMatchBackground()"
	format "camera_match_backgrounds	= % \n" camera_match_backgrounds
	
	background_index = findItem camera_match_backgrounds[1] camera_name
	  
	if ( background_index == 0 ) then
	(
		file_path	=  ( maxFilePath + "\\camera_background\\" + (camera_name) + ".jpg" )
		
		if not( doesFileExist ( file_path ) ) then
			return ()
		
		bmpImg	= bitMapTexture()
		bmpImg.fileName	= file_path
		
		append camera_match_backgrounds[1] camera_name
		append camera_match_backgrounds[2] bmpImg
		
		--print ( "bmpImg.fileName = " + bmpImg.fileName as string )
	)
	else
		bmpImg = camera_match_backgrounds[2][background_index]
	
	setViewportBackground bmpImg
	
	renderWidth	= bmpImg.bitmap.width
	renderHeight	= bmpImg.bitmap.height
	
	completeRedraw()
)


/** Remove camera background
 */
function removeCameraBackground =
(
	print "------------\ncamera.removeCameraBackground()"
	backgroundimagefilename = ""
	displaySafeFrames = false
)

/** On camera match change
 */
function onCameraMatchChange =
(
	curcam = try(getActiveCamera()) catch()
	--format " camera_match_last_viewport	= % \n" camera_match_last_viewport
	if ( viewport.getType() != #view_camera and backgroundimagefilename != "" ) then 
		removeCameraBackground()
	
	if( curcam == undefined or curcam.name == camera_match_last_viewport ) then
		return()
	
	format " curcam.name	= % \n" curcam.name
	camera_match_last_viewport = curcam.name
	
	setCameraMatchBackground curcam.name
)