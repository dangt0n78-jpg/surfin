extends Area2D

var is_inside :bool= false
var tween :Tween
@export var circle_color :Color= Color(0.2,0.7,1.0,0.0)
var target_alpha :float= 0.0
var radius :float= 64.0

func _ready() -> void:
	var shape = $CollisionShape2D.shape
	radius = shape.radius
	queue_redraw()

func _draw() -> void:
	var current_color = circle_color
	current_color.a = target_alpha
	draw_circle(Vector2.ZERO, radius, current_color)

func _on_body_exited(body: Node2D) -> void:
	if is_inside:
		Stats.score += 1
		is_inside = false
		
		Stats.min_time -= 0.1
		Stats.max_time -= 0.1
		body.pull_force += 10
		body.swirl_force += 10
		
		if body.pull_force > 250.0:
			body.pull_force = 250.0
		
		if body.swirl_force > 250.0:
			body.swirl_force = 250.0
		
		if Stats.min_time < 0.1:
			Stats.min_time = 0.1
			
		if Stats.max_time < 0.3:
			Stats.max_time = 0.3
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_method(func(val:float):
		target_alpha = val
		queue_redraw(), target_alpha,0.0,0.2)



func _on_body_entered(body: Node2D) -> void:
	is_inside = true
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_method(func(val:float):
		target_alpha = val
		queue_redraw(), target_alpha, 0.3,0.2)
