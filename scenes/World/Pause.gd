extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state

func _on_resume_button_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Menus/menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
