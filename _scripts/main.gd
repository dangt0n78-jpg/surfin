extends Node

@export var SCENES : Array[PackedScene] = []
@onready var player :CharacterBody2D= $Player
@export var star_chance :int= 1
const MERMAID = preload("uid://cksslyoqa5srt")
const SUPER_STAR = preload("uid://by3vc5puq43oc")

func _ready() -> void:
	player.died.connect(_on_player_died)

func _on_player_died():
	Stats._update_high_score()
	$CanvasLayer/highscore.text = "High Score: " + str(Stats.highscore)
	$CanvasLayer/highscore.show()
	$"CanvasLayer/game over".show()
	$CanvasLayer/Button.show()
	$CanvasLayer/Button2.show()
	
func _process(delta: float) -> void:
	$CanvasLayer/Label.text = str(Stats.score)
	


func _on_plank_timer_timeout() -> void:
	$obstacle_path/obstacle_spawn_location.progress_ratio = randf()
	var can_spawn_star :bool= (randi_range(1,5) == star_chance) and $star_timer.timeout
	var can_spawn_mermaid :bool= (Stats.score > 4) or Stats.chaos_mode
	var random_scene :PackedScene= SCENES.pick_random()
	while (random_scene == MERMAID and not can_spawn_mermaid) or (random_scene == SUPER_STAR and not can_spawn_star):
		random_scene = SCENES.pick_random()  
	
	var scenes = random_scene.instantiate()
	scenes.global_position = $obstacle_path/obstacle_spawn_location.global_position
	if scenes.is_in_group("score obstacle"):
		scenes.rotation = $obstacle_path/obstacle_spawn_location.rotation + PI / 2.0
	add_child(scenes)
	$plank_timer.wait_time = randf_range(Stats.min_time, Stats.max_time)


func _on_button_pressed() -> void:
	Stats.score = 0
	Stats.min_time = 1.0
	Stats.max_time = 2.0
	get_tree().reload_current_scene()


func _on_button_2_pressed() -> void:
	Stats._normal_mode_settings()
	get_tree().change_scene_to_file("res://_scenes/menu.tscn")
