extends Node

var config_file = MyConfigurations.new()
var configs = config_file.get_config()

# Called when the node enters the scene tree for the first time.
func _ready():
	var img_src = "res://" + configs["configurations"]["default"]["mathLight"]["scene01"]["floor"]["imgSrc"]
	$Sprite.texture = load(img_src)
	
	# get dimensions of screen
	var screen_width = get_viewport().size.x
	var screen_height = get_viewport().size.y
	
	# determine ratio of images
	var scale = screen_width / $Sprite.texture.get_size().x
	
	# put picture center of window
	$Sprite.set_position(Vector2(screen_width/2, screen_height/2))
	
	# finally, rescale floor to fit in window
	$Sprite.set_scale(Vector2(scale, scale))
	
