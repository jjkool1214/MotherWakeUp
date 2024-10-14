extends Node2D

@onready var dialogue: Dialogue = $"Player/Camera2D/Dialogue"
var day_background: Resource = preload("res://assets/sprites/background/background_morning.jpg")
var night_background: Resource = preload("res://assets/sprites/background/background_stage1.png")

var ryans_deli_sign_closed: Resource = preload("res://assets/sprites/physical/world_objects/ryans_deli_sign_closed.png")
var ryans_deli_sign_open: Resource = preload("res://assets/sprites/physical/world_objects/ryans_deli_sign_open.png")

func _ready() -> void:
	match Game.time_of_day:
		Game.TimeOfDay.DAY:
			$"Player/ParallaxBackground/ParallaxLayer/Sprite2D".texture = day_background
		Game.TimeOfDay.NIGHT:
				$"Player/ParallaxBackground/ParallaxLayer/Sprite2D".texture = night_background
	
	if Game.game_state == Game.State.STAGE_1 and not "ryan-advice" in Game.cutscenes:
		$HomeDoor.dialogue_key = "scene1-outside-home"
		if Game.time_of_day == Game.TimeOfDay.NIGHT:
			ryan_advice_cutscene()
	else:
		$HomeDoor.dialogue_key = ""

func ryan_advice_cutscene() -> void:
	Game.cutscenes.append("ryan-advice")
	Game.in_cutscene = true
	$RyansDeliSign.texture = ryans_deli_sign_open
	$Ryan.visible = true
	$Sydney.visible = false
	$James.visible = false
	$Julie.visible = false
	dialogue.start_dialogue("scene1-ryan")
	await dialogue.trigger_dialogue_over
	$RyansDeliSign.texture = ryans_deli_sign_closed
	Game.in_cutscene = false
