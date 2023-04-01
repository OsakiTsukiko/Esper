extends Node

var toggle_music: bool = true
var toggle_sfx: bool = true

onready var master_bus = AudioServer.get_bus_index("Master")
onready var music_bus = AudioServer.get_bus_index("Music")
onready var sfx_bus = AudioServer.get_bus_index("SFX")

onready var menu_music = $MenuMusic
onready var main_music = $MainMusic
onready var boss_music = $BossMusic

func stop_all_music():
	for i in get_children():
		i.stop()


func toggle_music(status: bool):
	toggle_music = status
	AudioServer.set_bus_mute(music_bus, !toggle_music)

func toggle_sfx(status: bool):
	toggle_sfx = status
	AudioServer.set_bus_mute(sfx_bus, !toggle_sfx)
