// the underfloor wiring terminal for the APC
// autogenerated when an APC is placed
// all conduit connects go to this object instead of the APC
// using this solves the problem of having the APC in a wall yet also inside an area

/obj/structure/machinery/power/terminal
	name = "terminal"
	icon_state = "term"
	desc = "It's an underfloor wiring terminal for power equipment."
	level = 1
	var/obj/structure/machinery/power/master = null
	anchored = TRUE
	directwired = 0 // must have a cable on same turf connecting to terminal
	layer = WIRE_TERMINAL_LAYER
	unacidable = TRUE //so xenos can't melt visible SMES terminals on the planet to break the SMES


/obj/structure/machinery/power/terminal/Initialize()
	. = ..()
	var/turf/T = src.loc
	if(level==1)
		hide(T.intact_tile)

/obj/structure/machinery/power/terminal/Destroy()
	if(master)
		if(istype(master, /obj/structure/machinery/power/apc))
			var/obj/structure/machinery/power/apc/A = master
			A.terminal = null
		master = null
	. = ..()


/obj/structure/machinery/power/terminal/hide(i)
	if(i)
		invisibility = 101
		icon_state = "term-f"
	else
		invisibility = 0
		icon_state = "term"

// Needed so terminals are not removed from machines list.
// Powernet rebuilds need this to work properly.
/obj/structure/machinery/power/terminal/process()
	return 1
