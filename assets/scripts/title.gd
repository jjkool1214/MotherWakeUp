extends Control

@onready var play_button: AnimatedSprite2D = $Play
@onready var exit_button: AnimatedSprite2D = $Exit

func _on_play_button_pressed() -> void:
	Game.change_scene("home-interior", Vector2(-192, 41))

func _on_play_button_mouse_entered() -> void:
	play_button.set_frame_and_progress(1, 1)

func _on_play_button_mouse_exited() -> void:
	play_button.set_frame_and_progress(0, 0)

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_exit_button_mouse_entered() -> void:
	exit_button.set_frame_and_progress(1, 1)

func _on_exit_button_mouse_exited() -> void:
	exit_button.set_frame_and_progress(0, 0)
