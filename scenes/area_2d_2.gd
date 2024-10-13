extends Area2D


# Called when the node enters the scene tree for the first time.
@onready var entered = false

func _ready():
	set_process_input(true)

func _process(delta):
	print(entered)



func _on_area_2d_body_entered(body: Node2D) -> void:
	print("bfruhygf")
	entered = true
	
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	print("fbryeui")
	entered = false
	
	
func _input(ev):
	if entered and Input.is_key_pressed(KEY_E):
		get_tree().change_scene_to_file("res://scenes/HomeInterior.tscn")
