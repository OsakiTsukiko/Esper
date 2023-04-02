extends Node2D

onready var working_i: Sprite = $working_i
onready var working: Sprite = $working
onready var not_working_i: Sprite = $notworking_i
onready var not_working: Sprite = $notworking
onready var t: Timer = $Timer

var health: int = 5

var enemy_scene: Resource = load("res://src/entity/enemy/enemy.tscn")

export var timer_time: int = 5

func _ready():
	t.wait_time = timer_time
	working.visible = true
	working_i.visible = true
	call_deferred("spawn")

func _on_Timer_timeout():
	spawn()

func spawn():
	var enemy: KinematicBody2D = enemy_scene.instance()
	get_parent().add_child(enemy)
	enemy.global_position = global_position

func _on_Area2D_area_entered(area):
	if (area.name == "Bullet"):
		health -= 1
		area.queue_free()
	if (health <= 0):
		t.stop()
		working.visible = false
		working_i.visible = false
		not_working.visible = true
		not_working_i.visible = true
		
