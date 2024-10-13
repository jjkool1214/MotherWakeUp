extends Sprite2D

var can_enter = false

func _ready():
	pass

func _process(delta):
	if can_enter && Input.is_action_just_pressed("interact"):
		print('going through doorway')

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		print('can enter')
		can_enter = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	can_enter = false
