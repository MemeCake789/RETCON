extends Node2D

@onready var gun_sprite: Sprite2D = $GunSprite
@onready var gun_raycast: RayCast2D = $GunSprite/RayCast2D

# max_offset is the max distance that the gun can go, 
# and max_distance is how far the mouse has to be from the gun to reach the max_offset value.

@export var max_offset		: Vector2 	= Vector2(70, 0)
@export var max_distance	: float 	= 400.0
@export var rotation_speed	: float 	= 0.6

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	
	
	apply_rotation(mouse_pos)
	apply_offset(mouse_pos)
	
	if Input.is_action_just_pressed("Shoot"):
		var coliding_item = gun_raycast.get_collider()
		handle_shoot(coliding_item)
		
func apply_offset(mouse_position: Vector2) -> void:
	var distance_to_mouse = global_position.distance_to(mouse_position)
	var offset_ratio = clamp(distance_to_mouse / max_distance, 0.0, 1.0)
	gun_sprite.position = lerp(Vector2.ZERO, max_offset, offset_ratio)

func apply_rotation(mouse_position: Vector2) -> void:
	var target_dir: float = (mouse_position - global_position).angle()
	rotation = lerp_angle(rotation, target_dir, rotation_speed)
		
	#flip da gun if its on the left side of player
	var normalized_degrees = fmod(fmod(rotation_degrees, 360.0) + 360.0, 360.0)
	gun_sprite.flip_v = (normalized_degrees > 90 and normalized_degrees < 270)

	#print(normalized_degrees, rotation_degrees)

func handle_shoot(body) -> void:
	$AnimationPlayer.play("gun_flash")
	if body and body.is_in_group("Enemy"):
		body.queue_free()
	
