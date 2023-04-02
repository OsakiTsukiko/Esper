extends Node2D

onready var working_i: Sprite = $working_i
onready var working: Sprite = $working
onready var not_working_i: Sprite = $notworking_i
onready var not_working: Sprite = $notworking

var enemy_scene: Resource = load("res://src/entity/enemy/enemy.tscn")

func _ready():
	working.visible = true
	working_i.visible = true
	call_deferred("spawn")

func _on_Timer_timeout():
	spawn()

func spawn():
	var enemy: KinematicBody2D = enemy_scene.instance()
	get_parent().add_child(enemy)
	enemy.global_position = global_position
