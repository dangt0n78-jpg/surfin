extends Area2D

@export var pull_force :float= 120.0
var center_pos :Vector2

func _ready() -> void:
	center_pos = get_viewport_rect().size / 2.0

func _process(delta: float) -> void:
	var to_center:Vector2 = (center_pos - global_position).normalized()
	position += to_center

func _on_body_entered(body: Node2D) -> void:
	if body.invincible_state == false:
		body.die()
		body.queue_free()
