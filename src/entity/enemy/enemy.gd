extends KinematicBody2D

onready var sprite: AnimatedSprite = $AnimatedSprite
onready var t: Timer = $Timer
onready var a: Area2D = $Area2D

var t_is_running: bool = false

const SPEED: float = 20.0
var movement_vec: Vector2

func _physics_process(delta):
	
	movement_vec = position.direction_to(Shortlivedconfig.global_player_coords)
	position += movement_vec * SPEED * delta
	or2.ZERO):
		if (movement_vec.x < 0):
			sprite.flip_h = true
		else:
			sprite.flip_h = false


func _on_Area2D_body_entered(body):
	if (body.name == "Esper" && !t_is_running):
		Gamestate.get_hit()
		t.start()
		t_is_running = true

func _on_Timer_timeout():
	if (a.overlaps_body(get_tree().get_nodes_in_group("esper")[0])):
		Gamestate.get_hit()
	else:
		t_is_running = false
		t.stop()
