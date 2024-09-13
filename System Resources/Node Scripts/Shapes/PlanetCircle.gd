extends Circle2D
class_name PlanetCircle

@export var PlanetName : StringName

var label : RichTextLabel

func _init(planetname : StringName,_position : Vector2,modulatecolor : Color = Color(1,1,1),_occluder : bool = false, _lightmask : int = 1, _occludermask : int = 32, _lightsource : bool = false, _lightcullmask : int = 32,_radius : float = 5,_color : Color = Color(1,1,1),_filled : bool = true,_width : float = -1.0,_antialliased : bool = true,_occluderoffset : float = 0) -> void:
	super._init(_position,modulatecolor,_occluder,_lightmask,_occludermask,_lightsource,_lightcullmask,_radius,_color,_filled,_width,_antialliased,_occluderoffset)
	PlanetName = planetname

func _ready() -> void:
	super._ready()
	label = RichTextLabel.new()
	label.text = PlanetName
	label.size = Vector2(100,40)
	label.visible = false
	label.position = Vector2(5+radius,-10)
	label.z_index = 100
	add_child(label)

func _process(_delta: float) -> void:
	label.scale = Vector2(6-get_viewport().get_camera_2d().zoom_level,6-get_viewport().get_camera_2d().zoom_level)/4
	pass

func on_hover_start():
	label.visible = true
	pass

func on_hover_end():
	label.visible = false
	pass
