extends KinematicBody2D

export (Resource) var playerConfig

var speed = 400
var config_file = MyConfigurations.new()
var configs = config_file.get_config()

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_img_src = "res://" + configs["configurations"]["default"]["mathLight"]["scene01"]["player"]["imgSrc"]
	$Sprite.texture = load(player_img_src)

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
	
	# audio test
	if (Input.is_key_pressed(KEY_1)):
		if ($audio_player):
			$audio_player.play_audio("test")
