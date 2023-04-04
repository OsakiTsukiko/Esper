extends Node
class_name Utils

static func rand_vicinity(pos: Vector2):
	var add := Vector2.ZERO
	add.x = (randi() % 11 - 5)
	add.y = (randi() % 11 - 5)
	return (pos + add)
