extends Node2D

@onready var area = $Area2D
@onready var anim = $AnimationPlayer

var in_use = false

func _process(delta):
	if in_use == true:
		anim.play("POLARIZE")
	else:
		anim.stop()
