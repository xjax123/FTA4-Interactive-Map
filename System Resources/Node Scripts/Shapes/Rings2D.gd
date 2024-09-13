extends Node2D
class_name Rings2D

@export var ringcolor : Color = Color(1,1,1)
@export var radius : float = 10.0
@export var width : float = 3.0
@export var resolution : float = 360
var lightmask : int = 1
var modcolor : Color = Color(1,1,1)
var line : Line2D

func _init(_color : Color = Color(1,1,1),_modcolor : Color = Color(1,1,1), _radius : float = 10.0, _width : float = 3.0, _resolution : int = 360, _lightmask : int = 1) -> void:
	ringcolor = _color
	modcolor = _modcolor
	radius = _radius
	width = _width
	resolution = _resolution
	lightmask = _lightmask

func _ready() -> void:
	var vec : PackedVector2Array = []
	var x = 0
	var increment = (360/resolution)
	while (x < resolution):
		var deg = deg_to_rad(x) * 2
		vec.append(Vector2(radius*sin(deg),radius*cos(deg)))
		x += increment
	line = Line2D.new()
	line.points = vec
	line.closed = true
	line.default_color = Color(1,1,1)
	line.self_modulate = ringcolor
	line.modulate = modcolor
	line.texture = preload("res://Textures/Planet Textures/ringtexture.png")
	line.texture_mode = Line2D.LINE_TEXTURE_TILE
	line.width = width
	line.light_mask = lightmask
	line.z_index = 1
	add_child(line)
