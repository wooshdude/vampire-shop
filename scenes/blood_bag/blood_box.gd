extends Node2D

@onready var blood_bag = preload("res://scenes/blood_bag/blood_bag.tscn")

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print('clicked')
			var new_bag = blood_bag.instantiate()
			new_bag.top_level = true
			new_bag.selected = true
			
			add_child(new_bag)
