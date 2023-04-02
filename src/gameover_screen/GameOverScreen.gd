extends Control

var main_menu_scene: Resource = load("res://src/main_menu/main_menu.tscn")

func _ready():
	pass


func _on_Button_pressed():
	get_tree().change_scene_to(main_menu_scene)


func _on_Button2_pressed():
	get_tree().quit()
