extends KinematicBody2D

var health: int = 15

onready var pos_arr: Array = get_parent().get_node("PosArray").get_children()
onready var sprite = $Sprite

var t: Vector2

func _ready():
	do_move()

func do_move():
	var a: Position2D = pos_arr[randi() % pos_arr.size()]
	t = a.global_position

var movement_vec: Vector2
var SPEED: float = 30.0

func _physics_process(delta):
	movement_vec = global_position.direction_to(t)
	global_position += movement_vec * SPEED * delta
	
	if (movement_vec != Vector2.ZERO):
		if (movement_vec.x < 0):
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	
	if (t.distance_to(global_position) <= .5):
		do_move()
