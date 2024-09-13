extends Suborbital2D
class_name Moon2D

@export var MoonName : StringName = "Unknown Moon"
@export var MoonDesc : String = ""
@export var MoonSize : float = 3.0
@export var MoonColor : Color = Color(1,1,1)
@export var MoonSpeed : float = 1.0
@export var MoonDirection : SysView.OrbitDirection = SysView.OrbitDirection.Left
@export_range(0.0,1.0) var StartingOffset : float = 0.0

var circle : PlanetCircle
var degrees
var currentposonpath

func _init(pos : Vector2 = Vector2(0,0), modulatecolor : Color = Color(1,1,1), radius : float = 10, showpath : bool = true, pathwidth : float = 2.0, pathcolor : Color = Color(1,1,1),name : StringName = "Unknown Moon", description : String = "", size : float = 3.0, color : Color = Color(1,1,1), _occluderoffset : float = 0.0, speed : float = 1.0,direction : SysView.OrbitDirection = SysView.OrbitDirection.Left, offset : float = 0.0) -> void:
	super._init(radius,showpath,pathwidth,pathcolor)
	MoonName = name
	MoonDesc = description
	MoonSize = size
	MoonColor = color
	MoonSpeed = speed
	MoonDirection = direction
	StartingOffset = offset
	
	circle = PlanetCircle.new(MoonName,pos,modulatecolor,true,7,7,false,0,MoonSize,MoonColor,_occluderoffset)
	add_child(circle)

func _ready() -> void:
	super._ready()

var ani_time : float = 0
func _progress_along_orbit(delta):
	ani_time += MoonSpeed*delta
	var mod = 0
	if(MoonDirection == SysView.OrbitDirection.Right):
		mod = 100
	var currentperiod = lerpf(0,1,abs(mod-ani_time)/100) + StartingOffset
	if (currentperiod >= 1.0):
		currentperiod -= 1.0
	elif (currentperiod < 0):
		currentperiod += 1.0
	degrees = deg_to_rad(360*currentperiod)
	currentposonpath = Vector2(radius*cos(degrees),radius*sin(degrees))
	if (ani_time >= 100):
		ani_time = 0
	circle.position = currentposonpath
	circle.update_occluder(degrees)
