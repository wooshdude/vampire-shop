extends Node2D

@onready var anim = $AnimationPlayer

@export_enum("Iron", "Calcium") var ingredient = 0
var in_use = false

func _process(delta):
	if in_use == true:
		anim.play("SHAKE")
	else:
		anim.stop()


func _on_animation_player_animation_finished(anim_name):
	in_use = false
