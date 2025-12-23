extends GunBehavior

const FIRE_RATE			= 0.1  # Time between shots in seconds (600 RPM)

var fire_timer: float = 0.0


func _ready() -> void:
	# damage = 50.0
	# recoil_offset = Vector2(-35, 0)
	# rotation_speed = 0.5
	total_ammo = 40
	super()



func _process(_delta: float) -> void:

	UpdateGunVisuals(get_global_mouse_position())

	# Decrease fire timer
	if fire_timer > 0:
		fire_timer -= _delta

	# Automatic firing while holding shoot button
	if Input.is_action_pressed("Shoot") and fire_timer <= 0:
		shoot()
		fire_timer = FIRE_RATE

	if Input.is_action_just_pressed("Reload"):
		reload()


func shoot() -> void:
	PerformShoot()


func reload() -> void:
	PerformReload()
