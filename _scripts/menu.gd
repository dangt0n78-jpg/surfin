extends Control

func _on_normal_pressed() -> void:
	Stats._normal_mode_settings()
	get_tree().change_scene_to_file("res://_scenes/main.tscn")


func _on_chaos_pressed() -> void:
	Stats._chaos_mode_settings()
	get_tree().change_scene_to_file("res://_scenes/main.tscn")
