extends StaticBody2D

@onready var dialogue: Dialogue = $"Player/Camera2D/Dialogue"

func _ready() -> void:	
	dialogue.trigger_dialogue_started.connect(_on_dialogue_started)
	
	if Game.cutscenes.is_empty():
		intro_cutscene()
	elif "intro" in Game.cutscenes:
		$Mother.position = Vector2(-92, 45.5)
		letter_cutscene()

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
	dialogue.start_dialogue("scene1-pasta-1")

func _on_dialogue_started(key: String) -> void:
	if key == "intro-extra-gift":
		$"Player/AnimatedSprite2D".flip_h = false
		$"Player/AnimatedSprite2D".play("walk")
		var tween: Tween = create_tween()
		tween.tween_property($Player, "position", Vector2(-31, 45.5), 3)
		tween.finished.connect(_on_stop_walking)

func _on_stop_walking() -> void:
	$"Player/AnimatedSprite2D".play("idle")
	$"Player/AnimatedSprite2D".flip_h = true
	await dialogue.trigger_dialogue_over
	Game.in_cutscene = false
	Game.change_scene("home-interior", Vector2(-31, 45.5))
