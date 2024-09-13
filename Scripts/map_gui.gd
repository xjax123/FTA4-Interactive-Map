extends CanvasLayer

var SelectedPlanet : Planet :
	set(value):
		changeSelected(value)
		SelectedPlanet = value

# UI Elements
@onready var container = $"Info Container"
@onready var PlnInfo = $"Info Container/Planet Info"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func changeSelected(value : Planet):
	if(container.get_current_tab_control() == PlnInfo):
		for n in PlnInfo.get_children():
			PlnInfo.remove_child(n)
			n.queue_free()
		var SystemName : Label = Label.new()
		SystemName.set_text(value.name)
		SystemName.scale = Vector2(2,2)
		SystemName.set("theme_override_font_sizes/font_size", 28)
		SystemName.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		PlnInfo.add_child(SystemName)
		var SysDesc : Label = Label.new()
		SysDesc.set_text(value.SystemDescription.SystemDescription)
		SysDesc.set("theme_override_font_sizes/font_size", 14)
		SysDesc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		PlnInfo.add_child(SysDesc)
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
