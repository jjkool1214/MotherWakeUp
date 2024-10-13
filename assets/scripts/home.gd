extends Sprite2D

func _ready():
	pass

func _process(delta):
	pass

func _on_button_pressed():
	var distance = $"../Player".global_position - $".".global_position
	if (distance.x < 30):
<<<<<<< HEAD
		get_tree().change_scene_to_file("res://scenes/cave.tscn")
=======
		get_tree().change_scene_to_file("res://scenes/Home_interior.tscn")
>>>>>>> 1307381f38a8ca25e75de4a3cb6377ec7f0a19ae
