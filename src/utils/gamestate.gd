extends Node

onready var hearts_hud = $CanvasLayer/hearts
onready var h_1 = $CanvasLayer/hearts/heart_01
onready var h_2 = $CanvasLayer/hearts/heart_02
onready var h_3 = $CanvasLayer/hearts/heart_03

var controller_usage: bool = false

var game_over_screen: Resource = load("res://src/gameover_screen/GameOverScreen.tscn")
var victory_screen: Resource = load("res://src/victory_screen/VictoryScreen.tscn")

var levels = [
	[load("res://src/levels/spawn/SpawnLevel.tscn")], # 0
	[load("res://src/levels/type_01/01/01.tscn"), load("res://src/levels/type_01/02/02.tscn")], # 1
	[load("res://src/levels/type_01/01/01.tscn"), load("res://src/levels/type_01/02/02.tscn")], # 2
	[load("res://src/levels/boss/bossroom.tscn")], # 3
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
	hearts = 3
	get_tree().change_scene_to(
		levels[0][
			Shortlivedconfig.map_matrix[10][10].r % levels[0].size()
		]
	)
	InputMap
	Soundmanager.stop_all_music()
	Soundmanager.main_music.play()
	
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
	if (Shortlivedconfig.map_matrix[coords.x][coords.y].id == 3):
		Soundmanager.stop_all_music()
		Soundmanager.boss_music.play()
	
	if (Shortlivedconfig.map_matrix[coords.x][coords.y].id == 2 && !Soundmanager.main_music.is_playing()):
		Soundmanager.stop_all_music()
		Soundmanager.main_music.play()
	
	if (Shortlivedconfig.map_matrix[coords.x][coords.y].id == 1 && !Soundmanager.main_music.is_playing()):
		Soundmanager.stop_all_music()
		Soundmanager.main_music.play()
	
	if (Shortlivedconfig.map_matrix[coords.x][coords.y].id == 0 && !Soundmanager.main_music.is_playing()):
		Soundmanager.stop_all_music()
		Soundmanager.main_music.play()
	
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
	
	if (hearts == 0 && is_in_game):
		is_in_game = false
		get_tree().change_scene_to(game_over_screen)

func won_screen():
	is_in_game = false
	get_tree().change_scene_to(victory_screen)

func get_hit():
	hearts -= 1
	emit_signal("get_hit")

func toggle_controller_usage(toggle: bool):
	controller_usage = toggle
#	if (controller_usage == true):
#		# esper - only controller
#		# luffy - take esper controls
#		InputMap.action_erase_events("esper_up")
#		InputMap.action_add_event("esper_up", InputEvent)
