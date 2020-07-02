extends Area2D

export (Resource) var blockConfig
const SPEED = 20
var velocity = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	if (blockConfig):
		$Sprite.texture = blockConfig.blockSprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity.normalized()*SPEED*delta

func _on_ColorBlock_body_entered(_body):
	queue_free()
