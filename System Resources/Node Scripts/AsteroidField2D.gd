extends Orbital2D
class_name AsteroidField2D

var timemod : float = 1000

@export var AsteroidAmmount : float = 500
@export var AsteroidSpawnRadiusLM : float = 10
var AsteroidSpawnRadius : float
@export var AsteroidMinSize : float = 1
@export var AsteroidMaxSize : float = 4

var Asteroids : Array[Asteroid2D] = []
var degrees
func _init(bufferdist : float, ammount : int = 500, spawnradius : float = 10, minsize : float = 1, maxsize : float = 4, pos : Vector2 = Vector2(0,0), modulatecolor : Color = Color(1,1,1), distance : Vector2 = Vector2(0,0), pathwidth : float = 3.0, pathcolor : Color = Color(1,1,1), antialiased : bool = true, speed : float = 1, direction : SysView.OrbitDirection = SysView.OrbitDirection.Left):
	super._init(bufferdist, pos,modulatecolor,distance,pathwidth,pathcolor,antialiased,speed,direction)
	AsteroidAmmount = round(ammount)
	AsteroidSpawnRadiusLM = spawnradius
	AsteroidSpawnRadius = AsteroidSpawnRadiusLM*24
	AsteroidMinSize = minsize
	AsteroidMaxSize = maxsize
	timemod = SysView.globaltimemod

func _ready() -> void:
	super._ready()
	var x = 0
	var increment = 360.0/AsteroidAmmount
	var Rand = RandomNumberGenerator.new()
	while (x < AsteroidAmmount):
		degrees = deg_to_rad(increment*x)
		var randomval = Rand.randfn(0.0,AsteroidSpawnRadius)
		var ModOrbx = OrbitalDistance.x+randomval
		var ModOrby = OrbitalDistance.y+randomval
		var px = (ModOrbx*ModOrby) / sqrt(pow(ModOrby,2)+pow(ModOrbx,2)*pow(tan(degrees),2))
		if( (PI * 0.5) < degrees && (3 * (PI * 0.5))+deg_to_rad(1) > degrees ):
			px = abs(px)
		else:
			px = -abs(px)
		var py = px * tan(degrees)
		var currentpos = Vector2(px,py)
		var assize = Rand.randf_range(AsteroidMinSize,AsteroidMaxSize)
		var asteroid = Asteroid2D.new((increment*x)/360,Vector2(ModOrbx,ModOrby),currentpos,ModulateColor,true,7,7,false,0,assize,Color(0.4,0.4,0.4),true,-1.0,true)
		add_child(asteroid)
		Asteroids.append(asteroid)
		x+=1
		
var ani_time : float = 0
func _progress_along_orbit(delta):
	ani_time += OrbitalSpeed*delta
	for asteroid in Asteroids:
		var mod = 0
		if(OrbitDirection == SysView.OrbitDirection.Right):
			mod = timemod
		var currentperiod = lerpf(0,1,abs(mod-ani_time)/timemod) + asteroid.startingposition
		if (currentperiod >= 1.0):
			currentperiod -= 1.0
		elif (currentperiod < 0):
			currentperiod += 1.0
		degrees = deg_to_rad(360*currentperiod)
		var px = (asteroid.orbit.x*asteroid.orbit.y) / sqrt(pow(asteroid.orbit.y,2)+pow(asteroid.orbit.x,2)*pow(tan(degrees),2))
		if( (PI * 0.5) < degrees && (3 * (PI * 0.5)) > degrees ):
			px = abs(px)
		else:
			px = -abs(px)
		var py = px * tan(degrees)
		var currentposonpath = Vector2(px,py)
		asteroid.position = currentposonpath
		asteroid.update_occluder(degrees)
	if (ani_time >= timemod):
		ani_time = 0

func _draw() -> void:
	super._draw()
	for asteroid in Asteroids:
		asteroid.queue_redraw()
