extends Suborbital2D
class_name Rings2D

@export var ringcolor : Color = Color(1,1,1)
@export var width : float = 3.0
@export var resolution : float = 180
var lightmask : int = 1
var modcolor : Color = Color(1,1,1)
var ringline : Line2D

func _init(_color : Color = Color(1,1,1),_modcolor : Color = Color(1,1,1), _radius : float = 10.0, _zindex : int = 1, _width : float = 3.0, _resolution : int = 180, _lightmask : int = 1) -> void:
	super._init(_radius,false,0,Color(0,0,0,0),_zindex)
	ringcolor = _color
	modcolor = _modcolor
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
	ringline = Line2D.new()
	ringline.points = vec
	ringline.closed = true
	ringline.default_color = Color(1,1,1)
	ringline.self_modulate = ringcolor
	ringline.modulate = modcolor
	ringline.texture = preload("res://Textures/Planet Textures/ringtexture.png")
	ringline.texture_mode = Line2D.LINE_TEXTURE_TILE
	ringline.width = width
	ringline.light_mask = lightmask
	ringline.z_index = 1
	add_child(ringline)
