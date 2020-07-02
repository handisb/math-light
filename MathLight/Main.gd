extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var ColorBlock
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ColorTimer_timeout():
	randomize()
	$ColorPath/ColorSpawn.offset = randi()%int(get_viewport_rect().size.x)
	var color = ColorBlock.instance()
	add_child(color)
	color.position = $ColorPath/ColorSpawn.position
	color.velocity = Vector2.DOWN
	color.connect("body_entered", color, "_on_ColorBlock_body_entered")


func _on_StartTimer_timeout():
	$ColorTimer.start()
