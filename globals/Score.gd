extends Node

var day = 0
var money = 0
var citation = 0

func Citation():
	citation += 1
	if citation >= 3:
		get_tree().change_scene_to_file()
