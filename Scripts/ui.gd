extends Control

func _input(event):
	if event.is_action_pressed("enter"):
			get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
