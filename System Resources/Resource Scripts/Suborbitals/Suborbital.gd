extends Resource
class_name SysSuborbital

@export var radius : float = 10.0
@export var offset : Vector2 = Vector2(0,0)
@export var zindex : int = 1
var filetype

func _init(_radius : float = 10.0, _offset : Vector2 = Vector2(0,0), _zindex : int = 1) -> void:
	filetype = "Suborbital"
	radius = _radius
	offset = offset
	zindex = _zindex 
