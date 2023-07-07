extends RigidBody2D

@onready var collision = $CollisionShape2D

var selected = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected:
		follow_mouse()
		sleeping = true
		collision.disabled = true
	else:
		sleeping = false
		collision.disabled = false


func follow_mouse():
	position = get_global_mouse_position()


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			selected = true
		else:
			selected = false
