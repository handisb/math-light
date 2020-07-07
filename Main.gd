extends Node2D

export (PackedScene) var ColorBlock
export (Resource) var mainConfig
var score = 0
var index = 0
onready var expression = Expression.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$ColorTimer.start()
	mainConfig.expressionList.shuffle()
	$Player.expression = mainConfig.expressionList[index]

func scoring(block):
	var error = expression.parse($Player.expression, [])
	if (error != OK):
		print(error)
	var result = expression.execute([], null, true)
	if (expression.has_execute_failed()):
		print("ruhroh")
	if (block.value == result):
		score+=1

func _on_ColorTimer_timeout():
	$ColorPath/ColorSpawn.offset = randi()%int(get_viewport_rect().size.x)
	var color = ColorBlock.instance()
	color.value = randi()%10 + 1
	add_child(color)
	color.position = $ColorPath/ColorSpawn.position
	color.velocity = Vector2.DOWN
	color.connect("body_entered", color, "_on_ColorBlock_body_entered")
	color.connect("body_entered", self, "_on_ColorBlock_body_entered", [color])

func _on_ColorBlock_body_entered(_body, block):
	scoring(block)
	index+=1
	$Player.expression = mainConfig.expressionList[index%mainConfig.expressionList.size()]
	$Hud/ScoreLabel.text = ("Score: " + str(score))

func _on_StartTimer_timeout():
	$ColorTimer.start()
