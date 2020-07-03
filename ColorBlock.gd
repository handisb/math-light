extends Area2D

export (Resource) var blockConfig
const SPEED = 20
var velocity = Vector2(0, 0)
var value

# Called when the node enters the scene tree for the first time.
func _ready():
	var blockFont = DynamicFont.new()
	blockFont.font_data = blockConfig.blockFontData
	blockFont.size = blockConfig.blockFontSize
	if (blockConfig):
		$Sprite.texture = blockConfig.blockSprite
	$Sprite/Label.set("custom_fonts/font", blockFont)
	$Sprite/Label.text = str(value)
	$Sprite/Label.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity.normalized()*SPEED*delta

func _on_ColorBlock_body_entered(_body):
	queue_free()
