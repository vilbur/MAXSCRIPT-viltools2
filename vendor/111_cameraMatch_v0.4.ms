--- maxscript cameraMatch
--- author: andrei kletskov (111) - http://andklv.narod.ru
--- description: script tries to solve camera position and FOV based on perspective lines of an image. 
--- acknowledgment goes to sanctus (http://somesanctus.blogspot.com/) for the main idea in the solution.
--- v0.1 - 23 sept 2011 - initial test version
--- v0.2 - 23 sept 2011 - some stupid bugs fixed
--- v0.3 - 3 march 2012 - polishing
--- v0.4 - 19 may 2012 - bug with negative vertical vanishing point fixed

pl=undefined
p=undefined
img=undefined
deletehelpers = false

fn part1 imgfilepath =
(
--imgfilepath = "c:/temp/a2.jpg"

------------- setting image plane -------------------
cmt = Standardmaterial () 
cmt.name = "111_cm_ppmat"
--cmt.selfIllumAmount = 100
cmt.diffuseMap = Bitmaptexture fileName:imgfilepath
cmt.diffuseMap.coords.realWorldScale = off
cmt.showInViewport = true
img = cmt.diffuseMap.bitmap
pp = Plane length:img.height width:img.width transform:(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0]) isSelected:off name:"111_cm_projectionPlane"
pp.realWorldMapSize = off
pp.mat = cmt
------------- END setting image plane -------------------

----------------- adding spline helper for perspective -----------------
pl = splineShape ()

---- vp1 1,2
addNewSpline pl
addKnot pl 1 #corner #curve  [-100,0,-100]
addKnot pl 1 #corner #curve  [-50,0,100]
addNewSpline pl
addKnot pl 2 #corner #curve  [100,0,-100]
addKnot pl 2 #corner #curve  [50,0,100]

---- vp2 3,4
addNewSpline pl
addKnot pl 3 #corner #curve  [200,0,100]
addKnot pl 3 #corner #curve  [400,0,50]
addNewSpline pl
addKnot pl 4 #corner #curve  [200,0,-100]
addKnot pl 4 #corner #curve  [400,0,-50]

---- vp3 5,6
addNewSpline pl
addKnot pl 5 #corner #curve  [-200,0,100]
addKnot pl 5 #corner #curve  [-400,0,50]
addNewSpline pl
addKnot pl 6 #corner #curve  [-200,0,-100]
addKnot pl 6 #corner #curve  [-400,0,-50]

updateshape pl
select pl
macros.run "Modifier Stack" "SubObject_1"
----------------- END adding spline helper for perspective -----------------
)

fn part2 =
(	
---------- calculating vanishing points -----------------
fn getABC dota dotb = ------------- line equation with two points
(
	--dota = getKnotPoint pl 1 1
	--dotb = getKnotPoint pl 1 2
	x1 = dota.x
	y1 = dota.z
	x2 = dotb.x
	y2 = dotb.z
	a = y1 - y2
	b = x2 - x1
	c = x1*y2 - x2*y1
	return [a,b,c]
)

fn crosspoint abc1 abc2 = ------------ crossing two lines with line equations
(
	a1 = abc1[1]
	b1 = abc1[2]
	c1 = abc1[3]

	a2 = abc2[1]
	b2 = abc2[2]
	c2 = abc2[3]

	y = (c2*a1 - c1*a2)/(b1*a2 - b2*a1)
	x = (c2*b1 - c1*b2)/(a1*b2 - a2*b1)
	
	return [x,0,y]
)


vp1 = crosspoint (getABC (getKnotPoint pl 1 1) (getKnotPoint pl 1 2)) (getABC (getKnotPoint pl 2 1) (getKnotPoint pl 2 2))
vp2 = crosspoint (getABC (getKnotPoint pl 3 1) (getKnotPoint pl 3 2)) (getABC (getKnotPoint pl 4 1) (getKnotPoint pl 4 2))
vp3 = crosspoint (getABC (getKnotPoint pl 5 1) (getKnotPoint pl 5 2)) (getABC (getKnotPoint pl 6 1) (getKnotPoint pl 6 2))
--sphere pos:vp1
--box pos:vp2
--cylinder pos:vp3

----------END calculating vanishing points -----------------	
	
------------- creating camera -----------------
cam = Freecamera name:"111_cm_camera"  transform:(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0])
------------- END creating camera -----------------
	
	
------------- moving camera -----------------
cam.pos.y = 0
fn not90ange vp1 vp2 campos = ---------- checking 90 degree angle
(
	result = true
	theangle = acos(dot (normalize (vp1-campos)) (normalize (vp2-campos)))
	--print theangle
	if theangle <= 90 then result = false
	return result
)

