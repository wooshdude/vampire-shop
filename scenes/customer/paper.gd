extends RigidBody2D

@onready var collision = $CollisionPolygon2D
@onready var audio = $AudioStreamPlayer
@onready var anim = $AnimationPlayer

@onready var name_label = $Name
@onready var age = $Age
@onready var likes = [$Likes1, $Likes2]
@onready var dislikes = [$Dislikes1, $Dislikes2]
@onready var blood_type = $BloodType
@onready var supplements = $Supplements
@onready var diabetic = $Diabetic

var selected = false
var patient_file

var penis = false
var emergency = false

var distance = Vector2.ZERO


func _ready():
	GlobalOrders.connect("order_complete", order_complete)
	audio.pitch_scale = randf_range(0.8, 1.2)
	audio.play(0.25)
	
	if emergency:
		print('emergency order!')
		$EmergencyTimer.start(30)
		$AnimatedSprite2D.modulate = "#fce1e6"


func _process(_delta):
	#print($AnimatedSprite2D/Area2D2.get_overlapping_areas())
	
	if not $AnimatedSprite2D/Area2D2.has_overlapping_areas():
		global_position.y = lerp(global_position.y, -270.0, 0.1)
	
	if selected:
		follow_mouse()
		collision.disabled = true
	else:
		collision.disabled = false
		
	#print($EmergencyTimer.time_left)


func order_complete(index):
	if patient_file['order_num'] == index:
		$AnimationPlayer.play("FINISH")


func follow_mouse():
	global_position = get_global_mouse_position() - distance


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#print(event)
		if event.pressed:
			selected = true
			distance = get_global_mouse_position() - global_position
		else:
			selected = false
			audio.pitch_scale = randf_range(0.8, 1.2)
			audio.play(0.25)


func array_to_string(arr: Array) -> String:
	var s = ""
	for i in arr:
		if not i == "insulin":
			s += String(i) + ", "
	return s


func fill_details(patient: Dictionary):
	patient_file = patient
	self.get_node("AnimatedSprite2D/Name").text = "Name: " + patient['name']
	self.get_node("AnimatedSprite2D/Age").text = "Age: " + str(randi_range(18, 100))
	self.get_node("AnimatedSprite2D/Likes1").text = patient['likes'][0]
	self.get_node("AnimatedSprite2D/Likes2").text = patient['likes'][1]
	self.get_node("AnimatedSprite2D/Dislikes1").text = patient['dislikes'][0]
	self.get_node("AnimatedSprite2D/Dislikes2").text = patient['dislikes'][1]
	self.get_node("AnimatedSprite2D/BloodType").text = "Blood Type: " + patient['order']['blood-type']['type'] + patient['order']['blood-type']['polarization']
	self.get_node("AnimatedSprite2D/Supplements").text = "Supplements: " + array_to_string(patient['order']['ingredients'])
	if "insulin" in patient['order']['ingredients']:
		self.get_node("AnimatedSprite2D/Diabetic").text = "Diabetic: Yes"
	else:
		self.get_node("AnimatedSprite2D/Diabetic").text = "Diabetic: No"
	if patient['vampire']:
		var rand_num = randi_range(0,1)
		if rand_num == 1:
			$AnimatedSprite2D.frame = 1


func _on_area_2d_hidden():
	print("hidden")


func _on_animation_player_animation_finished(anim_name):
	if emergency:
		GlobalOrders.emergency = false
	queue_free()


func _on_emergency_timer_timeout():
	anim.play("FINISH")
	Score.Citation()
	GlobalOrders.emergency = false
	#GlobalOrders.emit_signal("order_complete", GlobalOrders.get_order_index(order))
