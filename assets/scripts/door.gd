extends Area2D

signal trigger_player_teleport

var can_enter = false

@export var target_scene: String = ""
@export var target_position: Vector2 = Vector2.ZERO

func _process(delta):
	if can_enter && Input.is_action_just_pressed("interact"):
		Game.change_scene(target_scene, target_position)

func _on_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		can_enter = true

func _on_body_exited(body: Node2D) -> void:
	can_enter = false