do 
(
	cam.pos.y = cam.pos.y - 1
)
while
(
	not90ange vp2 vp3 cam.pos
)
------------- END moving camera -----------------

-----------calculating FOV --------------
--diagonal = sqrt(img.width^2 + img.height^2)
--radius = diagonal /  2
radius = img.width/2
myfov = (atan(radius/abs(cam.pos.y))) *2
cam.fovType = 1
cam.fov = myfov
cam.farrange = abs(cam.pos.y)
cam.showRanges = true
----------- END calculating FOV --------------
	

-------- creating new aligned camera ----------
print vp1.z
print cam.pos.z

cam2 = copy cam
cam2.name = "111_cm_cameraAligned"
if vp1.z > cam.pos.z then
(---- positive vertical vanishing point ------
	nm = matrix3 (normalize(vp2-cam.pos)) (normalize(vp3-cam.pos)) (normalize(vp1-cam.pos)) [0,0,0]
	nm=inverse(nm)
	cam2.transform = cam2.transform*nm
)
else
( ---- negative vertical vanishing point ------
	nm = matrix3 (normalize(vp3-cam.pos)) (normalize(vp2-cam.pos)) (normalize(vp1-cam.pos)) [0,0,0]
	nm=inverse(nm)
	cam2.transform = cam2.transform*nm
	d = Dummy pos:[0,0,0]
	cam2.parent = d
	rotate d (angleaxis 180 [0,1,0])
	delete d
)

-------- END creating new aligned camera ----------
	
	
--------- setting render dims to file -------------
renderHeight = img.height
renderWidth = img.width
--------- END setting render dims to file -------------

----- deleting helpers -----------

	if deletehelpers == true then
	(
		try
		(
			delete pl
			delete pp
		)
		catch (print "error!")
	)
----- END deleting helpers -----------
)

rollout ak_about "About" 
(
	label lbl0 "cameraMatch"
	label lll "v0.3"
	label lbl3 "(c) 2011-2012" 
	label lbl4 "Andrei Kletskov (111)"
	label lbl5 "http://andklv.narod.ru"
	label lbl6 "andklv@mail.ru"
)


rollout cammatch "cM"
(
	label lbl0 "1." pos:[1,4]
	button tex "select image" pos:[16, 1] width:88
	label lbl1 "2.   edit splines" pos:[1, 24]
	label lbl2 "3." pos:[1, 44]
	button solve "solve" pos:[16,40]
	label lbl3 "4.   delete helpers" pos:[1,63]
	checkbox chk1 "" pos:[90,63]
	button btn_info "i" pos:[88,35] width:16 height:16
	
	on btn_info pressed do createdialog ak_about
	
	on tex pressed do
	(
		try 
		(
			filename = getBitmapOpenFileName()
			tex.caption= filename
			part1 filename
		) 
		catch (messagebox "something wrong!")
	)
	
	on solve pressed do 
	(
		try
		(
			deletehelpers = chk1.checked
			part2()
		)
		catch (messagebox "something wrong!")
	)
)


d = CreateDialog  cammatch 105 80