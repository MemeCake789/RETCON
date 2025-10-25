extends GunBehavior

func _ready() -> void:
	# These Deagle-specific properties will override the defaults in GunBehavior.
	damage = 50.0
	recoil_offset = Vector2(-35, 0)
	rotation_speed = 0.5
	mag_size = 8

	# Initialize the ammo based on the new mag size.
	current_ammo = mag_size
	total_ammo = 40


# The _process function is now responsible for handling player input
# and calling the appropriate functions.
func _process(_delta: float) -> void:
	# 1. Always update the gun's visuals to follow the mouse.
	# This function is provided by the GunBehavior base class.
	UpdateGunVisuals(get_global_mouse_position())

	# 2. Check for player input and call the corresponding functions.
	if Input.is_action_just_pressed("Shoot"):
		shoot()

	if Input.is_action_just_pressed("Reload"):
		reload()


# This function calls the PerformShoot tool from GunBehavior.
func shoot() -> void:
	PerformShoot()


# This function calls the PerformReload tool from GunBehavior.
func reload() -> void:
	PerformReload()
