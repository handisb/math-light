extends Area2D

const SPEED = 20
var velocity = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity.normalized()*SPEED*delta

func _on_ColorBlock_body_entered(body):
	queue_free()
