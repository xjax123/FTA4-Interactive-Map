extends Node2D

enum ViewMode {
	TGrid,
	HGrid,
	System
}

@export var MainCamera : Camera2D
@export var SCCamera : Camera2D
var view : ViewMode = ViewMode.HGrid

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Main Camera".make_current()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _unhandled_input(event):
	if(event.is_action_pressed("Switch Mode")):
		if ($"System Viewer".visible == false):
			$"System Viewer".visible = true
			$"System Viewer/System Camera".make_current()
			$"System Viewer/System Camera".position = $"System Viewer/System Camera".starting_position
			$"System Viewer/System Camera".zoom_level = 1
			$"System Viewer/System Camera".zoom = Vector2(1, 1)
			view = ViewMode.System
		else:
			$"System Viewer".visible = false
			$"Main Camera".make_current()
			view = ViewMode.HGrid
