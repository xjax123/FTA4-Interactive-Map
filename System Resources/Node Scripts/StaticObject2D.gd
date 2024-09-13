extends Node2D
class_name StaticObject2D

@export var ObjectName : StringName = "Unknown Object"
@export_multiline var ObjectDesctiption : String = ""
@export var CanvasTex : CanvasTexture
@export var Position : Vector2 = Vector2(0,0)

var label : RichTextLabel
var labeloffset : Vector2
var touchareasize : float

var sprite : Sprite2D
var TouchArea : Area2D
var lightmask : int

func _init(_name : StringName = "Unknown Object", _description : String = "", _texture : CanvasTexture = CanvasTexture.new(), _position : Vector2 = Vector2(0,0), _labeloffset : Vector2 = Vector2(0,0), _touchareasize : float = 10, _lightmask : int = 1, zindex : int = 1) -> void:
	ObjectName = _name
	ObjectDesctiption = _description
	CanvasTex = _texture
	Position = _position
	position = _position
	labeloffset = _labeloffset
	lightmask = _lightmask
	z_index = zindex
	touchareasize = _touchareasize

func _ready() -> void:
	sprite = Sprite2D.new()
	sprite.texture = CanvasTex
	sprite.light_mask = lightmask
	sprite.scale = Vector2(touchareasize/5.0*0.02,touchareasize/5.0*0.02)
	add_child(sprite)
	
	label = RichTextLabel.new()
	label.text = ObjectName
	label.size = Vector2(300,100)
	label.visible = false
	label.position = labeloffset
	label.z_index = 100
	add_child(label)
	
	TouchArea = Area2D.new()
	var Shape = CollisionShape2D.new()
	var circ = CircleShape2D.new()
	circ.radius = touchareasize
	Shape.shape = circ
	TouchArea.add_child(Shape)
	add_child(TouchArea)
	TouchArea.connect("mouse_entered", on_hover_start)
	TouchArea.connect("mouse_exited", on_hover_end)
	TouchArea.connect("input_event", mouse_click)

func _process(delta: float) -> void:
	label.scale = Vector2(6-get_viewport().get_camera_2d().zoom_level,6-get_viewport().get_camera_2d().zoom_level)/4

func on_hover_start():
	label.visible = true
	pass

func on_hover_end():
	label.visible = false
	pass

func mouse_click(_viewport : Node, _event: InputEvent, _shape_idx : int):
	pass
