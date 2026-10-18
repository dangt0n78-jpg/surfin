extends Node

var score :int= 0
var highscore :int= 0
var min_time :float= 1.0
var max_time :float= 2.0

func _update_high_score():
	if score > highscore:
		highscore = score
