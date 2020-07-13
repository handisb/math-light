extends Node2D

export (PackedScene) var ColorBlock
export (Resource) var mainConfig
var playerList
var blockList
var score = 0
var index = 0
var correctAnswer
onready var expression = Expression.new()

func getCorrectAnswer():
	if (mainConfig.gameMode == "math"):
		var error = expression.parse($Player.value, [])
		if (error != OK):
			print(error)
		var result = expression.execute([], null, true)
		if (expression.has_execute_failed()):
			print("ruhroh")
		return result
	elif (mainConfig.gameMode == "english"):
		return mainConfig.letterList[mainConfig.wordList.find($Player.value)]
	elif (mainConfig.gameMode == "shape"):
		return mainConfig.blockShapeList[mainConfig.playerShapeList.find($Player.value)]

func getPlayerList():
	if (mainConfig.gameMode == "math"):
		return mainConfig.expressionList.duplicate()
	elif (mainConfig.gameMode == "english"):
		return mainConfig.wordList.duplicate()
	elif (mainConfig.gameMode == "shape"):
		return mainConfig.playerShapeList.duplicate()

func getBlockList():
	if (mainConfig.gameMode == "english"):
		return mainConfig.letterList.duplicate()
	elif (mainConfig.gameMode == "shape"):
		return mainConfig.blockShapeList.duplicate()
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$ColorTimer.start()
	$Hud/GameTimer.start(mainConfig.gameTime)
# warning-ignore:return_value_discarded
	$Hud/GameTimer.connect("timeout", self, "_on_GameTimer_timeout")
	
	$ColorPath.curve.clear_points()
	$ColorPath.curve.add_point(Vector2.ZERO)
	$ColorPath.curve.add_point(Vector2(get_viewport().size.x, 0))
	
	playerList = getPlayerList()
	playerList.shuffle()
	$Player.value = playerList[index]
	correctAnswer = getCorrectAnswer()

func scoring(block):
	if (block.value == correctAnswer):
		score+=1

func setBlockValue(color):
	if (mainConfig.gameMode == "math"):
		if (randf() <= mainConfig.correctProbability):
			color.value = correctAnswer
		else:
			var randomValue = correctAnswer
			while (randomValue == correctAnswer):
				randomValue = randi()%10 + 1
			color.value = randomValue
	else:
		blockList = getBlockList()
		blockList.erase(correctAnswer)
		if (randf() <= mainConfig.correctProbability):
			color.value = correctAnswer
		else:
			color.value = blockList[randi()%blockList.size()]

func createBlock(color):
	color.position = $ColorPath/ColorSpawn.position
	color.velocity = Vector2.DOWN
	color.connect("body_entered", color, "_on_ColorBlock_body_entered")
	color.connect("body_entered", self, "_on_ColorBlock_body_entered", [color])

func _on_ColorTimer_timeout():
	$ColorPath/ColorSpawn.offset = randi()%int(get_viewport_rect().size.x)
	var color = ColorBlock.instance()
	setBlockValue(color)
	add_child(color)
	createBlock(color)

func _on_ColorBlock_body_entered(_body, block):
	scoring(block)
	if (block.value == correctAnswer):
		index+=1
		$Player.value = playerList[index%playerList.size()]
	correctAnswer = getCorrectAnswer()
	$Hud/ScoreLabel.text = ("Score: " + str(score))

func _on_GameTimer_timeout():
	get_tree().paused = true
