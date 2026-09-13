extends Control


func _ready() -> void:
	hide()

# show game over screen for 3sec 
func _on_player_death_signal() -> void:
	show()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://shape-fight/Scenes/ui.tscn")
