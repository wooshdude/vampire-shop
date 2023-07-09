extends RigidBody2D

@onready var collision = $CollisionPolygon2D
@onready var mouse_area = $Area2D
@onready var tap_area = $TapCollider
@onready var timer = $TapTimer
@onready var drag_timer = $DragTimer
@onready var receive_timer = $ReceiveTimer
@onready var label = $Label
@onready var polarization = $Polarization
@onready var ingredient = $Ingredient
@onready var sprite = $Sprite2D

var selected = false
var tap
var receiving_blood
var receiving_polarization
var receiving_ingredient
var colliding

enum {
	IDLE,
	DRAG
}
var state = DRAG

var order = Order.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(tap_area.monitoring)

	match state:
		DRAG:
			freeze = false
			if not tap == null:
				tap.get_parent().in_use = false
				tap = null
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
			if tap:
				global_position = lerp(global_position, tap.global_position, 0.1)
				rotation_degrees = lerp(rotation_degrees, 0.0, 0.05)
				freeze = true
			else:
				state = DRAG

	label.text = order.recipe['blood-type']['type']
	polarization.text = order.recipe['blood-type']['polarization']
	var ingredientsText = ""
	for ingredient in order.recipe['ingredients']:
		ingredientsText+= ingredient+"\n"
	ingredient.text=ingredientsText


func follow_mouse():
	position = get_global_mouse_position()


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			selected = true
			get_node("TapCollider/CollisionShape2D").disabled = true

			#print('grab')
			state = DRAG

			receive_timer.stop()
			receiving_blood = null

			tap_area.monitoring = false
			timer.start()
		else:
			selected = false
			get_node("TapCollider/CollisionShape2D").disabled = false
			var mouse_position = get_global_mouse_position()

			var distance = global_position.distance_to(mouse_position)
			var direction = global_position.direction_to(mouse_position)

			apply_central_impulse(direction * clamp(distance,0,30) * 35)

func _on_tap_collider_area_exited(area):
	if not tap == null:
		tap.get_parent().in_use = false
		tap = null


func _on_tap_collider_area_entered(area):
	colliding=true
	if area.is_in_group("BloodBag"): return
	tap = area
	print(tap.get_parent().in_use)
	if tap.get_parent().in_use == false:

		if area.is_in_group("BloodTap"):
			#print('colliding')
			match area.get_parent().blood_type:
				0:
					receiving_blood = "a"
				1:
					receiving_blood = "b"
				2:
					receiving_blood = 'o'

			print('receiving blood type ' + receiving_blood)

		if area.is_in_group("Polarizer"):
			print('polarizing')
			if order.recipe['blood-type']['type'] == "": return
			match order.recipe['blood-type']['polarization']:
				"":
					receiving_polarization = "+"
				"+":
					receiving_polarization = "-"
				"-":
					receiving_polarization = "+"
		
		if area.is_in_group("Shaker"):
			match area.get_parent().ingredient:
				0:
					receiving_ingredient = "iron"
				1:
					receiving_ingredient = "calcium"

		tap.get_parent().in_use = true
		state = IDLE
		mouse_area.monitoring = false
		drag_timer.start()
		receive_timer.start()

	else:
		tap = null


func _on_timer_timeout():
	tap_area.monitoring = true


func _on_drag_timer_timeout():
	mouse_area.monitoring = true


func _on_receive_timer_timeout():
	if tap:
		if tap.is_in_group("BloodTap"):
			order.add_blood(receiving_blood)
			sprite.frame = 1
		if tap.is_in_group("Polarizer"):
			order.polarize(receiving_polarization)
		if tap.is_in_group("Pump"):
			order.add_ingredient("insulin")
		if tap.is_in_group("Shaker"):
			order.add_ingredient(receiving_ingredient)
	state = DRAG
	selected = false
	print(order.recipe)



func _on_button_pressed():
	if(colliding==true):
		order.add_ingredient(receiving_ingredient)
	state=DRAG
	selected=false


func _on_area_2d_area_exited(area):
	colliding=false
	print("exit")
