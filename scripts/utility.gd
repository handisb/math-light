extends Node

func scaleSprite(params={}):
	var sprite = params['sprite'].texture
	var viewportArea = params['viewPort'].size.x*params['viewPort'].size.y
	var spriteArea = sprite.get_size().x*sprite.get_size().y
	var spritePercentage = spriteArea/viewportArea
	var spriteScaleBy = params['spritePercentageSize']/spritePercentage

	if params.has('spriteLabel'):
		var fontArea = (params['spriteLabel'].margin_right + -params['spriteLabel'].margin_left)*(params['spriteLabel'].margin_bottom + -params['spriteLabel'].margin_top)
		var fontPercentage = fontArea/spriteArea
		var fontScaleBy = params['spritePercentageSize']/fontPercentage
	
	params['sprite'].set_scale(Vector2(sqrt(spriteScaleBy), sqrt(spriteScaleBy)))
	if params.has('blockFont'):
		params['blockFont'].size = 16*params['spritePercentageSize']*OS.get_screen_dpi()/(96*sqrt(spriteScaleBy))
	if params.has('collisionShape2D'):
		params['collisionShape2D'].shape.extents = sprite.get_size()*sqrt(spriteScaleBy)/2
