extends Node2D

export (PackedScene) var ColorBlock
var score = 0

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
	color.value = randi()%10 + 1
	add_child(color)
	color.position = $ColorPath/ColorSpawn.position
	color.velocity = Vector2.DOWN
	color.connect("body_entered", color, "_on_ColorBlock_body_entered")
	color.connect("body_entered", self, "_on_ColorBlock_body_entered")

func _on_ColorBlock_body_entered(_body):
	score+=1
	$Hud/ScoreLabel.text = ("Score: " + str(score))

func _on_StartTimer_timeout():
	$ColorTimer.start()
