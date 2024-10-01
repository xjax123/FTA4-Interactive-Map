extends Line2D


var cam : Camera2D

func _ready() -> void:
	cam = get_viewport().get_camera_2d()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(cam.zoom_level < 0.8):
		visible = true
		var opacity  = lerpf(1,0,cam.zoom_level)
		modulate.a = opacity
		$Label.modulate.a = opacity
		
	else:
		visible = false
