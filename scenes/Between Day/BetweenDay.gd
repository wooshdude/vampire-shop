extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Score.day += 1
	get_node("DaysCompleted").text = "Day " + str(Score.day) + " Completed"
	get_node("HBoxContainer/Pay").text = "Current Bonus: " + str(Score.money)
	get_node("HBoxContainer/Citations").text = "Current Citations: " + str(Score.citation)


func _on_continue_pressed():
	get_tree().change_scene_to_file("res://scenes/World/world.tscn")

func _on_quit_pressed():
	get_tree().quit()
