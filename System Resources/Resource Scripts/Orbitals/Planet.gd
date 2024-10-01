extends SysOrbital
class_name SysPlanet

@export_category("Planet Settings")
@export var PlanetName : StringName
@export var PlanetSize : int = 5
@export var PlanetType : SysView.PlanetType = SysView.PlanetType.Rocky
@export var PlanetColor : Color = Color(1,1,1)
@export var RotationSpeed : float = 1
@export var RotationDirection : SysView.OrbitDirection = SysView.OrbitDirection.Left
@export_range(0.0,1.0) var PositionAlongOrbit : float = 0

@export var Suborbitals : Array[SysSuborbital]

func _init(name : StringName = "DefaultName", size : int = 5, type : SysView.PlanetType = SysView.PlanetType.Rocky,planetcol : Color = Color(1,1,1), posalongpath : float = 0.0,suborbitals : Array[SysSuborbital] = [], orbitaloffset : Vector2 = Vector2(0,0) , pathcol : Color = Color(1,1,1), width : float = 3.0, distance : Vector2 = Vector2(100,100), speed : float = 1, rotspeed : float = 1,spindirection : SysView.OrbitDirection = SysView.OrbitDirection.Left,direction : SysView.OrbitDirection = SysView.OrbitDirection.Left) -> void:
	super._init(orbitaloffset,pathcol, width, distance, speed, direction)
	filetype = "Planet"
	PlanetName = name
	PlanetSize = size
	PlanetType = type
	PlanetColor = planetcol
	PositionAlongOrbit = posalongpath
	Suborbitals = suborbitals
	RotationSpeed = rotspeed
	RotationDirection = spindirection
