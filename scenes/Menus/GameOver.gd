extends Control

func _ready():
	get_node("VBoxContainer/DayCompleted").text = "Day's Completed: " + str(Score.day)
	get_node("VBoxContainer/Score").text = "Final Bonus: " + str(Score.money)


func _on_restart_pressed():
	Score.money = 0
	Score.citation = 0
	Score.day = 0
	get_tree().change_scene_to_file("res://scenes/World/world.tscn")

func _on_quit_pressed():
	get_tree().quit()
