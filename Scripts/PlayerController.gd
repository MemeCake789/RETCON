extends CharacterBody2D

const INITIAL_SPEED 		= 300.0
const MAX_SPEED 			= 600.0
const GROUND_ACCELERATION 	= 2200.0
const GROUND_DECELERATION 	= 1800.0
const AIR_ACCELERATION 		= 1500.0
const AIR_DECELERATION 		= 400.0
const JUMP_VELOCITY 		= -800.0
const JUMP_BUFFER_TIME 		= 0.2  
const COYOTE_TIME 			= 0.2
const BHOP_SPEED_BOOST 		= 100.0

var current_speed = INITIAL_SPEED
var jump_buffer_timer = 0.0
var coyote_timer = 0.0
var was_on_floor = false

func _physics_process(delta: float) -> void:
	Gravity(delta)
	HandlePlayerMovement(delta)

func HandlePlayerMovement(delta: float):
	CoyoteTimeCheck(delta)
	JumpBufferCheck(delta)

	# Execute jump if buffered and on the floor or in coyote time.
	if jump_buffer_timer > 0 and (is_on_floor() or coyote_timer > 0):
		BHOPCheck()
		
		velocity.y = JUMP_VELOCITY
		jump_buffer_timer = 0.0  # Consume buffer
		coyote_timer = 0.0 # Consume coyote time

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Move_Left", "Move_Right")
	
	var acceleration = GROUND_ACCELERATION if is_on_floor() else AIR_ACCELERATION
	var deceleration = GROUND_DECELERATION if is_on_floor() else AIR_DECELERATION
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * current_speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)

	# Decelerate current_speed to initial_speed when on the ground
	if is_on_floor():
		current_speed = move_toward(current_speed, INITIAL_SPEED, GROUND_DECELERATION * delta)

	was_on_floor = is_on_floor()
	
	move_and_slide()

func CoyoteTimeCheck(delta: float):
	if was_on_floor and not is_on_floor():
		coyote_timer = COYOTE_TIME
	
	if coyote_timer > 0:
		coyote_timer -= delta

func Gravity(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
func BHOPCheck():
	# Check for bhop
	if is_on_floor():
		current_speed = min(current_speed + BHOP_SPEED_BOOST, MAX_SPEED)


func JumpBufferCheck(delta: float):
	# Update jump buffer timer
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

	# Handle jump input.
	if Input.is_action_just_pressed("Jump"):
		jump_buffer_timer = JUMP_BUFFER_TIME

func get_player_velocity() -> Vector2:
	return velocity
