extends Node2D
class_name Orbital2D

@export var OrbitalDistanceLM : Vector2
var OrbitalDistance : Vector2
@export var OrbitalPathWidth : float
@export var OrbitalPathColor : Color
@export var PathAntialiasing : bool
@export var OrbitalSpeed : float
@export var ModulateColor : Color
@export var OrbitDirection : SysView.OrbitDirection
var path : PackedVector2Array
var line : AntialiasedLine2D

func _init(bufferdist : float, pos : Vector2 = Vector2(0,0), modulatecolor : Color = Color(1,1,1), distance : Vector2 = Vector2(100,100), pathwidth : float = 3.0, pathcolor : Color = Color(1,1,1), antialiased : bool = true, speed : float = 1, direction : SysView.OrbitDirection = SysView.OrbitDirection.Left) -> void:
	position = pos
	OrbitalDistanceLM = distance
	OrbitalDistance = OrbitalDistanceLM*24
	OrbitalDistance.x += bufferdist
	OrbitalDistance.y += bufferdist
	OrbitalPathWidth = pathwidth
	OrbitalPathColor = pathcolor
	PathAntialiasing = antialiased
	OrbitalSpeed = speed
	ModulateColor = modulatecolor
	OrbitDirection = direction

func _ready() -> void:
	light_mask = 512
	var x = 0
	while (x < 360):
		var rad = deg_to_rad(x)
		var px = (OrbitalDistance.x*OrbitalDistance.y) / sqrt(pow(OrbitalDistance.y,2)+pow(OrbitalDistance.x,2)*pow(tan(rad),2))
		if( (PI * 0.5) < rad && (3 * (PI * 0.5))+deg_to_rad(1) > rad ):
			px = abs(px)
		else:
			px = -abs(px)
		var py = px * tan(rad)
		var currentposonpath = Vector2(px,py)
		path.append(currentposonpath)
		x +=1
	line = AntialiasedLine2D.new()
	line.points = path
	line.closed = true
	line.width = OrbitalPathWidth
	line.default_color = OrbitalPathColor
	line.z_index = -1
	add_child(line)

func _progress_along_orbit(_delta) -> void:
	pass

func _process(delta: float) -> void:
	line.width = 1 / get_viewport().get_camera_2d().zoom.x * 2.5

func _draw() -> void:
	pass
