extends Sprite2D

func _ready():
	pass

func _process(delta):
	pass

func _on_button_pressed():
	var distance = $"../Player".global_position - $".".global_position
	if (distance.x < 30):
		get_tree().change_scene_to_file("res://scenes/cave.tscn")
