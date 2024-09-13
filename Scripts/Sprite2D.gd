extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_voronoi_diagram(Vector2(1920,1080),500)

func generate_voronoi_diagram(imgSize : Vector2, num_cells: int):
	
	var img = Image.new()
	img.create(imgSize.x, imgSize.y, false, Image.FORMAT_RGBH)
	
	var points = []
	for planet in get_node("../Planets").get_children() :
		points.append(planet.position)
	var colors = []
	for planet in get_node("../Planets").get_children() :
		colors.append(PlanetEnums.AffiliationColors[planet.Affiliation])
	
	for i in range(num_cells):
		points.push_back(Vector2(int(randf()*img.get_size().x), int(randf()*img.get_size().y)))
		
		randomize()
		var colorPossibilities = [ Color.BLUE, Color.RED, Color.GREEN, Color.PURPLE, Color.YELLOW, Color.ORANGE]
		colors.push_back(colorPossibilities[randi()%colorPossibilities.size()])
		
	for y in range(img.get_size().y):
		for x in range(img.get_size().x):
			var dmin = img.get_size().length()
			var j = -1
			for i in range(num_cells):
				var d = (points[i] - Vector2(x, y)).length()
				if d < dmin:
					dmin = d
					j = i
			img.lock()
			img.set_pixel(x, y, colors[j])
			img.unlock()
	
	var texture = ImageTexture.new()
	texture.create_from_image(img)
	self.set_texture(texture)
