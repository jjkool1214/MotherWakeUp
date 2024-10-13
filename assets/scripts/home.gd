extends Sprite2D

func _ready():
	pass

func _process(delta):
	var distance = abs($"../Player".global_position - $".".global_position)
	print(distance.x)

func _on_button_pressed():
	var distance = abs($"../Player".global_position - $".".global_position)
	if $Button.button_pressed && distance.x < 30:
		get_tree().change_scene_to_file("res://scenes/Home_interior.tscn")
