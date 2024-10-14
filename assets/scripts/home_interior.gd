extends StaticBody2D

func _ready() -> void:	
	if Game.game_state == Game.State.STAGE_0:
		intro_cutscene()

func intro_cutscene() -> void:
	Game.freeze_player = true
	$"Player/Camera2D/Dialogue".start_dialogue("intro-birthday")
