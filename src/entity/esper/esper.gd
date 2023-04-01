extends KinematicBody2D

onready var sprite: AnimatedSprite = $AnimatedSprite

const SPEED: float = 2000.0

func _process(delta):
	var input_vector := Vector2(
		Input.get_action_strength("esper_right") - Input.get_action_strength("esper_left"),
		Input.get_action_strength("esper_down") - Input.get_action_strength("esper_up")
	)
	
	input_vector = input_vector.normalized()
	
	move_and_slide(input_vector * delta * SPEED)
	
	if (input_vector != Vector2.ZERO):
		if (input_vector.y < 0):
			sprite.animation = "RUN_UP"
		else:
			sprite.animation = "RUN_DOWN"
		if (input_vector.x < 0):
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		sprite.animation = "IDLE"
