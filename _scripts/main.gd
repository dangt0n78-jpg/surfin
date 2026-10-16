extends Node

@export var SCENES : Array[PackedScene] = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/Label.text = str(Stats.score)


func _on_plank_timer_timeout() -> void:
	$obstacle_path/obstacle_spawn_location.progress_ratio = randf()
	var random_scene :PackedScene= SCENES.pick_random()
	var scenes = random_scene.instantiate()
	scenes.global_position = $obstacle_path/obstacle_spawn_location.global_position
	scenes.rotation = $obstacle_path/obstacle_spawn_location.rotation + PI / 2.0
	add_child(scenes)
	$plank_timer.wait_time = randf_range(0.5, 2.5)
