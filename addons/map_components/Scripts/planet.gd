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

@export var OutlineResolution : int = 30 :
	set(value):
		OutlineResolution = value
		queue_redraw()

@export var Name : String = "DefaultName" :
	set(value):
		Name = value
		if(nameLabel != null):
			nameLabel.text = value
		queue_redraw()

@export var NameSize : int = 14 :
	set(value):
		NameSize = value
		if(nameLabel != null):
			nameLabel.add_theme_font_size_override("font_size",value*4)
			nameLabel.scale = Vector2(0.25,0.25)
		queue_redraw()

@export var NameColor : Color = Color.WHITE :
	set(value):
		NameColor = value
		queue_redraw()

@export var DrawCutoff : float = 1.2:
	set(value):
		DrawCutoff = value
		queue_redraw()

@export var FullCutoff : float = 0.3:
	set(value):
		FullCutoff = value
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
		
@export_category("Visible Information")
@export var OutlineInfo : OutlineR = OutlineR.new():
	set(value):
		OutlineInfo = value
		OutlineInfo.connect("changed",rss_changed)
		queue_redraw()

@export_category("Resource Exports")
@export var SystemManifest : SysManifest

@onready var Viewer : CanvasLayer = get_parent().Viewer
var ClickArea : Area2D
var nameLabel : Label
var subtitle : Label
var outline : AntialiasedLine2D
var outlinebacking : AntialiasedLine2D

func _ready():
	if(!Engine.is_editor_hint()):
		ClickArea = Area2D.new()
		var ColObject = CollisionShape2D.new()
		var Shape = CircleShape2D.new()
		Shape.radius = Size+OutlineInfo.width
		add_child(ClickArea)
		ColObject.set_shape(Shape)
		ClickArea.add_child(ColObject)
		ClickArea.connect("input_event",_on_area_2d_input_event)
		
	var isin = false
	for child in get_children():
		if child.name == "NameLabel":
			nameLabel = child
			isin = true
		if child.name == "Subtitle":
			subtitle = child
	if !isin:
		nameLabel = Label.new()
		add_child(nameLabel)
		nameLabel.name = "NameLabel"
		nameLabel.set_owner(get_tree().get_edited_scene_root())
		nameLabel.text = Name
		nameLabel.theme = PlanetTheme
		nameLabel.add_theme_color_override("theme_color",NameColor)
		nameLabel.add_theme_font_size_override("font_size",NameSize*4)
		nameLabel.scale = Vector2(0.25,0.25)
	nameLabel.visible = Visible
	
	var x = 0
	var path : PackedVector2Array
	while (x < OutlineResolution+1):
		var rad = deg_to_rad(x*(360/OutlineResolution))
		var currentposonpath = Vector2(Size*cos(rad),Size*sin(rad))
		path.append(currentposonpath)
		x +=1
	outline = AntialiasedLine2D.new()
	outline.points = path
	outline.closed = true
	outline.width = OutlineInfo.width
	outline.texture = OutlineInfo.Tex
	outline.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
	outline.default_color = PlanetEnums.AffiliationColors[Affiliation]
	outline.z_index = 2
	outline.antialiased = true
	add_child(outline)
	outlinebacking = AntialiasedLine2D.new()
	outlinebacking.points = path
	outlinebacking.closed = true
	outlinebacking.width = OutlineInfo.width
	outlinebacking.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
	outlinebacking.default_color = OutlineInfo.BackingColor
	outlinebacking.z_index = 1
	outlinebacking.antialiased = true
	add_child(outlinebacking)
	if(OutlineInfo.backed):	
		outlinebacking.visible = true
		if(OutlineInfo.reversed):
			outlinebacking.default_color = PlanetEnums.AffiliationColors[Affiliation]
			outline.default_color = OutlineInfo.BackingColor
	else:
		outlinebacking.visible = false

func _process(delta: float) -> void:
	
	if(!Engine.is_editor_hint()):
		var cam = get_viewport().get_camera_2d()
		if(cam.zoom.x < FullCutoff):
			visible = false
		else:
			visible = true
		if(cam.zoom.x < DrawCutoff):
			nameLabel.visible = false
			if(subtitle != null):
				subtitle.visible = false
		else:
			nameLabel.visible = Visible
			if(subtitle != null):
				subtitle.visible = Visible

func _draw():	
	if(!visible):
		return
	if(Visible) :
		draw_circle(Vector2(0,0), Size, PlanetColor)
		nameLabel.visible = Visible
		nameLabel.modulate = Color(1,1,1)
		if(subtitle != null):
			subtitle.visible = Visible
			subtitle.modulate = Color(1,1,1)
		var x = 0
		var path : PackedVector2Array
		while (x < OutlineResolution+1):
			var rad = deg_to_rad(x*(360/OutlineResolution))
			var currentposonpath = Vector2(Size*cos(rad),Size*sin(rad))
			path.append(currentposonpath)
			x +=1
		outline.points = path
		outline.width = OutlineInfo.width
		outline.texture = OutlineInfo.Tex
		outline.default_color = PlanetEnums.AffiliationColors[Affiliation]
		if(OutlineInfo.backed):	
			outlinebacking.visible = true
			outlinebacking.points = path
			outlinebacking.width = OutlineInfo.width
			outlinebacking.default_color = OutlineInfo.BackingColor
			if(OutlineInfo.reversed):
				outlinebacking.default_color = PlanetEnums.AffiliationColors[Affiliation]
				outline.default_color = OutlineInfo.BackingColor
		else:
			outlinebacking.visible = false
	else:
		nameLabel.visible = Visible
		if(subtitle != null):
			subtitle.visible = Visible
	if(!Visible && Engine.is_editor_hint()):
		var alteredplanetcolor : Color = PlanetColor
		alteredplanetcolor.a = 0.25
		var alteredaffiliationcolor : Color = PlanetEnums.AffiliationColors[Affiliation]
		alteredaffiliationcolor.a = 0.25
		var alteredtextcolor : Color = NameColor
		alteredtextcolor.a = 0.25
		draw_circle(Vector2(0,0), Size, alteredplanetcolor)
		var alteredoutlinecolor : Color = PlanetEnums.AffiliationColors[Affiliation]
		alteredoutlinecolor.a = 0.25
		var x = 0
		var path : PackedVector2Array
		while (x < OutlineResolution+1):
			var rad = deg_to_rad(x*(360/OutlineResolution))
			var currentposonpath = Vector2(Size*cos(rad),Size*sin(rad))
			path.append(currentposonpath)
			x +=1
		outline.points = path
		outline.width = OutlineInfo.width
		outline.texture = OutlineInfo.Tex
		outline.default_color = alteredoutlinecolor	
		if(OutlineInfo.backed):	
			outlinebacking.visible = true
			var alteredbackingcolor : Color = OutlineInfo.BackingColor
			alteredbackingcolor.a = 0.25
			outlinebacking.points = path
			outlinebacking.width = OutlineInfo.width
			outlinebacking.default_color = alteredbackingcolor
			if(OutlineInfo.reversed):
				outlinebacking.default_color = alteredoutlinecolor
				outline.default_color = alteredbackingcolor
		else:
			outlinebacking.visible = false
		nameLabel.modulate = alteredtextcolor
		nameLabel.visible = true
		if(subtitle != null):
			subtitle.visible = true
			subtitle.modulate = alteredtextcolor

func rss_changed():
	queue_redraw()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("interact"):
		Viewer.load_scene(SystemManifest)
		pass
	pass
