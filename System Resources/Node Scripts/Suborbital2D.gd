extends Node2D
class_name Suborbital2D

@export var radius : float = 10
@export var showpath : bool = true
@export var pathwidth : float = 2.0
@export var pathcolor : Color = Color(0,0,0)

var path : PackedVector2Array
var line : Line2D

func _init(_radius : float = 10, _showpath : bool = true, _pathwidth : float = 3.0, _pathcolor : Color = Color(1,1,1)) -> void:
	radius = _radius
	showpath = _showpath
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	light_mask = 512
	if(showpath):
		var x = 0
		while (x < 360):
			var rad = deg_to_rad(x)
			var currentposonpath = Vector2(radius*cos(rad),radius*sin(rad))
			path.append(currentposonpath)
			x +=1
		line = Line2D.new()
		line.points = path
		line.closed = true
		line.width = pathwidth
		line.default_color = pathcolor
		line.z_index = -1
		add_child(line)

func _progress_along_orbit(delta):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
