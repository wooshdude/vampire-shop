extends Node2D

@onready var name_label = $Name
@onready var age = $Age
@onready var likes = [$Likes1, $Likes2]
@onready var dislikes = [$Dislikes1, $Dislikes2]
@onready var blood_type = $BloodType
@onready var supplements = $Supplements
@onready var diabetic = $Diabetic

var selected = false
var patient_file
var distance

func _process(_delta):
	#print($AnimatedSprite2D/Area2D.get_overlapping_areas())
	
	global_position.y = lerp(global_position.y, -300.0, 0.1)
	
	if selected:
		follow_mouse()
	
	if not patient_file in GlobalOrders.orders:
		self.queue_free()


func follow_mouse():
	global_position = get_global_mouse_position() + distance


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#print(event)
		if event.pressed:
			selected = true
			distance = global_position - get_global_mouse_position()
		else:
			selected = false


func array_to_string(arr: Array) -> String:
	var s = ""
	for i in arr:
		s += String(i) + ", "
	return s


func fill_details(patient: Dictionary):
	patient_file = patient
	self.get_node("Name").text = "Name: " + patient['name']
	self.get_node("Age").text = "Age: " + str(randi_range(18, 100))
	self.get_node("Likes1").text = patient['likes'][0]
	self.get_node("Likes2").text = patient['likes'][1]
	self.get_node("BloodType").text = "Blood Type: " + patient['order']['blood-type']['type'] + patient['order']['blood-type']['polarization']
	self.get_node("Supplements").text = "Supplements: " + array_to_string(patient['order']['ingredients'])
	if "insulin" in patient['order']['ingredients']:
		self.get_node("Diabetic").text = "Diabetic: Yes"
	else:
		self.get_node("Diabetic").text = "Diabetic: No"


func _on_area_2d_hidden():
	print("hidden")
