extends Circle2D
class_name Asteroid2D

var startingposition : float
var orbit : Vector2

func _init(startingangle : float, modifiedorbit : Vector2,_position : Vector2,modulatecolor : Color = Color(1,1,1),_occluder : bool = false, _lightmask : int = 1, _occludermask : int = 32, lightsource : bool = false, _lightcullmask : int = 32, _radius : int = 5,_color : Color = Color(1,1,1),_filled : bool = true,_width : float = -1.0,_antialliased : bool = true) -> void:
	super._init(_position,modulatecolor,_occluder,_lightmask,_occludermask,lightsource,_lightcullmask,_radius,_color,_filled,_width,_antialliased)
	startingposition = startingangle
	orbit = modifiedorbit
	if(radius < 5):
		isoccluder = false
	elif(_occluder):
		isoccluder = true
		occluderradius = radius/2
