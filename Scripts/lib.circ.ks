// lib.node v1.0.0 
// This library will be for creating nodes for maneuver to execute
// Author: Phreak420
// Credit: kOS Reddit community, Orbital Mechanics Wiki, and CheersKevinGames (Youtube)


Function circularize { // This is for doing the maths of figuring out circular orbit velocity.
	set Rad to BODY:RADIUS + APOAPSIS.
	set Gu to body:mu.
	set SMA to SHIP:OBT:SEMIMAJORAXIS.
	
	set circV to sqrt(Gu/Rad). //Calculating velocity needed to circularize at apoapsis
	set apV to sqrt(Gu * (2/Rad - 1/SMA)). //Calculating velocity at apoapsis
	set DV to (circV - apV).
	
	set circNode to node((TIME:SECONDS + ETA:APOAPSIS), 0, 0, DV).
	add circNode.
}


