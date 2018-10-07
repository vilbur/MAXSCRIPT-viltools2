
/** Set viewport background
 */
function setViewportBackground bmpImg =
(
	if( backgroundimagefilename == bmpImg.fileName ) then
		return ()

	setAsBackground bmpImg.bitmap
	viewport.DispBkgImage = true
	setBkgImageAspect  #bitmap -- Match Bitmap 
)

/** Get match camera background
 */
function getMatchCameraBackground camera_name =
(
	background_index = findItem camera_backgrounds[1] camera_name

	if ( background_index == 0 ) then
	(
		file_path	=  ( maxFilePath + "\\camera_background\\" + (camera_name) + ".jpg" )

		if not( doesFileExist ( file_path ) ) then
			return ()

		bmpImg	= bitMapTexture()
		bmpImg.fileName	= file_path

		append camera_backgrounds[1] camera_name
		append camera_backgrounds[2] bmpImg

		print ( "bmpImg.fileName = " + bmpImg.fileName as string )
		--setViewportBackground bmpImg
		--completeRedraw()
	)
	else
		bmpImg = camera_backgrounds[2][background_index]

		setViewportBackground bmpImg
		
		renderWidth	= bmpImg.bitmap.width
		renderHeight	= bmpImg.bitmap.height
	
		completeRedraw()
)

/** On camera match change
 */
function onCameraMatchChange =
(
	curcam = try(getActiveCamera()) catch()

	if( curcam == undefined ) then
		return()

	getMatchCameraBackground curcam.name
)
s
macroscript	camera_autoset_background
category:	"_Camera"
buttontext:	"Auto Bg"
--toolTip:	"Set background to camera view\nmaxFilePath + \"\\camera_background\\\" + (camera_name) + \".jpg\""
--icon:	"#(path, index)"
(
	--if( camera_backgrounds == undefined ) then
	camera_backgrounds	= #( #(), #() )

	try( callbacks.removeScripts #viewportChange	id:#camera_match_change )catch()
	try( callbacks.addScript     #viewportChange "onCameraMatchChange()" id:#camera_match_change )catch()

)

