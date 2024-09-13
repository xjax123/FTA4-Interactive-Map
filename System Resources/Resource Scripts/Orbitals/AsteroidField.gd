extends SysOrbital
class_name SysAsteroidField

@export var AsteroidAmmount : int = 500
@export var AsteroidSpawnRadius : float = 10
@export var AsteroidMinSize : float = 1
@export var AsteroidMaxSize : float = 4

func _init(ammount : int = 500, spawnradius : float = 10, minsize : float = 1, maxsize : float = 4, orbitaloffset : Vector2 = Vector2(0,0), pathcol : Color = Color(1,1,1), width : float = 3.0, distance : Vector2 = Vector2(100,100), speed : float = 1, direction : SysView.OrbitDirection = SysView.OrbitDirection.Left):
	super._init(orbitaloffset,pathcol,width,distance,speed,direction)
	filetype = "Asteroid"
	AsteroidAmmount = ammount
	AsteroidSpawnRadius = spawnradius
	AsteroidMinSize = minsize
	AsteroidMaxSize = maxsize
