extends CanvasLayer

@export var main_map : map_view

var line : AntialiasedLine2D = AntialiasedLine2D.new()
var text : Label = Label.new()
func _ready() -> void:
	line.add_point(Vector2(0,0),0)
	line.add_point(Vector2(0,0),1)
	line.default_color = Color.RED
	line.width = 3
	text.theme = Theme.new()
	text.add_theme_color_override("",Color.WHITE)
	text.add_theme_font_size_override("font_size",80)
	text.scale = Vector2(0.25,0.25)
	text.text = "Testing"
	add_child(line)
	$"System Camera".add_child(text)
	line.visible = false
	text.visible = false

func load_scene(manifest : SysManifest) -> void:
	if(manifest == null):
		return
	$"System Viewer".System = manifest
	$"System Camera".make_current()
	$"System Camera".position = $"System Camera".starting_position
	$"System Camera".zoom_level = 1
	$"System Camera".zoom = Vector2(1, 1)
	main_map.view = main_map.ViewMode.System
	$"System Viewer"._ready()
	visible = true
	pass

var anchorPos : Vector2 = Vector2(0,0)
var dragging : bool
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		anchorPos = get_viewport().get_camera_2d().get_global_mouse_position()
		line.set_point_position(0,anchorPos)
		line.visible = true
		text.visible = true
		dragging = true
	
	if event.is_action_released("interact"):
		line.visible = false
		text.visible = false
		dragging = false

func _process(_delta: float) -> void:
	if dragging == true:
		var mouspos = get_viewport().get_camera_2d().get_global_mouse_position()
		var dist = sqrt(pow(anchorPos.x-mouspos.x,2)+pow(anchorPos.y-mouspos.y,2))
		var distLM = dist/24
		dist *= 0.5
		var textpos = mouspos
		textpos.x -= dist
		textpos.y -= dist
		line.width = 1 / get_viewport().get_camera_2d().zoom.x * 4
		text.text = str(roundf(distLM)) + "lm"
		text.scale = Vector2(1 / get_viewport().get_camera_2d().zoom.x, 1 / get_viewport().get_camera_2d().zoom.y)
		text.global_position = mouspos
		line.set_point_position(1, mouspos)
		
