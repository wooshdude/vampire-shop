extends Node2D

@onready var lofi = preload("res://assets/music/Lofi Beats to Chill and Drink Blood to_2b.wav")
@onready var emergency_song = preload("res://assets/music/Emergency Order Short_2d_1a.wav")

var playing_song = 0
var timer_length

func _ready():
	#$Timer.start()
	$AudioStreamPlayer.stream = lofi
	$AudioStreamPlayer.play()
	timer_length = 120 + (Score.day * 15)
	$Timer.start(timer_length)


func _process(delta):
	if GlobalOrders.emergency:
		if playing_song == 0:
			$AudioStreamPlayer.stream = emergency_song
			$AudioStreamPlayer.play()
			playing_song = 1
	else:
		if playing_song == 1:
			$AudioStreamPlayer.stream = lofi
			$AudioStreamPlayer.play()
			playing_song = 0


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/Between Day/BetweenDay.tscn")


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.stream = lofi
	$AudioStreamPlayer.play()
