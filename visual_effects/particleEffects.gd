extends CPUParticles2D

var config_file = MyConfigurations.new()
var configs = config_file.get_config()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var img_src = "res://" + configs["configurations"]["default"]["mathLight"]["visualEffects"]["particles"]["imgSrc"]
	scale_amount = configs["configurations"]["default"]["mathLight"]["visualEffects"]["particles"]["scale"]
	texture = load(img_src)
	set_emitting(true)

func run_particles():
	set_emitting(true)

func stop_particles():
	set_emitting(false)

func resize_particles(size = 0.1):
	scale_amount = size
