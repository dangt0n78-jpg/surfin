extends Marker2D

@export var SPECIAL_SCENES :Array[PackedScene] = []
@export var circle_color :Color
@export var radius :float= 64.0
@export var warning_timer :float= 0.8
@onready var center_pos :Vector2

var tween :Tween
var current_alpha :float= 0.0
var circle_scale :float= 0.0


func _ready() -> void:
	center_pos = get_viewport_rect().size / 2.0

func _draw() -> void:
	if current_alpha > 0.0:
		var fill_color = circle_color
		fill_color.a = current_alpha
		
		draw_circle(Vector2.ZERO, radius * circle_scale, fill_color)
		var outline_circle = circle_color
		outline_circle.a = 0.8
		draw_arc(Vector2.ZERO, radius, 0.0, PI * 2, 32, outline_circle, 2.0)

func _get_valid_spawn_point():
	var pos :Vector2
	var min_dinstance_from_hole :float= 126.0
	
	while true:
		pos.x = randf_range(79.0, 1069.0)
		pos.y = randf_range(91.0, 572.0)
		
		if pos.distance_to(center_pos) >= min_dinstance_from_hole:
			break
	return pos


func _on_timer_timeout() -> void:
	if Stats.score > 3:
		var spawn_pos :Vector2= _get_valid_spawn_point()
		global_position = spawn_pos
		current_alpha = 0.4
		circle_scale = 0.0
		queue_redraw()
		var tween :Tween = create_tween()
		tween.tween_method(func(val : float):
			circle_scale = val
			queue_redraw(), 0.0, 1.0, warning_timer)
		
		await tween.finished
		
		current_alpha = 0.0
		circle_scale = 0.0
		queue_redraw()
		
		var random_speacial_scene :PackedScene= SPECIAL_SCENES.pick_random()
		var special_scene = random_speacial_scene.instantiate()
		get_parent().add_child(special_scene)
		special_scene.global_position = spawn_pos
		$Timer.wait_time = randf_range(0.5, 2.5)
	
