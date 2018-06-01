
fn SelectByAngle_v  = --start	
(
	
  
		curObj = modpanel.getCurrentObject ()
		
		if not curObj.selectByAngle  then 
		(
			curObj.selectByAngle = on
			curObj.selectAngle = 5

		)
		else
		(
			curObj.selectByAngle = off
	
		)
	
	
)

