extends Node

var levels = [
	[load("res://src/levels/spawn/SpawnLevel.tscn")], # 0
	[load("res://src/levels/spawn/SpawnLevel.tscn")], # 1
	[load("res://src/levels/spawn/SpawnLevel.tscn")], # 2
	[load("res://src/levels/spawn/SpawnLevel.tscn")], # 3
]

signal load_first_spawn
signal load_room

func _ready():
	randomize()

func begin():
	get_tree().change_scene_to(
		levels[0][
			Shortlivedconfig.map_matrix[10][10].r % levels[0].size()
		]
	)
	
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
