extends Circle2D
class_name PlanetCircle

@export var PlanetName : StringName
@export var PlanetType : SysView.PlanetType

var label : RichTextLabel
var labelScale : Vector2 = Vector2(1,1)
var labelFontScale : int = 80
var forceShowLabel : bool = false

func _init(planetname : StringName,_position : Vector2, type : SysView.PlanetType = SysView.PlanetType.Rocky ,modulatecolor : Color = Color(1,1,1),_occluder : bool = false, _lightmask : int = 1, _occludermask : int = 32, _lightsource : bool = false, _lightcullmask : int = 32,_radius : float = 5,_color : Color = Color(1,1,1),_filled : bool = true,_width : float = -1.0,_antialliased : bool = true,_occluderoffset : float = 0) -> void:
	super._init(_position,modulatecolor,_occluder,_lightmask,_occludermask,_lightsource,_lightcullmask,_radius,_color,_filled,_width,_antialliased,_occluderoffset)
	PlanetName = planetname
	PlanetType = type

func _ready() -> void:
	super._ready()
	if(PlanetType == SysView.PlanetType.GasGiant):
		sprite.texture.diffuse_texture = preload("res://Textures/Planet Textures/GasGiantBase.png")
	elif(PlanetType == SysView.PlanetType.Rocky):
		sprite.texture.diffuse_texture = preload("res://Textures/Planet Textures/RockyBase.png")
	else:
		sprite.texture.diffuse_texture = preload("res://Textures/Planet Textures/BlankPlanetBase.png")
	label = RichTextLabel.new()
	label.text = PlanetName
	label.size = Vector2(500,300)
	label.visible = false
	label.position = Vector2(radius,-radius)
	label.z_index = 100
	label.add_theme_font_size_override("normal_font_size",labelFontScale)
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(label)
	
	SysView.forceShowNamesOn.connect(forceLabelOn)
	SysView.forceShowNamesOff.connect(forceLabelOff)

func _process(_delta: float) -> void:
	label.scale = Vector2(1 / get_viewport().get_camera_2d().zoom.x, 1 / get_viewport().get_camera_2d().zoom.y) * labelScale /4
	label.add_theme_font_size_override("normal_font_size",labelFontScale)
	if forceShowLabel:
		label.visible = true
	

func update_label_position(pos : Vector2):
	label.position = pos

func update_label_scale(s : Vector2):
	labelScale = s

func get_label_size():
	var lb = label.text
	var tempscale = labelScale
	if get_label_line_count() > 1:
		tempscale.x /= get_label_line_count()
		tempscale.y *= get_label_line_count()
	return label.get_theme_font("").get_string_size(lb) * tempscale

func get_label_line_count():
	return label.get_visible_line_count()

func forceLabelOn():
	label.visible = true
	forceShowLabel = true
	pass
func forceLabelOff():
	label.visible = false
	forceShowLabel = false
	pass

func on_hover_start():
	label.visible = true
	pass

func on_hover_end():
	label.visible = false
	pass
