extends Node2D

@onready var area = $Area2D
@onready var spout = $Spout

@export_enum("A", "B", "O") var blood_type = 0

var in_use = false
