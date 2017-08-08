// boot.ks V1.0.0
// This file will check for conditions of the ship and install the appropriate files
// Author: Phreak420

wait until SHIP:UNPACKED.

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
  SWITCH TO 0.

  IF HAS_FILE(fname, 1) {
    DELETE fname.
  }
  IF HAS_FILE(fname, 0) {
    COPY fname FROM 0.
  }
}
DOWNLOAD(boot.ks).
if ALT:RADAR < 200 {
	DOWNLOAD(lib.launch.ks).
	DOWNLOAD(lib.maneuver.ks).
	DOWNLOAD(lib.circ.ks).
	run lib.launch.ks.
	run lib.maneuver.ks.
	run lib.circ.ks.
	STAGE.
	execLaunchProfile(90, ascentProfile).
	wait until ALT:RADAR >= 90000.
	circularize().
	mnv_exec().
}