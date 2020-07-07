extends KinematicBody2D

export (Resource) var playerConfig
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 400
var expression

# Called when the node enters the scene tree for the first time.
func _ready():
	if (playerConfig):
		$Sprite.texture = playerConfig.charSprite
		$CollisionShape2D.shape.extents = $Sprite.texture.get_size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed
	position += velocity*delta
	$Sprite/Label.text = expression
