extends KinematicBody2D

export (Resource) var playerConfig
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	if (playerConfig):
		$Sprite.texture = playerConfig.charSprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		velocity.x += speed
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		velocity.x -= speed
	if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		velocity.y -= speed
	if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		velocity.y += speed
	position += velocity*delta
