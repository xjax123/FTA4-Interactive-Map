@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("Planet", "Node2D", preload("res://addons/map_components/Scripts/planet.gd"), preload("res://addons/map_components/Icons/planet_icon.png"))
	add_custom_type("Connection", "Node2D", preload("res://addons/map_components/Scripts/connection.gd"), preload("res://addons/map_components/Icons/connection_icon.png"))


func _exit_tree():
	remove_custom_type("Planet")
	remove_custom_type("Connection")
