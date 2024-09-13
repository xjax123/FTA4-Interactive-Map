extends Resource
class_name SysOrbital

var filetype : String

@export_category("Orbital Settings")
@export var OrbitalOffset : Vector2 = Vector2(0,0)
@export var OrbitalPathColor : Color = Color(1,1,1)
@export var OrbitalPathThickness : float = 3.0
@export var DistanceFromStar : Vector2 = Vector2(100,100)
@export var OrbitalSpeed : float = 1
@export var OrbitDirection : SysView.OrbitDirection = SysView.OrbitDirection.Left

func _init(orbitaloffset : Vector2 = Vector2(0,0), pathcol : Color = Color(1,1,1), width : float = 3.0, distance : Vector2 = Vector2(100,100), speed : float = 1, direction : SysView.OrbitDirection = SysView.OrbitDirection.Left):
	filetype = "Orbital"
	OrbitalOffset = orbitaloffset
	OrbitalPathColor = pathcol
	OrbitalPathThickness = width
	DistanceFromStar = distance
	OrbitalSpeed = speed
	OrbitDirection = direction
