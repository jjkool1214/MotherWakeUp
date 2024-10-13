extends CharacterBody2D

const SPEED = 50.0

func _physics_process(delta):

	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("walk");
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false;
		else:
			$AnimatedSprite2D.flip_h = true;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play('idle')
	
	if not is_on_floor():
		$AnimatedSprite2D.play("fall")
		velocity += get_gravity() * delta
	

	move_and_slide()
