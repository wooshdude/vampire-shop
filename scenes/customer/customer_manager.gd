extends Node2D

@onready var customer_generator = preload("res://scenes/customer/Customer_generator.tscn")
@onready var paper = preload("res://scenes/customer/paper.tscn")
@onready var ambulance = preload("res://scenes/customer/ambulance.tscn")

@onready var timer = $Timer
@onready var emergency_timer = $EmergencyTimer

@export var time_range: Vector2i
var new_customer


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(3)
	GlobalOrders.connect("order_finished", _on_timer_timeout)


func _on_timer_timeout():
	if new_customer: new_customer.state = 1
	new_customer = customer_generator.instantiate()
	#new_customer.connect("left", _customer_left)
	add_child(new_customer)
	
	var new_paper = paper.instantiate()
	new_paper.top_level = true
	new_paper.global_position.x = randi_range(200, 400)
	new_paper.fill_details(new_customer.new_order.patient)
	add_child(new_paper)
	await get_tree().create_timer(3).timeout
	timer.start(randi_range(time_range.x,time_range.y)-Score.day)



func _on_emergency_timer_timeout():
	GlobalOrders.emergency = true
	
	emergency_timer.start(randi_range(60, 80))
	if new_customer: new_customer.state = 1
	new_customer = customer_generator.instantiate()
	new_customer.new_order['patient']['emergency'] = true
	#new_customer.connect("left", _customer_left)
	add_child(new_customer)
	
	var new_ambulance = ambulance.instantiate()
	new_ambulance.top_level = true
	new_ambulance.z_index = -10
	new_ambulance.global_position = Vector2.ZERO
	add_child(new_ambulance)
	
	var new_paper = paper.instantiate()
	new_paper.top_level = true
	new_paper.global_position.x = randi_range(200, 400)
	new_paper.emergency = true
	new_paper.fill_details(new_customer.new_order.patient)
	add_child(new_paper)
	await get_tree().create_timer(3).timeout
