extends Suborbital2D
class_name Moon2D

var timemod : float = 1000

@export var MoonName : StringName = "Unknown Moon"
@export var MoonDesc : String = ""
@export var MoonType : SysView.PlanetType = SysView.PlanetType.Rocky
@export var MoonSize : float = 3.0
@export var MoonColor : Color = Color(1,1,1)
@export var MoonSpeed : float = 1.0
@export var RotationSpeed : float = 1.0
@export var MoonDirection : SysView.OrbitDirection = SysView.OrbitDirection.Left
@export var RotationDirection : SysView.OrbitDirection = SysView.OrbitDirection.Left
@export_range(0.0,1.0) var StartingOffset : float = 0.0

var circle : PlanetCircle
var degrees
var rot
var currentposonpath

func _init(_pos : Vector2 = Vector2(0,0), _modulatecolor : Color = Color(1,1,1), _radius : float = 10, _showpath : bool = true, _pathwidth : float = 2.0, _pathcolor : Color = Color(1,1,1), _zindex : int = 1,_name : StringName = "Unknown Moon", _description : String = "", _type : SysView.PlanetType = SysView.PlanetType.Rocky, _size : float = 3.0, _color : Color = Color(1,1,1), _occluderoffset : float = 0.0, _speed : float = 1.0, _rotspeed : float = 1, spindirection : SysView.OrbitDirection = SysView.OrbitDirection.Left,_direction : SysView.OrbitDirection = SysView.OrbitDirection.Left, _offset : float = 0.0) -> void:
	super._init(_radius,_showpath,_pathwidth,_pathcolor,_zindex)
	position = _pos
	MoonName = _name
	MoonDesc = _description
	MoonSize = _size
	MoonColor = _color
	MoonSpeed = _speed
	MoonDirection = _direction
	StartingOffset = _offset
	MoonType = _type
	RotationSpeed = _rotspeed
	RotationDirection = spindirection
	
	timemod = SysView.globaltimemod
	
	circle = PlanetCircle.new(MoonName,_pos,_type,_modulatecolor,true,7,7,false,0,MoonSize,MoonColor,_occluderoffset)
	add_child(circle)

func _ready() -> void:
	super._ready()

var ani_time : float = 0
var spin_time :float = 0
func _progress_along_orbit(delta):
	ani_time += MoonSpeed*delta
	spin_time += RotationSpeed*delta
	
	var spinmod = 0
	if(RotationDirection == SysView.OrbitDirection.Right):
		spinmod = timemod
	var spinperiod = lerpf(0,1,abs(spinmod-ani_time)/timemod)
	
	rot = deg_to_rad(360*spinperiod)
	circle.sprite.rotation = rot
	
	if (spin_time >= timemod):
		spin_time = 0
	
	var mod = 0
	if(MoonDirection == SysView.OrbitDirection.Right):
		mod = timemod
	var currentperiod = lerpf(0,1,abs(mod-ani_time)/timemod) + StartingOffset
	if (currentperiod >= 1.0):
		currentperiod -= 1.0
	elif (currentperiod < 0):
		currentperiod += 1.0
	degrees = deg_to_rad(360*currentperiod)
	currentposonpath = Vector2(radius*cos(degrees),radius*sin(degrees))
	if (ani_time >= timemod):
		ani_time = 0
	circle.position = currentposonpath
	circle.update_occluder(degrees)
	if rad_to_deg(degrees) > 0 && rad_to_deg(degrees) <= 90:
		circle.update_label_position(Vector2(5+MoonSize,-5))
	elif rad_to_deg(degrees) > 90 && rad_to_deg(degrees) <= 180:
		circle.update_label_position(Vector2(-40-MoonSize,-5))
	elif rad_to_deg(degrees) > 180 && rad_to_deg(degrees) <= 270:
		circle.update_label_position(Vector2(-40-MoonSize,-20))
	else:
		circle.update_label_position(Vector2(5+MoonSize,-20))
