extends Area2D
class_name Interactable
signal trigger_player_teleport

@export var interactable_scale: Vector2 = Vector2.ONE
@export var dialogue_key: String = ""
@export var target_scene: String = ""
@export var target_position: Vector2 = Vector2.ZERO

var can_interact: bool = false

func _ready() -> void:
	$CollisionShape2D.set_scale(interactable_scale)
	$Hint.visible = false

func _process(_delta: float) -> void:
	if not Input.is_action_just_pressed("interact") or not can_interact:
		return
	
	if not dialogue_key.is_empty():
		Game.freeze_player = true
		$"../Player/Camera2D/Dialogue".start_dialogue(dialogue_key)
		await $"../Player/Camera2D/Dialogue".trigger_dialogue_over
		Game.freeze_player = false
	elif not target_scene.is_empty():
		Game.change_scene(target_scene, target_position)

func _on_body_entered(body: Node2D) -> void:
	if not body.name == "Player" or not $"../Player/Camera2D/Dialogue".active_dialogue.is_empty():
		return
		
	$Hint.visible = true
	can_interact = true

func _on_body_exited(body: Node2D) -> void:
	$Hint.visible = false
	can_interact = false
