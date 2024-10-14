extends Node2D

var timer = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	
	
	if timer <= 0:
		var distance = abs($"../Player".global_position - $".".global_position)
		$AudioStreamPlayer.volume_db = - distance.x / 10
		if distance.x < 100 : 
			$AudioStreamPlayer.play()
		timer = 2
		
	
