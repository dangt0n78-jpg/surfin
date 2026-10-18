extends Node

var score :int= 0
var highscore :int= 0
var min_time :float= 1.0
var max_time :float= 2.0
var min_time_marker :float = 2.0
var max_time_marker :float = 5.0
var chaos_mode :bool= false

func _chaos_mode_settings():
	Stats.min_time = 0.1
	Stats.max_time = 0.3
	Stats.min_time_marker = 0.5
	Stats.max_time_marker = 1.0
	Stats.chaos_mode = true

func _normal_mode_settings():
	Stats.min_time = 1.0
	Stats.max_time = 2.0
	Stats.min_time_marker = 2.0
	Stats.max_time_marker = 5.0
	Stats.chaos_mode = false

func _update_high_score():
	if score > highscore:
		highscore = score
