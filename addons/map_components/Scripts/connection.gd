@tool
extends Node2D

@export var Visible : bool = true

@export var PlanetA : Planet :
	set(value):
		PlanetA = value
		updateLine()

@export var PlanetB : Planet : 
	set(value):
		PlanetB = value
		updateLine()

@export var ConnectionColor : Color = Color.WHITE :
	set(value):
		ConnectionColor = value
		updateLine()

@export var ConnectionThickness : float = 2.5 : 
	set(value):
		ConnectionThickness = value
		updateLine()

var ConnectionLine : Line2D
var ColorGradient : Gradient
func _init():
	z_index = -1
	ConnectionLine = Line2D.new()
	ColorGradient = Gradient.new()
	ConnectionLine.gradient = ColorGradient
	ConnectionLine.antialiased = true
	add_child(ConnectionLine)

func _process(delta):
	var HiddenColor : Color = ConnectionColor
	if Engine.is_editor_hint():
		HiddenColor.a = 0.25
	else:
		HiddenColor.a = 0
	if (PlanetA != null && PlanetB != null):
		var pos1 = PlanetA.global_position
		var pos2 = PlanetB.global_position
		var diff = pos1-pos2
		diff /= 2
		global_position = pos2+diff
		ConnectionLine.clear_points()
		ConnectionLine.add_point(PlanetA.position-global_position,1)
		ConnectionLine.add_point(PlanetB.position-global_position,2)
		if(PlanetA.Visible):
			ColorGradient.set_color(0,ConnectionColor)
		if(!PlanetA.Visible):
			ColorGradient.set_color(0,HiddenColor)
		if(PlanetB.Visible):
			ColorGradient.set_color(1,ConnectionColor)
		if(!PlanetB.Visible):
			ColorGradient.set_color(1,HiddenColor)
	if (!Visible):
		ColorGradient.set_colors(PackedColorArray([HiddenColor,HiddenColor]))
	ConnectionLine.gradient = ColorGradient

func updateLine():
	ColorGradient.set_colors(PackedColorArray([ConnectionColor,ConnectionColor]))
	ConnectionLine.width = ConnectionThickness
