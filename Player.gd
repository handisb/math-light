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

var currentSpriteIndex
var direction = "right"
var aPlayer

var value

var equationPositionX

#func animationSetup():
#	var walkAnimation = Animation.new()
#	walkAnimation.add_track(0)
#	walkAnimation.length = playerConfig.playerWalkSprites.size()
#
#	var path = String(self.get_path()) + ":currentSpriteIndex"
#	walkAnimation.track_set_path(0, path)
#
#	for i in range(playerConfig.playerWalkSprites.size()):
#		walkAnimation.track_insert_key(0, float(i/playerConfig.playerWalkSprites.size()), i)
#		print(i)
#	walkAnimation.value_track_set_update_mode(0, Animation.UPDATE_DISCRETE)
#	walkAnimation.loop = true
#
#	aPlayer = $PlayerSprite/AnimationPlayer
#	aPlayer.add_animation("walk", walkAnimation)
#	aPlayer.set_current_animation("walk")
#	#aPlayer.play("walk")

func scaleSprites():
	var sprite = playerConfig.playerWalkSprites[0]
	var viewportArea = get_viewport().size.x*get_viewport().size.y
	var playerArea = sprite.get_size().x*sprite.get_size().y
	var playerPercentage = playerArea/viewportArea
	var scaleBy = playerConfig.playerPercentageSize/playerPercentage
	
	$PlayerSprite.set_scale(Vector2(sqrt(scaleBy), sqrt(scaleBy)))
	$CollisionShape2D.shape.extents = sprite.get_size()*sqrt(scaleBy)/2

# Called when the node enters the scene tree for the first time.
func _ready():
	if (playerConfig):
		$PlayerSprite.texture = playerConfig.playerWalkSprites[0]
		currentSpriteIndex = 0
		scaleSprites()
		equationPositionX = $PlayerSprite/Value.get_rect().position.x
	position = get_viewport_rect().size/2

func _input(event):
	if (event is InputEventMouseButton):
		inputMode = "mouse"
		mousePos = event.position

func animate(delta):
	#aPlayer.get_animation("walk").length = playerConfig.playerWalkSprites.size()*delta
	#aPlayer.stop(true)
	#aPlayer.play("walk")
	if (velocity.length() > 0):
		currentSpriteIndex+=float(1)/4
		$PlayerSprite.texture = playerConfig.playerWalkSprites[int(currentSpriteIndex)%playerConfig.playerWalkSprites.size()]
		if (direction == "right"):
			$PlayerSprite.set_flip_h(true)
			# find midpoint of equation label along x-position and add to its default x-position
			var equationMidPoint = $PlayerSprite/Value.get_rect().size.x / 2 + equationPositionX
			# new x-position is flipped to other side
			var new_x = equationMidPoint * -1
			$PlayerSprite/Value.set_position(Vector2(new_x, $PlayerSprite/Value.get_rect().position.y))
		else:
			$PlayerSprite.set_flip_h(false)
			$PlayerSprite/Value.set_position(Vector2(equationPositionX, $PlayerSprite/Value.get_rect().position.y))

func move(delta):
	var speed = maxSpeed
	if (inputMode == "keyboard"):
		var LEFT = Input.is_action_pressed("ui_left")
		var RIGHT = Input.is_action_pressed("ui_right")
		var DOWN = Input.is_action_pressed("ui_down")
		var UP = Input.is_action_pressed("ui_up")
		
		if (LEFT):
			velocity.x = -1
			direction = "left"
		elif (RIGHT):
			velocity.x = 1
			direction = "right"
		else:
			velocity.x = 0
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
	animate(delta)
	drawValue()
