extends Area2D

var speed := Vector2(100, 100)

func _process(delta):
	global_position += speed * delta / 5

func _on_Timer_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	body.queue_free()
	queue_free()
