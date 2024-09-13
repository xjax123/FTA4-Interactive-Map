extends Orbital2D
class_name OrbitalObject2D

@export_category("Object Settings")
@export var ObjectName : StringName = "Unknown Object"
@export_multiline var ObjectDesctiption : String = ""
@export var CanvasTex : CanvasTexture
@export_range(0.0,1.0) var PositionAlongPath : float = 0.0

var lightmask
var sprite : Sprite2D
var currentposonpath

func _init(_name : StringName = "DefaultName", _description : String = "", _texture : CanvasTexture = CanvasTexture.new(), _posalongpath : float = 0.0,pos : Vector2 = Vector2(0,0), modulatecolor : Color = Color(1,1,1), distance : Vector2 = Vector2(100,100), pathwidth : float = 3.0, pathcolor : Color = Color(1,1,1), antialiased : bool = true, speed : float = 1, direction : SysView.OrbitDirection = SysView.OrbitDirection.Left, _lightmask : int = 1) -> void:
	super._init(pos,modulatecolor,distance,pathwidth,pathcolor,antialiased,speed,direction)
	ObjectName = _name
	ObjectDesctiption = _description
	CanvasTex = _texture
	PositionAlongPath = _posalongpath
	lightmask = _lightmask

func _ready() -> void:
	super._ready()
	sprite = Sprite2D.new()
	sprite.texture = CanvasTex
	sprite.light_mask = lightmask
	add_child(sprite)

var ani_time = 0
func _progress_along_orbit(delta):
	ani_time += OrbitalSpeed*delta
	var mod = 0
	if(OrbitDirection == SysView.OrbitDirection.Right):
		mod = 100
	var currentperiod = lerpf(0,1,abs(mod-ani_time)/100) + PositionAlongPath
	if (currentperiod >= 1.0):
		currentperiod -= 1.0
	elif (currentperiod < 0):
		currentperiod += 1.0
	var degrees = deg_to_rad(360*currentperiod)
	var px = (OrbitalDistance.x*OrbitalDistance.y) / sqrt(pow(OrbitalDistance.y,2)+pow(OrbitalDistance.x,2)*pow(tan(degrees),2))
	if( (PI * 0.5) < degrees && (3 * (PI * 0.5)) > degrees ):
		px = abs(px)
	else:
		px = -abs(px)
	var py = px * tan(degrees)
	currentposonpath = Vector2(px,py)
	if (ani_time >= 100):
		ani_time = 0
	sprite.position = currentposonpath
