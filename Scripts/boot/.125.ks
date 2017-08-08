// boot.ks V1.0.0
// This file will check for conditions of the ship and install the appropriate files
// Author: Phreak420

PRINT "Waiting for physics to load.".
wait 3.

set SHIP:CONTROL:PILOTMAINTHROTTLE to 0.

FUNCTION HAS_FILE {
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

FUNCTION DOWNLOAD {
  PARAMETER fname.

  IF HAS_FILE(fname, 1) {
    DELETE fname.
  }
  IF HAS_FILE(fname, 0) {
    COPY fname FROM 0.
  }
}
DOWNLOAD(boot.ks).

if ALT:RADAR < 200 {
	set ascentProfile to LIST( // This profile is optimized for 1.25m medium weight rocket
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
	DOWNLOAD(lib.launch.ks).
	run lib.launch.ks.
	STAGE.
	execLaunchProfile(90, ascentProfile).
		wait until ETA:APOAPSIS <= 10.
		set curAP to APOAPSIS.
		set pro to prograde.
		lock steering to pro.
		lock throttle to 1.
		wait until PERIAPSIS >= curAP - 5000.
		lock throttle to 0.01.
		wait until PERIAPSIS >= curAP - 1000.
		lock throttle to 0.
}
