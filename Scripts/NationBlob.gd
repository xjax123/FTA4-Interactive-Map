@tool
extends Polygon2D

@export var Redraw : bool :
	set(value):
		Redraw = false
		queue_redraw()

@export var Affiliation : PlanetEnums.Affiliation = PlanetEnums.Affiliation.Unaligned :
	set(value):
		Affiliation = value
		claim_color = PlanetEnums.AffiliationColors[value]
		color = claim_color
		color.a = 0
		queue_redraw()

@export var OutlineWidth : int = 2 : 
	set(value):
		OutlineWidth = value
		if (outline != null):
			outline.width = value
		queue_redraw()

var claim_color
var outline

# Called when the node enters the scene tree for the first time.
func _ready():
	claim_color = PlanetEnums.AffiliationColors[Affiliation]
	color = claim_color
	self_modulate.a = 1
	color.a = 0
	outline = Line2D.new()
	add_child(outline)
	outline.points = polygon
	var lineColor = Color.WHITE
	lineColor.a = 0.7
	outline.default_color = lineColor
	outline.width = OutlineWidth
	outline.closed = true
	pass

func _process(_delta):
	self_modulate.a = 1
	queue_redraw()

func _draw():
	outline.points = polygon
	var polyColor = claim_color
	polyColor.a = 0.1
	draw_polygon(polygon,[polyColor])

