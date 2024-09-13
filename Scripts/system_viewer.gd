extends Node2D

@export var System : Resource
var ModulateColor : Color = Color(1,1,1)
var ModulateSunColor : Color = Color(1,1,1)
var center

var suns : Array[Circle2D]
var suncontainer : Node2D
var orbitals : Array[Orbital2D]
var objects : Array[StaticObject2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center = get_viewport().size/2
	position = center
	ModulateColor = System.ModulateColor
	ModulateSunColor = System.ModulateSunColor
	load_resource_to_shapes()
	queue_redraw()

func load_resource_to_shapes() -> void:
	var suntype : SysView.SystemType = System.StarType
	suncontainer = Node2D.new()
	add_child(suncontainer)
	# Loading Suns Into Circle2D
	if (suntype == 0):
		var Sun = Circle2D.new(Vector2(0,0),ModulateSunColor,false,8,0,true,1,System.StarSizes[0],System.StarColors[0])
		suncontainer.add_child(Sun)
		suns.append(Sun)
	elif (suntype == 1):
		var Sun1 = Circle2D.new(Vector2(System.StarGap,0),ModulateSunColor,true,8,2,true,1,System.StarSizes[0],System.StarColors[0],true,-1.0,true,0)
		suncontainer.add_child(Sun1)
		suns.append(Sun1)
		var Sun2 = Circle2D.new(Vector2(-System.StarGap,0),ModulateSunColor,true,8,1,true,2,System.StarSizes[1],System.StarColors[1],true,-1.0,true,180)
		suncontainer.add_child(Sun2)
		suns.append(Sun2)
	elif (suntype == 2):
		var Sun1 = Circle2D.new(Vector2(System.StarGap,-System.StarGap),ModulateSunColor,true,8,6,true,1,System.StarSizes[0],System.StarColors[0],true,-1.0,true,-45)
		suncontainer.add_child(Sun1)
		suns.append(Sun1)
		var Sun2 = Circle2D.new(Vector2(-System.StarGap,-System.StarGap),ModulateSunColor,true,8,5,true,2,System.StarSizes[1],System.StarColors[1],true,-1.0,true,-135)
		suncontainer.add_child(Sun2)
		suns.append(Sun2)
		var Sun3 = Circle2D.new(Vector2(0,System.StarGap),ModulateSunColor,true,8,3,true,4,System.StarSizes[2],System.StarColors[2],true,-1.0,true,90)
		suncontainer.add_child(Sun3)
		suns.append(Sun3)
	elif (suntype == 3):
		pass
	
	var orbitaltemp = System.Orbitals
	for orbital in orbitaltemp:
		if (orbital.filetype == "Planet"):
			var Temp = Planet2D.new(orbital.PlanetName,orbital.OrbitalOffset,ModulateColor, orbital.PlanetSize, orbital.PlanetColor, orbital.PositionAlongOrbit, orbital.Suborbitals, orbital.DistanceFromStar, orbital.OrbitalPathThickness, orbital.OrbitalPathColor, true, orbital.OrbitalSpeed, orbital.OrbitDirection)
			add_child(Temp)
			orbitals.append(Temp)
		elif(orbital.filetype == "Asteroid"):
			var Temp = AsteroidField2D.new(orbital.AsteroidAmmount, orbital.AsteroidSpawnRadius,orbital.AsteroidMinSize,orbital.AsteroidMaxSize,orbital.OrbitalOffset,ModulateColor, orbital.DistanceFromStar, orbital.OrbitalPathThickness, orbital.OrbitalPathColor, true, orbital.OrbitalSpeed, orbital.OrbitDirection)
			add_child(Temp)
			orbitals.append(Temp)
		else:
			var Temp = Orbital2D.new(orbital.OrbitalOffset,ModulateColor, orbital.DistanceFromStar, orbital.OrbitalPathThickness, orbital.OrbitalPathColor, true, orbital.OrbitalSpeed, orbital.OrbitDirection)
			add_child(Temp)
			orbitals.append(Temp)
		
	for object in System.StaticObjects:
		var Temp = StaticObject2D.new(object.ObjectName, object.ObjectDesctiption,object.CanvasTex,object.Position,object.LabelPosition,object.Size,7, 10)
		add_child(Temp)


var ani_time : float = 0
func _process(delta: float) -> void:
	ani_time += System.StarSpinSpeed*delta
	var mod = 0
	if(System.StarSpinDirection == SysView.OrbitDirection.Right):
		mod = 100
	var currentperiod = lerpf(0,1,abs(mod-ani_time)/100)
	if (currentperiod >= 1.0):
		currentperiod -= 1.0
	elif (currentperiod < 0):
		currentperiod += 1.0
	var degrees = deg_to_rad(360*currentperiod)
	for orbital in orbitals:
		orbital._progress_along_orbit(delta)
	suncontainer.rotation = degrees
	queue_redraw()

func _draw():
	for sun in suns:
		sun.queue_redraw()
		pass
	for orbital in orbitals:
		orbital.queue_redraw()
