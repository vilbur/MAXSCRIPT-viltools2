fn Angle_v treshold = 	
(

		curObj = modpanel.getcurrentobject ()
		if curObj.SelectByAngle == false then 
		(
		curObj.SelectByAngle = true 
		curObj.selectAngle = treshold
		)
		else
		curObj.SelectByAngle = false
		
		
)