extends Node2D

onready var GameOverText = $VBoxContainer/CenterContainer/GameOverText
onready var ScoreText = $VBoxContainer/CenterContainer2/Score
var score

func _ready():
	$VBoxContainer.set_size(Vector2(get_viewport().size.x, get_viewport().size.y))

func hide():
	GameOverText.hide()
	ScoreText.hide()

func show():
	GameOverText.show()
	ScoreText.text = "Score: " + str(score)
	ScoreText.show()
