@tool
extends Node2D

enum LineStyle {
	Solid,
	Dashed,
	Dotted
}

@export var Visible : bool = true:
	set(value):
		Visible = value
		queue_redraw()
@export var Broken : bool = false:
	set(value):
		Broken = value
		queue_redraw()
@export var PlanetA : Planet:
	set(value):
		PlanetA = value
		queue_redraw()
@export var PlanetB : Planet:
	set(value):
		PlanetB = value
		queue_redraw()

@export_category("Colors")
@export var ColorOverride : bool = false:
	set(value):
		ColorOverride = value
		queue_redraw()
@export var ConnectionColorAOverride : Color = Color.WHITE:
	set(value):
		ConnectionColorAOverride = value
		queue_redraw()
@export var ConnectionColorBOverride : Color = Color.WHITE:
	set(value):
		ConnectionColorBOverride = value
		queue_redraw()
@export var Style : LineStyle = LineStyle.Solid:
	set(value):
		Style = value
		queue_redraw()
@export var ConnectionThickness : float = 2.5:
	set(value):
		ConnectionThickness = value
		queue_redraw()

var ConnectionLine : AntialiasedLine2D
var BrokenLine : AntialiasedLine2D
var ColorGradient : Gradient
var BrokenGradient : Gradient
var ConnectionColorA : Color
var ConnectionColorB : Color

func _init():
	z_index = -1
	ConnectionLine = AntialiasedLine2D.new()
	ColorGradient = Gradient.new()
	BrokenLine = AntialiasedLine2D.new()
	BrokenGradient = Gradient.new()
	BrokenLine.gradient = BrokenGradient
	BrokenLine.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
	BrokenLine.antialiased = true
	ConnectionLine.gradient = ColorGradient
	ConnectionLine.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
	ConnectionLine.antialiased = true
	add_child(ConnectionLine)
	add_child(BrokenLine)

func _ready() -> void:
	queue_redraw()

var lastposA : Vector2
var lastposB : Vector2
var visA : bool
var visB : bool
var expectedalignA : PlanetEnums.Affiliation
var expectedalignB : PlanetEnums.Affiliation
func _process(delta: float) -> void:
	if(!visible):
		return
	if (PlanetA == null || PlanetB == null):
		return
	if(PlanetA.position != lastposA):
		queue_redraw()
	if(PlanetB.position != lastposB):
		queue_redraw()	
	if(PlanetA.Visible != visA):
		queue_redraw()
	if(PlanetB.Visible != visB):
		queue_redraw()	
	if(PlanetA.Affiliation != expectedalignA):
		queue_redraw()
	if(PlanetB.Affiliation != expectedalignB):
		queue_redraw()
	lastposA = PlanetA.position
	lastposB = PlanetB.position
	expectedalignA = PlanetA.Affiliation
	expectedalignB = PlanetB.Affiliation
	visA = PlanetA.Visible
	visB = PlanetB.Visible


func _draw() -> void:
	if(!visible):
		return
	if (PlanetA == null || PlanetB == null):
		return
	if(ColorOverride):
		ConnectionColorA = ConnectionColorAOverride
		ConnectionColorB = ConnectionColorBOverride
	else:
		ConnectionColorA = PlanetEnums.AffiliationColors[PlanetA.Affiliation]
		ConnectionColorB = PlanetEnums.AffiliationColors[PlanetB.Affiliation]
	
	var HiddenColorA : Color = ConnectionColorA
	var HiddenColorB : Color = ConnectionColorB
	
	if Engine.is_editor_hint():
		HiddenColorA.a = 0.25
		HiddenColorB.a = 0.25
	else:
		HiddenColorA.a = 0
		HiddenColorB.a = 0
	
	if(Style == LineStyle.Solid):
		ConnectionLine.texture = preload("res://Textures/Line Textures/Solid.tres")
		BrokenLine.texture = preload("res://Textures/Line Textures/Solid.tres")
		ConnectionLine.texture_mode = Line2D.LINE_TEXTURE_TILE
		BrokenLine.texture_mode = Line2D.LINE_TEXTURE_TILE
		BrokenLine.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
		ConnectionLine.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
	elif(Style == LineStyle.Dashed):
		ConnectionLine.texture = preload("res://Textures/Line Textures/Dash.png")
		BrokenLine.texture = preload("res://Textures/Line Textures/Dash.png")
		ConnectionLine.texture_mode = Line2D.LINE_TEXTURE_TILE
		BrokenLine.texture_mode = Line2D.LINE_TEXTURE_TILE
		BrokenLine.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
		ConnectionLine.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
	elif(Style == LineStyle.Dotted):
		ConnectionLine.texture = preload("res://Textures/Line Textures/Dot.png")
		BrokenLine.texture = preload("res://Textures/Line Textures/Dot.png")
		ConnectionLine.texture_mode = Line2D.LINE_TEXTURE_TILE
		BrokenLine.texture_mode = Line2D.LINE_TEXTURE_TILE
		BrokenLine.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
		ConnectionLine.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
		
	if (!Broken):
		if (PlanetA != null && PlanetB != null):
			var pos1 = PlanetA.global_position
			var pos2 = PlanetB.global_position
			var diff = pos1-pos2
			diff /= 2
			global_position = pos2+diff
			ConnectionLine.clear_points()
			BrokenLine.clear_points()
			ConnectionLine.add_point(PlanetA.position-global_position,1)
			ConnectionLine.add_point(PlanetB.position-global_position,2)
			if(PlanetA.Visible):
				ColorGradient.set_color(0,ConnectionColorA)
			else:
				ColorGradient.set_color(0,HiddenColorA)
			if(PlanetB.Visible):
				ColorGradient.set_color(1,ConnectionColorB)
			else:
				ColorGradient.set_color(1,HiddenColorB)
		if (!Visible):
			ColorGradient.set_colors(PackedColorArray([HiddenColorA,HiddenColorB]))
		ConnectionLine.gradient = ColorGradient
	else:
		var posa1 = PlanetA.global_position
		var posa2 = lerp(PlanetA.position,PlanetB.position,0.4)
		var posb1 = PlanetB.global_position
		var posb2 = lerp(PlanetB.position,PlanetA.position,0.4)
		var diff = posa1-posb1
		diff /= 2
		global_position = posb1+diff
	
		ConnectionLine.clear_points()
		ConnectionLine.add_point(PlanetA.position-global_position,0)
		ConnectionLine.add_point(posa2-global_position,1)
		BrokenLine.clear_points()
		BrokenLine.add_point(PlanetB.position-global_position,0)
		BrokenLine.add_point(posb2-global_position,1)
		if(PlanetA.Visible):
			ColorGradient.set_color(0,ConnectionColorA)
			ColorGradient.set_color(1,HiddenColorA)
		else:
			ColorGradient.set_color(0,HiddenColorA)
			ColorGradient.set_color(1,HiddenColorA)
		if(PlanetB.Visible):
			BrokenGradient.set_color(0,ConnectionColorB)
			BrokenGradient.set_color(1,HiddenColorB)
		else:
			BrokenGradient.set_color(0,HiddenColorB)
			BrokenGradient.set_color(1,HiddenColorB)
		if(!Visible):
			ColorGradient.set_color(0,HiddenColorA)
			ColorGradient.set_color(1,HiddenColorA)
			BrokenGradient.set_color(0,HiddenColorB)
			BrokenGradient.set_color(1,HiddenColorB)
	
	ConnectionLine.width = ConnectionThickness
	BrokenLine.width = ConnectionThickness
