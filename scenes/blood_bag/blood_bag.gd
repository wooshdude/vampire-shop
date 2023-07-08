extends RigidBody2D

@onready var collision = $CollisionPolygon2D
@onready var mouse_area = $Area2D
@onready var tap_area = $TapCollider
@onready var timer = $TapTimer
@onready var drag_timer = $DragTimer
@onready var receive_timer = $ReceiveTimer
@onready var label = $Label

var selected = false
var tap_position
var receiving_blood

enum {
	IDLE,
	DRAG
}
var state = DRAG

@onready var order = Order.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(tap_area.monitoring)
	
	match state:
		DRAG:
			freeze = false
			
			if selected:
				follow_mouse()
				sleeping = true
				gravity_scale = 0
				collision.disabled = true
			else:
				sleeping = false
				collision.disabled = false
				gravity_scale = 1
			
		IDLE:
			global_position = lerp(global_position, tap_position, 0.1)
			rotation_degrees = lerp(rotation_degrees, 0.0, 0.05)
			freeze = true
	
	label.text = order.recipe['blood-type']['type']


func follow_mouse():
	position = get_global_mouse_position()


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			selected = true
			print('grab')
			state = DRAG
			
			receive_timer.stop()
			receiving_blood = null
			
			tap_area.monitoring = false
			timer.start()
		else:
			selected = false
			var mouse_position = get_global_mouse_position()
			
			var distance = global_position.distance_to(mouse_position)
			var direction = global_position.direction_to(mouse_position)
			
			apply_central_impulse(direction * clamp(distance,0,30) * 25)


func _on_tap_collider_area_entered(area):
	print('colliding')
	print('receiving blood type ' + area.get_parent().blood_type)
	receiving_blood = area.get_parent().blood_type
	tap_position = area.global_position
	state = IDLE
	mouse_area.monitoring = false
	drag_timer.start()
	receive_timer.start()


func _on_timer_timeout():
	tap_area.monitoring = true


func _on_drag_timer_timeout():
	mouse_area.monitoring = true


func _on_receive_timer_timeout():
	order.add_blood(receiving_blood)
