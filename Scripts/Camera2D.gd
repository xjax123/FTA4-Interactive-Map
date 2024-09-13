extends Camera2D

@export var ScreenshotArea : ReferenceRect

# Called when the node enters the scene tree for the first time.
func _ready():
	var size = get_viewport_rect()
	var ScreenshotRect = ScreenshotArea.size
	offset = size.size/2
	offset.x += ScreenshotArea.position.x
	offset.y += ScreenshotArea.position.y
	var ScalingFactorx = size.size.x/ScreenshotRect.x
	var ScalingFactorY = size.size.y/ScreenshotRect.y
	scale = Vector2(ScalingFactorx,ScalingFactorY)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
