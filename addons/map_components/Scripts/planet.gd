@tool
extends Node2D

class_name Planet
# Exports
@export var Visible : bool = true :
	set(value):
		Visible = value
		queue_redraw() 

@export var Redraw : bool:
	set(value):
		Redraw = false
		queue_redraw()

@export_category("Properties")
@export var PlanetTheme : Theme = load("res://Themes/Planets.tres") :
	set(value):
		PlanetTheme = value
		queue_redraw()

@export var OutlineResolution : int = 40 :
	set(value):
		OutlineResolution = value
		queue_redraw()

@export var Name : String = "DefaultName" :
	set(value):
		Name = value
		queue_redraw()

@export var NameSize : int = 14 :
	set(value):
		NameSize = value
		queue_redraw()

@export var NameColor : Color = Color.WHITE :
	set(value):
		NameColor = value
		queue_redraw()

@export var NameOffset : Vector2 = Vector2(-110,-10):
	set(value):
		NameOffset = value
		queue_redraw()

@export_category("Colors")
@export var PlanetColor : Color = Color.BLACK:
	set(value):
		PlanetColor = value
		queue_redraw()

@export var Affiliation : PlanetEnums.Affiliation = PlanetEnums.Affiliation.Unaligned :
	set(value):
		Affiliation = value
		queue_redraw()

@export_category("Sizes")
@export var Size : int = 10:
	set(value):
		Size = value
		queue_redraw()

@export var OutlineThickness : float = 0.75:
	set(value):
		OutlineThickness = value
		queue_redraw()

@export_category("Resource Exports")
@export var SystemDescription : Resource

#@onready var GUI : CanvasLayer = get_parent().GUI
var ClickArea : Area2D

func _ready():
	if(Engine.is_editor_hint()):
		ClickArea = Area2D.new()
		var ColObject = CollisionShape2D.new()
		var Shape = CircleShape2D.new()
		Shape.radius = Size+OutlineThickness
		add_child(ClickArea)
		ColObject.set_shape(Shape)
		ClickArea.add_child(ColObject)
		ClickArea.connect("input_event",_on_area_2d_input_event)
	pass

func _draw():
	if(Visible) :
		draw_circle(Vector2(0,0), Size, PlanetColor)
		draw_arc(Vector2(0,0), Size, 0, deg_to_rad(360), 40, PlanetEnums.AffiliationColors[Affiliation], OutlineThickness, true)
		draw_string(PlanetTheme.get_font("",""),NameOffset,Name,HORIZONTAL_ALIGNMENT_CENTER,160,NameSize,NameColor)
	if(!Visible && Engine.is_editor_hint()):
		var alteredplanetcolor : Color = PlanetColor
		alteredplanetcolor.a = 0.25
		var alteredaffiliationcolor : Color = PlanetEnums.AffiliationColors[Affiliation]
		alteredaffiliationcolor.a = 0.25
		var alteredtextcolor : Color = NameColor
		alteredtextcolor.a = 0.25
		draw_circle(Vector2(0,0), Size, alteredplanetcolor)
		draw_arc(Vector2(0,0), Size, 0, deg_to_rad(360), 40, alteredaffiliationcolor, OutlineThickness, true)
		draw_string(PlanetTheme.get_font("",""),NameOffset,Name,HORIZONTAL_ALIGNMENT_CENTER,160,NameSize,alteredtextcolor)


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("interact"):
		#GUI.SelectedPlanet = self
		pass
	pass
