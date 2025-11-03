extends GunBehavior


func _ready() -> void:
	# damage = 50.0
	# recoil_offset = Vector2(-35, 0)
	# rotation_speed = 0.5
	mag_size = 8

	current_ammo = mag_size
	total_ammo = 40



func _process(_delta: float) -> void:

	UpdateGunVisuals(get_global_mouse_position())

	if Input.is_action_just_pressed("Shoot"):
		shoot()

	if Input.is_action_just_pressed("Reload"):
		reload()


func shoot() -> void:
	PerformShoot()


func reload() -> void:
	PerformReload()
