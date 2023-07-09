extends Node2D

@onready var lofi = preload("res://assets/music/Lofi Beats to Chill and Drink Blood to_2b.wav")
@onready var emergency_song = preload("res://assets/music/Emergency Order Short_2d_1a.wav")

@onready var paper = preload("res://scenes/customer/paper.tscn")

var playing_song = 0


func _ready():
	TutorialVars.connect("show_paper", show_paper)
	
	#$Timer.start()
	$AudioStreamPlayer.stream = lofi
	$AudioStreamPlayer.play()
	
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/tutorial.dialogue"), "start")


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
	
	$Tap/Area2D/CollisionShape2D.disabled = not TutorialVars.a_tap
	$Tap2/Area2D/CollisionShape2D.disabled = not TutorialVars.b_tap
	$Tap3/Area2D/CollisionShape2D.disabled = true
	$Polarizer/Area2D/CollisionShape2D.disabled = not TutorialVars.polarizer
	$Polarizer2/Area2D/CollisionShape2D.disabled = not TutorialVars.polarizer
	$Shaker/Area2D/CollisionShape2D.disabled = not TutorialVars.shaker
	$Shaker2/Area2D/CollisionShape2D.disabled = not TutorialVars.shaker
	$pump/Area2D/CollisionShape2D.disabled = not TutorialVars.pump
	$pump2/Area2D/CollisionShape2D.disabled = not TutorialVars.pump


func show_paper():
	var new_paper = paper.instantiate()
	new_paper.top_level = true
	new_paper.global_position.x = randi_range(200, 420)
	
	var recipe = {
		"blood-type": {
			"type": "ab",
			"polarization": "-"
		},
		"ingredients": ["iron", "calcium", "insulin"]  # Array of ingrendients
	}
	
	var details = {
		"name": "Lorem",
		"likes": ['Bird watching', 'Walking'],  
		"dislikes": ["Waiting", "Vegetables"],
		"vampire": false,
		"difficulty": 0,
		"order_num": 0,
		"order": recipe,
		"emergency": false
	}
	
	new_paper.fill_details(details)
	add_child(new_paper)


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/Between Day/BetweenDay.tscn")


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.stream = lofi
	$AudioStreamPlayer.play()


func _on_blood_deposit_body_entered(body):
	if not body.is_in_group("BloodBag"): return
	if body.order.recipe['blood-type']['type'] == 'a': DialogueManager.show_example_dialogue_balloon(load("res://dialogue/tutorial.dialogue"), "a_tap")
	if body.order.recipe['blood-type']['type'] == 'ab' and not "iron" in body.order.recipe['ingredients'] and not "calcium" in body.order.recipe['ingredients'] and not "insulin" in body.order.recipe['ingredients'] and not body.order.recipe['blood-type']['polarization'] == '-':
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/tutorial.dialogue"), "b_tap")
	if body.order.recipe['blood-type']['type'] == 'ab' and "iron" in body.order.recipe['ingredients'] and "calcium" in body.order.recipe['ingredients'] and "insulin" in body.order.recipe['ingredients'] and not body.order.recipe['blood-type']['polarization'] == '-': 
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/tutorial.dialogue"), "shakers")
	if body.order.recipe['blood-type']['type'] == 'ab' and "iron" in body.order.recipe['ingredients'] and "calcium" in body.order.recipe['ingredients'] and "insulin" in body.order.recipe['ingredients'] and body.order.recipe['blood-type']['polarization'] == '-':
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/tutorial.dialogue"), "polarizer") 
