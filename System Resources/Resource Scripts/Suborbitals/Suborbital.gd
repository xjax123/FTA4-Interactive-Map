extends Resource
class_name SysSuborbital

@export var radius : float = 10.0
var filetype

func _init(_radius : float = 10.0) -> void:
	filetype = "suborbital"
	radius = _radius
