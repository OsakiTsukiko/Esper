extends KinematicBody2D

onready var sprite: AnimatedSprite = $AnimatedSprite

const SPEED: float = 5.0
var movement_vec: Vector2

func _physics_process(delta):
	
	movement_vec = position.direction_to(Shortlivedconfig.global_player_coords)
	position += movement_vec * SPEED * delta
	
	if (movement_vec != Vector2.ZERO):
		if (movement_vec.x < 0):
			sprite.flip_h = true
		else:
			sprite.flip_h = false
