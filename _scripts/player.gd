extends CharacterBody2D

@export var pull_force :float= 120.0
@export var swirl_force :float= 120.0

@export var minspeed :float = 180.0
@export var maxpspeed :float= 360.0
@export var acceleration :float = 300.0
@export var deceleration :float = 400.0

var invincible_state :bool= false
const GOLDEN_SPIRAL_RATIO = 0.30635
var center_pos :Vector2
var current_speed :float= 0
var orbit_dir :float= 1.0

signal died

func die():
	died.emit()

func _reverse_orbit():
	orbit_dir *= -1.0
	velocity = -velocity * 0.8

func _ready() -> void:
	center_pos = get_viewport_rect().size / 2.0
	current_speed = minspeed


func _physics_process(delta: float) -> void:
	
	var to_center:Vector2 = (center_pos - global_position).normalized()
	var clockwise_tangent :Vector2 = Vector2(to_center.y, -to_center.x) * orbit_dir
	var whirpool_velocity :Vector2= (to_center * pull_force) + (clockwise_tangent * swirl_force)
	
	var player_velocity :Vector2
	if Input.is_action_pressed("action"):
		current_speed = move_toward(current_speed,  maxpspeed, acceleration * delta)
		var golden_spiral_dir: Vector2 = (clockwise_tangent + (-to_center * GOLDEN_SPIRAL_RATIO)).normalized()
		player_velocity = golden_spiral_dir * current_speed
	else:
		current_speed = move_toward(current_speed, minspeed, deceleration * delta)
		velocity = whirpool_velocity
	
	velocity = velocity.move_toward(player_velocity, 600.0 * delta)
	position.x = clamp(position.x, 24.0, 1138.0)
	position.y = clamp(position.y, 31.0, 618.0)
	if invincible_state:
		$Label.show()
		$Label.text = str(int($invincible_timer.time_left))
	move_and_slide()

func _invincible():
	invincible_state = true
	$Sprite2D.hide()
	$invincible.show()
	$invincible_timer.start()


func _on_invincible_timer_timeout() -> void:
	invincible_state = false
	$Label.hide()
	$Sprite2D.show()
	$invincible.hide()
	
