extends SysSuborbital
class_name SysMoon

@export var ShowPath : bool = true
@export var PathWidth : float = 2.0
@export var Pathcolor : Color = Color(1,1,1)
@export var MoonName : StringName = "Unknown Moon"
@export var MoonDesc : String = ""
@export var MoonType : SysView.PlanetType = SysView.PlanetType.Rocky
@export var MoonSize : float = 3.0
@export var MoonColor : Color = Color(1,1,1)
@export var MoonSpeed : float = 1.0
@export var RotationSpeed : float = 1
@export var MoonDirection : SysView.OrbitDirection = SysView.OrbitDirection.Left
@export var RotationDirection : SysView.OrbitDirection = SysView.OrbitDirection.Left
@export_range(0.0,1.0) var StartingOffset : float = 0.0

func _init(_radius : float = 10, _offset : Vector2 = Vector2(0,0), _zindex : int = 1, showpath : bool = true, pathwidth : float = 2.0, pathcolor : Color = Color(1,1,1),name : StringName = "Unknown Moon", description : String = "", type : SysView.PlanetType = SysView.PlanetType.Rocky, size : float = 3.0, color : Color = Color(1,1,1), speed : float = 1, rotspeed : float = 1, spindirection : SysView.OrbitDirection = SysView.OrbitDirection.Left,direction : SysView.OrbitDirection = SysView.OrbitDirection.Left,rotoffset : float = 0.0) -> void:
	super._init(_radius, _offset,_zindex)
	filetype = "Moon"
	ShowPath = showpath
	PathWidth = pathwidth
	Pathcolor = pathcolor
	MoonName = name
	MoonDesc = description
	MoonSize = size
	MoonColor = color
	MoonSpeed = speed
	MoonDirection = direction
	StartingOffset = rotoffset
	MoonType = type
	RotationSpeed = rotspeed
	RotationDirection = spindirection
