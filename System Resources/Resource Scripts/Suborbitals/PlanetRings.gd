extends SysSuborbital
class_name SysPlanetRings

@export var modulatecolor : Color = Color(1,1,1)
@export var width : float = 3.0
@export var resolution : int = 360

func _init(_color : Color = Color(1,1,1), _radius : float = 10.0, _zindex : int = 1, _width : float = 3.0, _resolution : int = 360) -> void:
	super._init(radius,Vector2(0,0),_zindex)
	filetype = "Ring"
	modulatecolor = _color
	width = _width
	resolution = _resolution
