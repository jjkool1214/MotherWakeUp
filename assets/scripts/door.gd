extends Area2D

var can_enter = false

@export var target_scene: String = ""

func _ready():
	pass

func _process(delta):
	if can_enter && Input.is_action_just_pressed("interact"):
		Game.change_scene(target_scene)

func _on_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		can_enter = true

func _on_body_exited(body: Node2D) -> void:
	can_enter = false
