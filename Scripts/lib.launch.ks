// Lib.Launch.ks v1.0.0
// These functions should only control flight from surface to orbit.
// The description and use should be included with every unique function created.
// Author: Phreak420
global ascentProfile to LIST( //
	// Angle 	 Altitude 	Throttle
		90,		 0,			1,
		80,		 1000,		1,
		70,		 3000,		1,
		60,		 5000,		1,
		55,		 8000,		1,
		50,		 10000,		1,
		40,		 20000,		1,
		35,		 30000,		0.6,
		15,		 40000,		0.5,
		5,		 50000,		1,
		0,		 62000,		0
).
FUNCTION launchTilt { //This function will control steering from launch to orbit
	PARAMETER newDirection.
	PARAMETER newAngle.
	PARAMETER minAlt.
	PARAMETER newThrottle.
	
		set prevThrust to MAXTHRUST.
		
		until FALSE {
			if MAXTHRUST < (prevThrust - 10) OR MAXTHRUST = 0 { // Used for staging. Will work with asparagus staging too.
				set currentThrottle to THROTTLE.
				lock THROTTLE to 0.
				wait 1. 
				STAGE. 
				wait 1.
				lock THROTTLE to currentThrottle.
				set prevThrust to MAXTHRUST.
			}
			if ALTITUDE > minAlt {
				lock STEERING to HEADING(newDirection, newAngle).
				lock THROTTLE to newThrottle.
				BREAK.
			}
			wait 0.1.
		}
}	

FUNCTION execLaunchProfile {
  PARAMETER direction.
  PARAMETER profile.

  SET aStep TO 0.
  UNTIL aStep >= profile:length - 1 {
    launchTilt(
      direction,
      profile[aStep],
      profile[aStep+1],
      profile[aStep+2]
    ).
    SET aStep TO aStep + 3.
  }
}