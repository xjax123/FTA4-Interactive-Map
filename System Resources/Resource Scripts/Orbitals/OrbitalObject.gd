extends SysOrbital
class_name SysOrbitalObject

@export_category("Object Settings")
@export var ObjectName : StringName = "Unknown Object"
@export_multiline var ObjectDesctiption : String = ""
@export var CanvasTex : CanvasTexture
@export_range(0.0,1.0) var PositionAlongPath : float = 0.0

func _init(name : StringName = "DefaultName", description : String = "", texture : CanvasTexture = CanvasTexture.new(), posalongpath : float = 0.0, orbitaloffset : Vector2 = Vector2(0,0) , pathcol : Color = Color(1,1,1), width : float = 3.0, distance : Vector2 = Vector2(100,100), speed : float = 1,direction : SysView.OrbitDirection = SysView.OrbitDirection.Left) -> void:
	super._init(orbitaloffset,pathcol, width, distance, speed, direction)
	ObjectName = name
	ObjectDesctiption = description
	CanvasTex = texture
	PositionAlongPath = posalongpath
