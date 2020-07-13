extends KinematicBody2D

export (Resource) var playerConfig
var mainConfig = preload("res://config/Main_Config.tres")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var maxSpeed = 400
var velocity = Vector2()
var inputMode = "keyboard"
var mousePos = Vector2()
var value

# Called when the node enters the scene tree for the first time.
func _ready():
	if (playerConfig):
		$PlayerSprite.texture = playerConfig.charSprite
		$CollisionShape2D.shape.extents = $PlayerSprite.texture.get_size()/2
	position = get_viewport_rect().size/2

func _input(event):
	if (event is InputEventMouseButton):
		inputMode = "mouse"
		mousePos = event.position

func move(delta):
	var speed = maxSpeed
	if (inputMode == "keyboard"):
		var LEFT = Input.is_action_pressed("ui_left")
		var RIGHT = Input.is_action_pressed("ui_right")
		var DOWN = Input.is_action_pressed("ui_down")
		var UP = Input.is_action_pressed("ui_up")
		
		velocity.x = -int(LEFT) + int(RIGHT)
		velocity.y = -int(UP) + int(DOWN)
	elif (inputMode == "mouse"):
		velocity = mousePos - position
		var nextPosition = position + velocity.normalized()*maxSpeed*delta
		if (abs((mousePos - nextPosition).length()) < 5):
			speed = velocity.length()/delta
	
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
