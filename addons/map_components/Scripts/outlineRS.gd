@tool
extends Resource
class_name OutlineR

@export var Tex : Texture = preload("res://Textures/Line Textures/Solid.tres"):
	set(value):
		Tex = value
		emit_changed()
@export var width : float = 2:
	set(value):
		width = value
		emit_changed()
@export var backed : bool = false:
	set(value):
		backed = value
		emit_changed()
@export var BackingColor : Color = Color(1,1,1,1):
	set(value):
		BackingColor = value
		emit_changed()
@export var reversed : bool = false:
	set(value):
		reversed = value
		emit_changed()
