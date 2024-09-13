extends Resource
class_name SysObject

@export var ObjectName : StringName = "Unknown Object"
@export_multiline var ObjectDesctiption : String = ""
@export var LabelPosition : Vector2 = Vector2(0,0)
@export var CanvasTex : CanvasTexture
@export var Position : Vector2 = Vector2(0,0)
@export var Size : float = 10

func _init(name : StringName = "Unknown Object", description : String = "", labelposition : Vector2 = Vector2(0,0), texture : CanvasTexture = CanvasTexture.new(), position : Vector2 = Vector2(0,0),_size : float = 10) -> void:
	ObjectName = name
	ObjectDesctiption = description
	LabelPosition = labelposition
	CanvasTex = texture
	Position = position
	Size = _size
