extends ColorRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position = get_viewport().get_camera_2d().position-size/2
	pass
