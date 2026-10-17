extends Area2D



func _on_body_entered(body: Node2D) -> void:
	body.die()
	body.queue_free()


func _on_alive_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("score obstacle"):
		area.queue_free()
	else:
		return
