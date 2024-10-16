extends CharacterBody2D

const SPEED = 50.0

func _ready():
	if not Game.enter_door_target_position == Vector2.ZERO:
		global_position = Game.enter_door_target_position
		Game.enter_door_target_position = Vector2.ZERO

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	
	if Game.in_cutscene and $AnimatedSprite2D.animation == "walk":
		if $AnimatedSprite2D.flip_h:
			direction = -1
		else:
			direction = 1
	elif Game.in_cutscene or Game.freeze_player:
		direction = 0
	
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("walk");
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false;
		else:
			$AnimatedSprite2D.flip_h = true;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")
	
	if not is_on_floor():
		$AnimatedSprite2D.play("fall")
		velocity += get_gravity() * delta
	
	move_and_slide()
