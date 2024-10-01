extends Node2D
class_name Circle2D

@export var radius : float : 
	set(value):
		radius = value
		queue_redraw()
@export var color : Color : 
	set(value):
		color = value
		queue_redraw()
@export var filled : bool : 
	set(value):
		filled = value
		queue_redraw()
@export var width : float : 
	set(value):
		width = value
		queue_redraw()
@export var antialliased : bool : 
	set(value):
		antialliased = value
		queue_redraw()
@export var occludermask : int :
	set(value):
		occludermask = value
		queue_redraw()
@export var lightcullmask : int :
	set(value):
		lightcullmask = value
		queue_redraw()
@export var lightmask : int :
	set(value):
		lightmask = value
		queue_redraw()
@export var occluderoffset : float :
	set(value):
		occluderoffset = value
		queue_redraw()
		
var sprite : Sprite2D
var occluder : LightOccluder2D
var occluderradius : float
var light : PointLight2D
var isoccluder : bool
var islight : bool
var modulatecol : Color
var TouchArea : Area2D
var visual : Polygon2D

func _init(_position : Vector2,modulatecolor : Color = Color(1,1,1),_occluder : bool = false, _lightmask : int = 1, _occludermask : int = 32, lightsource : bool = false, _lightcullmask : int = 32, _radius : float = 5,_color : Color = Color(1,1,1),_filled : bool = true,_width : float = -1.0,_antialliased : bool = true,_occluderoffset : float = 0) -> void:
	position = _position
	radius = _radius
	occluderradius = _radius
	color = _color
	filled = _filled
	width = _width
	antialliased = _antialliased
	isoccluder = _occluder
	modulatecol = modulatecolor
	islight = lightsource
	occludermask = _occludermask
	lightcullmask = _lightcullmask
	lightmask = lightmask
	occluderoffset = _occluderoffset

func _ready() -> void:
	light_mask = lightmask
	if (!islight):
		sprite = Sprite2D.new()
		var canvas = CanvasTexture.new()
		canvas.diffuse_texture = preload("res://Textures/Planet Textures/BlankPlanetBase.png")
		canvas.normal_texture = preload("res://Textures/Planet Textures/PlanetNormal.jpg")
		canvas.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
		sprite.texture = canvas
		sprite.self_modulate = color
		sprite.modulate = modulatecol
		sprite.scale = Vector2(radius/5.0*0.02,radius/5.0*0.02)
		add_child(sprite)
	if (isoccluder):
		if (occluderradius != 0):
			occluder = LightOccluder2D.new()
			var poly : OccluderPolygon2D = OccluderPolygon2D.new()
			var vec : PackedVector2Array = []
			var x = 0
			while (x < 180):
				var deg = deg_to_rad(x)
				vec.append(Vector2(occluderradius*sin(deg),occluderradius*cos(deg)))
				x += 1
			poly.polygon = vec
			poly.closed = false
			occluder.occluder = poly
			occluder.occluder_light_mask = occludermask
			occluder.rotate(deg_to_rad(occluderoffset))
			self_modulate = modulatecol
			#visual = Polygon2D.new()
			#visual.polygon = vec
			#visual.rotate(deg_to_rad(occluderoffset))
			#add_child(visual)
			add_child(occluder)
	if (islight):
		var modcolor = Color(1,1,1)
		modcolor = modcolor.lerp(color,0.5)
		var shadowcolor = Color(0,0,0)
		shadowcolor = shadowcolor.lerp(color, 0.5)
		light = PointLight2D.new()
		light.texture = preload("res://Textures/Light Textures/2d_lights_and_shadows_neutral_point_light.webp")
		light.energy = radius/5
		light.color = modcolor
		light.shadow_item_cull_mask = lightcullmask
		#uncomment to debug where shadows land
		#light.shadow_color = shadowcolor
		light.blend_mode = Light2D.BLEND_MODE_MIX
		light.shadow_filter = Light2D.SHADOW_FILTER_PCF13
		light.shadow_filter_smooth = 2
		light.range_layer_max = 1
		light.range_layer_min = 1
		light.shadow_enabled = true
		light.scale = Vector2(100,100)
		add_child(light)
		
		
		sprite = Sprite2D.new()
		var canvas = CanvasTexture.new()
		canvas.diffuse_texture = preload("res://Textures/Planet Textures/SunBase.png")
		canvas.normal_texture = preload("res://Textures/Planet Textures/PlanetNormal.jpg")
		canvas.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
		sprite.texture = canvas
		sprite.self_modulate = color
		sprite.light_mask = lightmask
		sprite.scale = Vector2(radius/5.0*0.02,radius/5.0*0.02)
		add_child(sprite)
	
	TouchArea = Area2D.new()
	var Shape = CollisionShape2D.new()
	var circ = CircleShape2D.new()
	if (radius+10 > radius*2):
		circ.radius = radius*2
	else:
		circ.radius = radius+10
	Shape.shape = circ
	TouchArea.add_child(Shape)
	add_child(TouchArea)
	TouchArea.connect("mouse_entered", on_hover_start)
	TouchArea.connect("mouse_exited", on_hover_end)
	TouchArea.connect("input_event", mouse_click)

func _process(_delta: float) -> void:
	pass

func update_occluder(radians):
	if (occluderradius != 0 && isoccluder):
		occluder.global_rotation = radians+deg_to_rad(180)+deg_to_rad(occluderoffset)
		#visual.rotation = radians+deg_to_rad(180)+deg_to_rad(occluderoffset)

func on_hover_start():
	pass

func on_hover_end():
	pass

func mouse_click(_viewport : Node, _event: InputEvent, _shape_idx : int):
	pass

func _draw() -> void:
	pass
