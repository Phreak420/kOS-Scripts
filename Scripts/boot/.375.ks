// boot.ks V1.0.0
// This file will check for conditions of the ship and install the appropriate files
// Author: Phreak420
WAIT 5. //Wait for physics to load
set SHIP:CONTROL:PILOTMAINTHROTTLE to 0. //Don't blast off at the end of the program

FUNCTION HAS_FILE {//This function will check if a file name exists
  PARAMETER fname.
  PARAMETER vol.

  SWITCH TO vol.
  LIST FILES IN allFiles.
  FOR file IN allFiles {
    IF file:NAME = fname {
      SWITCH TO 1.
      RETURN TRUE.
    }
  }
  SWITCH to 1.
  RETURN FALSE.
}

FUNCTION DOWNLOAD {	//This function will download any file to your local craft from the archive 
  PARAMETER fname.	//(useful for updating files)

  IF HAS_FILE(fname, 1) {
    DELETE fname.
  }
  IF HAS_FILE(fname, 0) {
    COPY fname FROM 0.
  }
}
DOWNLOAD(boot.ks).

if ALT:RADAR < 200 {
	set ascentProfile to LIST( //This has been tuned for a 3.75m craft with a 3+ TTWR
		// Angle 	 Altitude 	Throttle
			90,		 0,			0.5,
			80,		 1000,		0.5,
			70,		 3000,		0.3,
			65,		 5000,		0.3,
			60,		 7000,		0.3,
			55,		 8000,		0.3,
			45,		 10000,		0.7,
			30,		 20000,		0.6,
			25,		 30000,		0.5,
			15,		 40000,		0.4,
			5,		 50000,		0.3,
			0,		 55000,		0
		).
	DOWNLOAD(lib.launch.ks).
	run lib.launch.ks.
	STAGE.
	execLaunchProfile(90, ascentProfile).

		wait until ETA:APOAPSIS <= 10.
		set curAP to APOAPSIS.
		set pro to PROGRADE.
		lock steering to pro.
		lock throttle to 1.
		wait until PERIAPSIS >= curAP - 5000.
		lock throttle to 0.03.
		wait until PERIAPSIS >= curAP - 1000.
		lock throttle to 0.
}
