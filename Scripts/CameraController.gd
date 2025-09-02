extends Camera2D
const SMOOTHING : int = 5
const STRENGTH : int = 4

var previous_velocity : Vector2 = Vector2.ZERO # Velocity of last frame

func _ready() -> void:
	pass # Replace with function body.

 
func _process(delta: float) -> void:
	MouseCameraOffset(delta)
	PlayerSpeedCameraTilt(delta)

func PlayerSpeedCameraTilt(delta: float):
	var player = get_parent()
	if player and player.has_method("get_velocity"):
		var player_velocity = player.velocity
		print(player_velocity)
		
		var velocity_change = player_velocity - previous_velocity

		var rotation_strength = 0.01 
		var target_rotation = -velocity_change.x * rotation_strength
		rotation = lerp_angle(rotation, target_rotation, delta * 0.5) 
		
		previous_velocity = player_velocity

func MouseCameraOffset(delta: float):
	var mouse_position = get_viewport().get_mouse_position()
	var viewport_center = get_viewport().size / 2.0
	var target_offset = (Vector2(mouse_position) - viewport_center) / STRENGTH
	offset = offset.lerp(target_offset, SMOOTHING * delta)
