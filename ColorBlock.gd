extends Area2D

export (Resource) var blockConfig
var mainConfig = preload("res://config/Main_Config.tres")
var SPEED
var velocity = Vector2(0, 0)
var value


func scaleSprite(blockFont):
	var sprite = $Sprite.texture
	var viewportArea = get_viewport().size.x*get_viewport().size.y
	var blockArea = sprite.get_size().x*sprite.get_size().y
	var blockPercentage = blockArea/viewportArea
	var scaleBy = blockConfig.blockPercentageSize/blockPercentage
	
	$Sprite.set_scale(Vector2(sqrt(scaleBy), sqrt(scaleBy)))
	$CollisionShape2D.shape.extents = sprite.get_size()*sqrt(scaleBy)/2
	blockFont.size = blockConfig.blockPercentageSize*64000
# Called when the node enters the scene tree for the first time.
func _ready():
	var blockFont = DynamicFont.new()
	blockFont.font_data = blockConfig.blockFontData
	blockFont.size = blockConfig.blockFontSize
	SPEED = blockConfig.blockSpeed
	if (mainConfig.gameMode != "shape"):
		$Sprite.texture = blockConfig.blockSprite
		$Sprite/Label.set("custom_fonts/font", blockFont)
		$Sprite/Label.text = str(value)
		$Sprite/Label.show()
	else:
		$Sprite.texture = value
	scaleSprite(blockFont)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity.normalized()*SPEED*delta

func _on_ColorBlock_body_entered(_body):
	queue_free()

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
