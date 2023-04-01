extends KinematicBody2D

onready var sprite: AnimatedSprite = $AnimatedSprite

const SPEED: float = 2000.0

func _process(delta):
	var input_vector := Vector2(
		Input.get_action_strength("fluffy_right") - Input.get_action_strength("fluffy_left"),
		Input.get_action_strength("fluffy_down") - Input.get_action_strength("fluffy_up")
	)
	
	input_vector = input_vector.normalized()
	
	move_and_slide(input_vector * delta * SPEED)
	
	if (input_vector != Vector2.ZERO):
		if (input_vector.x < 0):
			sprite.flip_h = true
		else:
			sprite.flip_h = false
