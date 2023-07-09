extends Node2D

@onready var area = $Area2D
@onready var spout = $Spout

@export_enum("A", "B", "O") var blood_type = 0

var in_use = false


func _process(delta):
	if in_use:
		$AnimationPlayer.play("POUR")
	else:
		$AnimationPlayer.stop()
		$AudioStreamPlayer.stop()


func _on_area_2d_area_exited(area):
	if area.is_in_group("BloodBag"):
		in_use = false
