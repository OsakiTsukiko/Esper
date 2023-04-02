extends Node

onready var hearts_hud = $CanvasLayer/hearts
onready var h_1 = $CanvasLayer/hearts/heart_01
onready var h_2 = $CanvasLayer/hearts/heart_02
onready var h_3 = $CanvasLayer/hearts/heart_03

var levels = [
	[load("res://src/levels/spawn/SpawnLevel.tscn")], # 0
	[load("res://src/levels/type_01/01/01.tscn")], # 1
	[load("res://src/levels/type_01/01/01.tscn")], # 2
	[load("res://src/levels/type_01/01/01.tscn")], # 3
]

var is_in_game: bool = false

var hearts: int = 3

signal load_first_spawn
signal load_room
signal get_hit

func _ready():
	randomize()

func begin():
	is_in_game = true
	get_tree().change_scene_to(
		levels[0][
			Shortlivedconfig.map_matrix[10][10].r % levels[0].size()
		]
	)
	call_deferred("emit_signal", "load_room", Vector2(10, 10), "SPAWN")

func goto_room(coords: Vector2, from: String):
	get_tree().change_scene_to(
		levels[
			Shortlivedconfig.map_matrix[coords.x][coords.y].id
		][
			Shortlivedconfig.map_matrix[coords.x][coords.y].r % levels[
				Shortlivedconfig.map_matrix[coords.x][coords.y].id
			].size()
		]
	)
	call_deferred("emit_signal", "load_room", coords, from)

func _process(delta):
	if (is_in_game):
		 hearts_hud.visible = true
	else:
		hearts_hud.visible = false

	if (hearts == 3):
		h_3.visible = true
	else:
		h_3.visible = false
	
	if (hearts >= 2):
		h_2.visible = true
	else:
		h_2.visible = false
	
	if (hearts >= 1):
		h_1.visible = true
	else:
		h_1.visible = false
	
	if (hearts == 0):
		pass
		# GAME OVER

func get_hit():
	hearts -= 1
	emit_signal("get_hit")
