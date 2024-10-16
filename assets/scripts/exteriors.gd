extends Node2D

@onready var dialogue: Dialogue = $"Player/Camera2D/Dialogue"
var day_background: Resource = preload("res://assets/sprites/backgrounds/exteriors/background_morning.jpg")
var night_background: Resource = preload("res://assets/sprites/backgrounds/exteriors/background_s1.png")

var ryans_deli_sign_closed: Resource = preload("res://assets/sprites/physical/objects/ryans_deli_sign_closed.png")
var ryans_deli_sign_open: Resource = preload("res://assets/sprites/physical/objects/ryans_deli_sign_open.png")

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
			$PharmacyBarrierInteract.enabled = true
			$"PharmacyBarrier/CollisionShape2D".disabled = false
	else:
		$HomeDoor.dialogue_key = ""

func ryan_advice_cutscene() -> void:
	Game.cutscenes.append("ryan-advice")
	Game.in_cutscene = true
	$RyansDeliSign.texture = ryans_deli_sign_open
	$Ryan.visible = true
	$TalkToSydney.enabled = false
	$Sydney.visible = false
	$TalkToJames.enabled = false
	$James.visible = false
	$TalkToJulie.enabled = false
	$Julie.visible = false
	$ConstructionSignInteract.enabled = true
	$ConstructionSign.visible = true
	$ConstructionSign/StaticBody2D/CollisionShape2D.disabled = false
	$PharmacyBarrierInteract.enabled = false
	$"PharmacyBarrier/CollisionShape2D".disabled = true
	dialogue.start_dialogue("scene1-ryan")
	await dialogue.trigger_dialogue_over
	$RyansDeliSign.texture = ryans_deli_sign_closed
	Game.in_cutscene = false
