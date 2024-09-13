extends Camera2D

@export var min_zoom := 0.1
@export var max_zoom := 5.0
@export var zoom_factor := 0.1
@export var zoom_duration := 0.2
@export var starting_zoom := 0.8
var starting_position
var zoom_level: float = 1
var position_before_drag
var position_before_drag2


func _ready():
	starting_position = position
	zoom_level = starting_zoom
	zoom = Vector2(zoom_level,zoom_level)
	pass


func _unhandled_input(event) -> void:
	if(!self.is_current()):
		return
	elif event.is_action_pressed("zoom_in"):
		set_zoom_level(zoom_level + zoom_factor)
	elif event.is_action_pressed("zoom_out"):
		set_zoom_level(zoom_level - zoom_factor)
	elif event.is_action_pressed("camera_drag"):
		position_before_drag = event.position
		position_before_drag2 = self.position
	elif event.is_action_released("camera_drag"):
		position_before_drag = null
	
	if position_before_drag and event is InputEventMouseMotion:
		self.position = position_before_drag2 + (position_before_drag - event.position) * (1/zoom_level)


func set_zoom_level(level: float, mouse_world_position = self.get_global_mouse_position()):
	var old_zoom_level = zoom_level
	
	zoom_level = clampf(level, min_zoom, max_zoom)
	
	var direction = (mouse_world_position - self.position)
	var new_position = self.position + direction - ((direction) / (zoom_level/old_zoom_level))
	
	self.zoom = Vector2(zoom_level, zoom_level)
	self.position = new_position
