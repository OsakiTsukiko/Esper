extends Area2D

var speed := Vector2(100, 100)

func _process(delta):
	global_position += speed * delta / 5

func _on_Timer_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	if (body.has_method("IS_ENEMY")):
		body.queue_free()
		queue_free()
	if (body.has_method("IS_SKULLKING")):
		body.health -= 1
		if (body.health == 0):
			body.queue_free()
			Gamestate.won_screen()
		queue_free()

	print(body.name)

func IS_BULLET() -> bool:
	return true
