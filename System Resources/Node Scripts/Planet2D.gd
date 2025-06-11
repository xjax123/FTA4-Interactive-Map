extends Orbital2D
class_name Planet2D

var timemod : float = 1000

@export var PlanetName : StringName
@export var PlanetSize : float
@export var PlanetColor : Color
@export var PlanetType : SysView.PlanetType
@export var RotationSpeed : float = 1
@export var RotationDirection : SysView.OrbitDirection = SysView.OrbitDirection.Left
@export_range(0.0,1.0) var StartingPositionAlongPath : float

@export var Suborbitals : Array[SysSuborbital] = []
var subs : Array[Suborbital2D] = []

var circle : PlanetCircle

var currentposonpath : Vector2
var rot : float
var occluder : LightOccluder2D

func _init(bufferdist : float, planetname : StringName = "DefaultName", pos : Vector2 = Vector2(0,0), modulatecolor : Color = Color(1,1,1), size : float = 5, type : SysView.PlanetType = SysView.PlanetType.Rocky, planetcolor : Color = Color(1,1,1), posalongpath : float = 0,suborbitals : Array[SysSuborbital] = [], distance : Vector2 = Vector2(100,100), pathwidth : float = 3.0, pathcolor : Color = Color(1,1,1), antialiased : bool = true, speed : float = 1, _rotspeed : float = 1, spindirection : SysView.OrbitDirection = SysView.OrbitDirection.Left, direction : SysView.OrbitDirection = SysView.OrbitDirection.Left,_occluderoffset : float = 0) -> void:
	super._init(bufferdist,pos,modulatecolor,distance,pathwidth,pathcolor,antialiased,speed,direction)
	PlanetName = planetname
	PlanetSize = size
	PlanetType = type
	PlanetColor = planetcolor
	StartingPositionAlongPath = posalongpath
	Suborbitals = suborbitals
	RotationSpeed = _rotspeed
	RotationDirection = spindirection
	
	timemod = SysView.globaltimemod
	
	circle = PlanetCircle.new(planetname,pos,type,modulatecolor,true,7,7,false,0,size,planetcolor,_occluderoffset)
	circle.update_label_scale(Vector2(1.5,1.5))
	add_child(circle)
	
	for suborbital in suborbitals:
		var temp
		if suborbital.filetype == "Ring":
			temp = Rings2D.new(suborbital.modulatecolor,modulatecolor,suborbital.radius,suborbital.zindex,suborbital.width,suborbital.resolution,7)
		if suborbital.filetype == "Moon":
			temp = Moon2D.new(suborbital.offset, modulatecolor, suborbital.radius, suborbital.ShowPath,suborbital.PathWidth, suborbital.Pathcolor,suborbital.zindex,suborbital.MoonName,suborbital.MoonDesc,suborbital.MoonType,suborbital.MoonSize,suborbital.MoonColor,0,suborbital.MoonSpeed,suborbital.RotationSpeed,suborbital.RotationDirection,suborbital.MoonDirection,suborbital.StartingOffset)
		subs.append(temp)
		circle.add_child(temp)

var degrees : float 

func _ready() -> void:
	super._ready()
	degrees = deg_to_rad(360*StartingPositionAlongPath)
	var px = (OrbitalDistance.x*OrbitalDistance.y) / sqrt(pow(OrbitalDistance.y,2)+pow(OrbitalDistance.x,2)*pow(tan(degrees),2))
	if( (PI * 0.5) < degrees && (3 * (PI * 0.5)) > degrees ):
		px = abs(px)
	else:
		px = -abs(px)
	var py = px * tan(degrees)
	currentposonpath = Vector2(px,py)
	
	circle.position = currentposonpath
	circle.update_occluder(degrees)

var ani_time : float = 0
var spin_time : float = 0
var years = SysView.globalyear
func _progress_along_orbit(delta):
	ani_time += OrbitalSpeed*delta
	spin_time += RotationSpeed*delta
	
	var spinmod = 0
	if(RotationDirection == SysView.OrbitDirection.Right):
		spinmod = timemod
	var spinperiod = lerpf(0,1,abs(spinmod-spin_time)/timemod)
	
	rot = deg_to_rad(360*spinperiod)
	circle.sprite.rotation = rot
	
	if (spin_time >= timemod):
		spin_time = 0
	
	var mod = 0
	if(OrbitDirection == SysView.OrbitDirection.Right):
		mod = timemod
	var currentperiod = lerpf(0,1,abs(mod-ani_time)/timemod) + StartingPositionAlongPath
	if (currentperiod >= 1.0):
		currentperiod -= 1.0
	elif (currentperiod < 0):
		currentperiod += 1.0
	degrees = deg_to_rad(360*currentperiod)
	var px = (OrbitalDistance.x*OrbitalDistance.y) / sqrt(pow(OrbitalDistance.y,2)+pow(OrbitalDistance.x,2)*pow(tan(degrees),2))
	if( (PI * 0.5) < degrees && (3 * (PI * 0.5)) > degrees ):
		px = abs(px)
	else:
		px = -abs(px)
	var py = px * tan(degrees)
	currentposonpath = Vector2(px,py)
	if (ani_time >= timemod):
		ani_time = 0
	circle.position = currentposonpath
	circle.update_occluder(degrees)
	for sub in subs:
		sub._progress_along_orbit(delta)

func _draw() -> void:
	super._draw()
	circle.queue_redraw()
