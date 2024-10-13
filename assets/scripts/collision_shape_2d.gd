extends CollisionShape2D

var enter = false

func _ready() -> void:
	set_process_input(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(enter)
	

func _input(event):
	if Input.is_key_pressed(KEY_E) and enter:
		get_tree().change_scene_to_file("res://scenes/Home_interior.tscn")


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("KYSSSSS")
	enter = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	print("I wanna fuck you")
	enter = false
