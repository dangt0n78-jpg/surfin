extends Area2D

@export var pull_force :float= 120.0
@export var circle_color :Color
var center_pos :Vector2
var radius :float= 64.0

func _ready() -> void:
	center_pos = get_viewport_rect().size / 2.0
	var shape = $CollisionShape2D.shape
	radius = shape.radius
	queue_redraw()

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, circle_color)

func _process(delta: float) -> void:
	var to_center:Vector2 = (center_pos - global_position).normalized()
	position += to_center
	queue_redraw()

func _on_body_entered(body: Node2D) -> void:
	body._reverse_orbit()
