extends Camera2D

var spd = 4
var radius_required_to_move = 500

func _process(delta):
	var mouse_position = get_global_mouse_position()
	var mouse_delta = mouse_position - global_position
	if (mouse_delta.length() >= radius_required_to_move):
		position.x += lerp(position.x - global_position.x, mouse_delta.x, .5) * spd * delta
