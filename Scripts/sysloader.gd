extends CanvasLayer

@export var main_map : map_view

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
