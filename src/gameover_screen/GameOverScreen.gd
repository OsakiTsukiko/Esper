extends Control

var main_menu_scene: Resource = load("res://src/main_menu/main_menu.tscn")
onready var menu_click_sound = $MenuClick

func _ready():
	Soundmanager.stop_all_music()
	Soundmanager.menu_music.play()


func _on_Button_pressed():
	menu_click_sound.play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene_to(main_menu_scene)


func _on_Button2_pressed():
	menu_click_sound.play()
	yield(get_tree().create_timer(0.3), "timeout")
	get_tree().quit()
