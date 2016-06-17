// lib.node v1.0.0 
// This library will be for creating nodes for maneuver to execute
// Author: Phreak420
// Credit: kOS Reddit community and CheersKevinGames (Youtube)
//@LAZYGLOBAL off.


Function circularize { // This is for doing the maths of figuring out circular orbit velocity.
	set Rad to BODY:RADIUS + APOAPSIS.
	set Gu to body:mu/(BODY:RADIUS + APOAPSIS)^2.
	set h to APOAPSIS.
	set SMA to SHIP:OBT:SEMIMAJORAXIS.
	
	set circV to sqrt(Gu/Rad+h). //Calculating velocity needed to circularize at apoapsis
	set apV to sqrt(Gu * (2/Rad - 1/SMA)). //Calculating velocity at apoapsis
	set DV to (circV - apV).
	
	set circNode to node((TIME:SECONDS + ETA:APOAPSIS), 0, 0, DV).
	add circNode.
}



// v = sqrt(GM/r) This is the calculation for orbital velocity at a given altitude
 // set deltaV to (orbitalVelocity - apVelocity).

// This calculation should be telling me my velocity at apoapsis.
//set G to SHIP:ORBIT:BODY:MU / (BODY:RADIUS + APOAPSIS)^2.
//set R to BODY:RADIUS + APOAPSIS.
//set A to ORBIT:SEMIMAJORAXIS.
//set V to SQRT(G * ((2/R) - (1/A))).
//print V.


