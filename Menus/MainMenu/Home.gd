extends Control

func _process(delta):
	pass

func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Menus/Options/Options.tscn")

func _on_quit_game_pressed():
	get_tree().quit()
