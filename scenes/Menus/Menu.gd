extends Control


func _ready():
	get_tree().paused = false

func _on_start_button_pressed():
	Score.money = 0
	Score.citation = 0
	Score.day = 0
	get_tree().change_scene_to_file("res://scenes/World/world.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
