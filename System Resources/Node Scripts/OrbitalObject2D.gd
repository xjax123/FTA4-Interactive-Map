extends Orbital2D
class_name OrbitalObject2D

@export_category("Object Settings")
@export var ObjectName : StringName = "Unknown Object"
@export_multiline var ObjectDesctiption : String = ""
@export var CanvasTex : CanvasTexture
@export_range(0.0,1.0) var PositionAlongPath : float = 0.0
@export var ObjectTouchRange : float = 10

var lightmask
var sprite : Sprite2D
var currentposonpath
var label : RichTextLabel
var TouchArea : Area2D
var container : Node2D
var timemod

func _init(bufferdist : float, _name : StringName = "DefaultName", _description : String = "", _texture : CanvasTexture = CanvasTexture.new(), _posalongpath : float = 0.0, _touchrange : float = 10,pos : Vector2 = Vector2(0,0), modulatecolor : Color = Color(1,1,1), distance : Vector2 = Vector2(100,100), pathwidth : float = 3.0, pathcolor : Color = Color(1,1,1), antialiased : bool = true, speed : float = 1, direction : SysView.OrbitDirection = SysView.OrbitDirection.Left, _lightmask : int = 1) -> void:
	super._init(bufferdist,pos,modulatecolor,distance,pathwidth,pathcolor,antialiased,speed,direction)
	ObjectName = _name
	ObjectDesctiption = _description
	CanvasTex = _texture
	PositionAlongPath = _posalongpath
	lightmask = _lightmask
	ObjectTouchRange = _touchrange

func _ready() -> void:
	super._ready()
	timemod = SysView.globaltimemod
	
	container = Node2D.new()
	sprite = Sprite2D.new()
	sprite.texture = CanvasTex
	sprite.light_mask = lightmask
	sprite.scale = Vector2(ObjectTouchRange/2.0*0.02,ObjectTouchRange/2.0*0.02)
	sprite.modulate = ModulateColor
	container.add_child(sprite)
	
	label = RichTextLabel.new()
	label.text = ObjectName
	label.size = Vector2(300,100)
	label.visible = false
	label.position = Vector2(5+ObjectTouchRange,-10)
	label.z_index = 100
	container.add_child(label)
	
	TouchArea = Area2D.new()
	var Shape = CollisionShape2D.new()
	var circ = CircleShape2D.new()
	circ.radius = ObjectTouchRange
	Shape.shape = circ
	TouchArea.add_child(Shape)
	container.add_child(TouchArea)
	TouchArea.connect("mouse_entered", on_hover_start)
	TouchArea.connect("mouse_exited", on_hover_end)
	TouchArea.connect("input_event", mouse_click)
	add_child(container)

var ani_time = 0
func _progress_along_orbit(delta):
	ani_time += OrbitalSpeed*delta
	var mod = 0
	if(OrbitDirection == SysView.OrbitDirection.Right):
		mod = timemod
	var currentperiod = lerpf(0,1,abs(mod-ani_time)/timemod) + PositionAlongPath
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
	if (ani_time >= timemod):
		ani_time = 0
	container.position = currentposonpath

func _process(_delta: float) -> void:
	var factor = pow(5.5-get_viewport().get_camera_2d().zoom_level,1.5)/8
	label.scale = Vector2(factor,factor)

func on_hover_start():
	label.visible = true
	pass

func on_hover_end():
	label.visible = false
	pass

func mouse_click(_viewport : Node, _event: InputEvent, _shape_idx : int):
	pass
