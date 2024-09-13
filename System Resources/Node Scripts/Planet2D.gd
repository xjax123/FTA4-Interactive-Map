extends Orbital2D
class_name Planet2D

@export var PlanetName : StringName
@export var PlanetSize : float
@export var PlanetColor : Color
@export_range(0.0,1.0) var StartingPositionAlongPath : float

@export var Suborbitals : Array[SysSuborbital] = []

var circle : PlanetCircle

var currentposonpath : Vector2
var occluder : LightOccluder2D

func _init(planetname : StringName = "DefaultName", pos : Vector2 = Vector2(0,0), modulatecolor : Color = Color(1,1,1), size : float = 5, planetcolor : Color = Color(1,1,1), posalongpath : float = 0,suborbitals : Array[SysSuborbital] = [], distance : Vector2 = Vector2(100,100), pathwidth : float = 3.0, pathcolor : Color = Color(1,1,1), antialiased : bool = true, speed : float = 1, direction : SysView.OrbitDirection = SysView.OrbitDirection.Left,_occluderoffset : float = 0) -> void:
	super._init(pos,modulatecolor,distance,pathwidth,pathcolor,antialiased,speed,direction)
	PlanetName = planetname
	PlanetSize = size
	PlanetColor = planetcolor
	StartingPositionAlongPath = posalongpath
	Suborbitals = suborbitals
	
	circle = PlanetCircle.new(planetname,pos,modulatecolor,true,7,7,false,0,size,planetcolor,_occluderoffset)
	add_child(circle)
	
	for suborbital in suborbitals:
		if suborbital.filetype == "Ring":
			var temp = Rings2D.new(suborbital.modulatecolor,modulatecolor,suborbital.radius,suborbital.width,suborbital.resolution,7)
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

func _progress_along_orbit(delta):
	ani_time += OrbitalSpeed*delta
	var mod = 0
	if(OrbitDirection == SysView.OrbitDirection.Right):
		mod = 100
	var currentperiod = lerpf(0,1,abs(mod-ani_time)/100) + StartingPositionAlongPath
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
	if (ani_time >= 100):
		ani_time = 0
	circle.position = currentposonpath
	circle.update_occluder(degrees)

func _draw() -> void:
	super._draw()
	circle.queue_redraw()
