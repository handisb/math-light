extends KinematicBody2D

export (Resource) var playerConfig
var mainConfig = preload("res://config/Main_Config.tres")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 400
var value

# Called when the node enters the scene tree for the first time.
func _ready():
	if (playerConfig):
		$PlayerSprite.texture = playerConfig.charSprite
		$CollisionShape2D.shape.extents = $PlayerSprite.texture.get_size()/2

func move(delta):
	var velocity = Vector2()
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var DOWN = Input.is_action_pressed("ui_down")
	var UP = Input.is_action_pressed("ui_up")
	
	velocity.x = -int(LEFT) + int(RIGHT)
	velocity.y = -int(UP) + int(DOWN)
	
	position += velocity.normalized()*speed*delta

func drawValue():
	if (mainConfig.gameMode != "shape"):
		$PlayerSprite/Value.text = value
	else:
		$PlayerSprite/ValueSprite.texture = value
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)
	drawValue()
