extends KinematicBody2D

var bullet_scene: Resource = load("res://src/entity/bullet/Bullet.tscn")

onready var sprite: AnimatedSprite = $AnimatedSprite

const SPEED: float = 2500.0

var can_shoot: bool = true

var last_direction: Vector2 = Vector2.ZERO

func _ready():
	Gamestate.connect("get_hit", self, "_get_hit")

func _physics_process(delta):
	var input_vector := Vector2(
		Input.get_action_strength("esper_right") - Input.get_action_strength("esper_left"),
		Input.get_action_strength("esper_down") - Input.get_action_strength("esper_up")
	)
	
	input_vector = input_vector.normalized()
	
	move_and_slide(input_vector * delta * SPEED)
	
	Shortlivedconfig.global_player_coords = global_position
	
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
	
	if (Input.is_action_pressed("esper_attack")):
		if (input_vector.x != 0):
			shoot(0, 1 * sign(input_vector.x))
		else:
			if (input_vector.y != 0):
				shoot(1, 1 * sign(input_vector.y))
			else:
				if (last_direction.x != 0):
					shoot(0, 1 * sign(last_direction.x))
				if (last_direction.y != 0):
					shoot(1, 1 * sign(last_direction.y))
					
	if (input_vector != Vector2.ZERO):
		last_direction = input_vector

func shoot(direction: int, sense: int):
	if (can_shoot):
		var bullet = bullet_scene.instance()
		if (direction == 1):
			if (sense >= 0):
				bullet.rotate(PI)
				bullet.speed = Vector2(0, 450)
			else:
				bullet.speed = Vector2(0, -450)
		
		if (direction == 0):
			if (sense >= 0):
				bullet.rotate(PI/2)
				bullet.speed = Vector2(450, 0)
			if (sense < 0):
				bullet.rotate(-PI/2)
				bullet.speed = Vector2(-450, 0)
		
		bullet.global_position = global_position
		get_parent().add_child(bullet)
		can_shoot = false
		yield(get_tree().create_timer(.5), "timeout")
		can_shoot = true

func _get_hit():
	sprite.material.set_shader_param("active", true)
	yield(get_tree().create_timer(.2), "timeout")
	sprite.material.set_shader_param("active", false)
