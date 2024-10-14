extends StaticBody2D

@onready var dialogue: Dialogue = $"Player/Camera2D/Dialogue"

func _ready() -> void:	
	dialogue.trigger_dialogue_started.connect(_on_dialogue_started)
	
	if "intro" not in Game.cutscenes:
		intro_cutscene()
	elif "letter" not in Game.cutscenes:
		letter_cutscene()
	else:
		$Mother.visible = false
		$OpenLetter.enabled = false
		if Game.game_state == Game.State.STAGE_1 and not "checkin-1" in Game.cutscenes:
			$ExitDoor.dialogue_key = "must-check-in-mom"
		else:
			$ExitDoor.dialogue_key = ""

func intro_cutscene() -> void:
	Game.cutscenes.append("intro")
	Game.in_cutscene = true
	$"Player/AnimatedSprite2D".flip_h = true
	$"Player/AnimatedSprite2D".play("idle")
	dialogue.start_dialogue("intro-birthday")
	
func letter_cutscene() -> void:
	Game.cutscenes.append("letter")
	Game.in_cutscene = true
	$"Player/AnimatedSprite2D".flip_h = true
	$Mother.position = Vector2(-92, 45.5)
	$Letter.visible = true
	dialogue.start_dialogue("scene1-pasta-1")

func _on_dialogue_started(key: String) -> void:
	if key == "intro-extra-gift":
		$"Player/AnimatedSprite2D".flip_h = false
		$"Player/AnimatedSprite2D".play("walk")
		var tween: Tween = create_tween()
		tween.tween_property($Player, "position", Vector2(-31, 45.5), 3)
		tween.finished.connect(_on_stop_walking)
	elif key == "scene1-pasta-7":
		$Mother.flip_h = false
		var tween: Tween = create_tween()
		tween.tween_property($Mother, "position", Vector2(-303, 45.5), 5)
		await dialogue.trigger_dialogue_over
		$Fridge.enabled = false
		$Portrait.enabled = false
		$BedroomDoor.enabled = false
		$ExitDoor.enabled = false
		Game.in_cutscene = false
	elif key == "scene1-letter-4":
		await dialogue.trigger_dialogue_over
		Game.set_state(Game.State.STAGE_1)
		Game.change_scene("home-interior", Vector2(-31, 45.5))

func _on_stop_walking() -> void:
	$"Player/AnimatedSprite2D".play("idle")
	$"Player/AnimatedSprite2D".flip_h = true
	await dialogue.trigger_dialogue_over
	Game.in_cutscene = false
	Game.change_scene("home-interior", Vector2(-31, 45.5))
