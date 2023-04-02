extends Control


onready var main_menu = $Panel/MarginContainer/HBoxContainer/Panel/VBoxContainer
onready var size_menu = $Panel/MarginContainer/HBoxContainer/Panel/VBoxContainer2
onready var options_menu = $Panel/MarginContainer/HBoxContainer/Panel/VBoxContainer3

onready var menu_click_sound = $MenuClick

func _ready():
	Soundmanager.stop_all_music()
	Soundmanager.menu_music.play()

func _on_BeginBTN_pressed():
	main_menu.hide()
	size_menu.show()
	menu_click_sound.play()

func _on_OptionsBTN_pressed():
	main_menu.hide()
	options_menu.show()
	menu_click_sound.play()

func _on_QuitBTN_pressed():
	menu_click_sound.play()
	yield(get_tree().create_timer(0.3), "timeout")
	get_tree().quit()


func _on_BackBTN_pressed():
	main_menu.show()
	size_menu.hide()
	options_menu.hide()
	menu_click_sound.play()

func _on_SizeSmallBTN_pressed():
	menu_click_sound.play()
	Shortlivedconfig.create_map(8, 4)

func _on_SizeMedBTN_pressed():
	menu_click_sound.play()
	Shortlivedconfig.create_map(13, 6)

func _on_SizeLargeBTN_pressed():
	menu_click_sound.play()
	Shortlivedconfig.create_map(20, 10)


func _on_MusicCHBTN_toggled(button_pressed):
	Soundmanager.toggle_music($Panel/MarginContainer/HBoxContainer/Panel/VBoxContainer3/MusicCHBTN.pressed)
	menu_click_sound.play()

func _on_SfxCHBTN_toggled(button_pressed):
	Soundmanager.toggle_sfx($Panel/MarginContainer/HBoxContainer/Panel/VBoxContainer3/SfxCHBTN.pressed)
	menu_click_sound.play()
