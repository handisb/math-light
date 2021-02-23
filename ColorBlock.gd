extends Area2D

export (Resource) var blockConfig
var mainConfig = preload("res://config/Main_Config.tres")
var SPEED
var velocity = Vector2(0, 0)
var value

var params
onready var utility = preload('scripts/utility.gd').new()

func scaleSprite(blockFont):
	var sprite = $Sprite.texture
	var viewportArea = get_viewport().size.x*get_viewport().size.y
	var blockArea = sprite.get_size().x*sprite.get_size().y
	var blockPercentage = blockArea/viewportArea
	var fontArea = ($Sprite/Label.margin_right + -$Sprite/Label.margin_left)*($Sprite/Label.margin_bottom + -$Sprite/Label.margin_top)
	var fontPercentage = fontArea/blockArea
	var blockScaleBy = blockConfig.blockPercentageSize/blockPercentage
	var fontScaleBy = blockConfig.blockFontPercentageSize/fontPercentage

	$Sprite.set_scale(Vector2(sqrt(blockScaleBy), sqrt(blockScaleBy)))
	blockFont.size = 16*blockConfig.blockFontPercentageSize*OS.get_screen_dpi()/(96*sqrt(blockScaleBy))
	$CollisionShape2D.shape.extents = sprite.get_size()*sqrt(blockScaleBy)/2


# Called when the node enters the scene tree for the first time.
func _ready():
	params = {}
	var blockFont = DynamicFont.new()
	blockFont.font_data = blockConfig.blockFontData

	# TODO: hard code blockfont size for now, need to convert to dynamic later
	# blockFont.size = blockConfig.blockFontSize
	blockFont.size = 32

	params['blockFont'] = blockFont
	SPEED = blockConfig.blockSpeed
	if (mainConfig.gameMode != "shape"):
		$Sprite.texture = blockConfig.blockSprite
		$Sprite/Label.set("custom_fonts/font", blockFont)
		$Sprite/Label.text = str(value)
		$Sprite/Label.show()
	else:
		$Sprite.texture = value
	# TODO: leave scaling out for now since it is handled by Godot environments
	#scaleSprite(blockFont)	
#	var label_h = $Sprite.texture.get_size()[1]
#	var label_w = $Sprite.texture.get_size()[0]
	$Sprite/Label.set_position(-$Sprite.texture.get_size()/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity.normalized()*SPEED*delta

#func _on_ColorBlock_body_entered(body):
#	if body.value == str(self.value):
#		queue_free()

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
