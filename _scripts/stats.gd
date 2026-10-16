extends Node

var score :int= 0
var highscore :int= 0

func _update_high_score():
	if score > highscore:
		highscore = score
