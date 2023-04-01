extends Node
class_name Utils

static func rand_vicinity(pos: Vector2):
	var add := Vector2.ZERO
	add.x = (randi() % 21 - 10)
	add.y = (randi() % 21 - 10)
	return (pos + add)
