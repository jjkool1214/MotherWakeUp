extends Node2D

@onready var dialogue: Dialogue = $"Player/Camera2D/Dialogue"

func _ready() -> void:
	if Game.game_state == Game.State.STAGE_1 and not "ryan-advice" in Game.cutscenes:
		$HomeDoor.dialogue_key = "scene1-outside-home"
	else:
		$HomeDoor.dialogue_key = ""
