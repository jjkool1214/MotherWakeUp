extends StaticBody2D

@onready var dialogue: Dialogue = $"Player/Camera2D/Dialogue"

func _ready() -> void:
	if not "checkin-1" in Game.cutscenes:
		checkin_1_cutscene()

func checkin_1_cutscene() -> void:
	Game.cutscenes.append("checkin-1")
	Game.in_cutscene = true
	$"Player/AnimatedSprite2D".flip_h = true
	dialogue.start_dialogue("scene1-mother-1")
	await dialogue.trigger_dialogue_over
	Game.in_cutscene = false
