extends Control


onready var main_menu = $Panel/MarginContainer/HBoxContainer/Panel/VBoxContainer
onready var size_menu = $Panel/MarginContainer/HBoxContainer/Panel/VBoxContainer2

func _ready():
	pass


func _on_BeginBTN_pressed():
	main_menu.hide()
	size_menu.show()


func _on_QuitBTN_pressed():
	get_tree().quit()
	pass


func _on_BackBTN_pressed():
	main_menu.show()
	size_menu.hide()


func _on_SizeSmallBTN_pressed():
	Shortlivedconfig.create_map(8, 4)


func _on_SizeMedBTN_pressed():
	Shortlivedconfig.create_map(13, 6)


func _on_SizeLargeBTN_pressed():
	Shortlivedconfig.create_map(20, 10)
