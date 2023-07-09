extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.position.x = lerp($Sprite2D.position.x, 200.0, 0.05)
	await get_tree().create_timer(5).timeout
	$Sprite2D.position.x = lerp($Sprite2D.position.x, 5000.0, 0.01)
	await get_tree().create_timer(3).timeout
	self.queue_free()
