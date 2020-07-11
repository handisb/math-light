extends Node2D

export (PackedScene) var ColorBlock
export (Resource) var mainConfig
var playerList
var score = 0
var index = 0
var correctAnswer
onready var expression = Expression.new()

func getCorrectAnswer():
	if (mainConfig.gameMode == "math"):
		var error = expression.parse($Player.value, [])
		if (error != OK):
			print(error)
		correctAnswer = expression.execute([], null, true)
		if (expression.has_execute_failed()):
			print("ruhroh")
	elif (mainConfig.gameMode == "english"):
		correctAnswer = mainConfig.letterList[mainConfig.wordList.find($Player.value)]
	elif (mainConfig.gameMode == "shape"):
		correctAnswer = mainConfig.blockShapeList[mainConfig.playerShapeList.find($Player.value)]
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$ColorTimer.start()
	$Hud/GameTimer.start(mainConfig.gameTime)
# warning-ignore:return_value_discarded
	$Hud/GameTimer.connect("timeout", self, "_on_GameTimer_timeout")
	
	if (mainConfig.gameMode == "math"):
		playerList = mainConfig.expressionList.duplicate()
	elif (mainConfig.gameMode == "english"):
		playerList = mainConfig.wordList.duplicate()
	elif (mainConfig.gameMode == "shape"):
		playerList = mainConfig.playerShapeList.duplicate()
	
	playerList.shuffle()
	$Player.value = playerList[index]
	getCorrectAnswer()

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
	elif (mainConfig.gameMode == "english"):
		var blockList = mainConfig.letterList.duplicate()
		blockList.erase(correctAnswer)
		if (randf() <= mainConfig.correctProbability):
			color.value = correctAnswer
		else:
			color.value = blockList[randi()%blockList.size()]
	elif (mainConfig.gameMode == "shape"):
		var blockList = mainConfig.blockShapeList.duplicate()
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
	index+=1
	$Player.value = playerList[index%playerList.size()]
	getCorrectAnswer()
	$Hud/ScoreLabel.text = ("Score: " + str(score))

func _on_GameTimer_timeout():
	get_tree().quit()
