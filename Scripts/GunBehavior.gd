extends Node2D

class_name GunBehavior

# --- Node References ---
@onready var gun_sprite:       Sprite2D        = $GunSprite
@onready var gun_flash:        Sprite2D        = $Gun_Flash
@onready var gun_raycast:      RayCast2D       = $RayCast2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# --- Gun Stats ---
@export_group("Stats")
@export var damage			: float		= 20.0
@export var recoil_offset	: Vector2	= Vector2(-15,0)


# --- Mouse Behavior ---
@export_group("Mouse Behavior")
@export var max_offset		: Vector2 	= Vector2(70, 0)  # How far the gun moves towards the mouse.
@export var max_distance	: float 	= 400.0 # How far the mouse needs to be to reach max_offset.
@export var rotation_speed	: float 	= 0.6   # How quickly the gun rotates towards the mouse.
@export var offset_speed	: float 	= 0.3   # How quickly the gun moves into position.


# --- Ammunition ---
@export_group("Ammunition")
@export var mag_size		: int		= 7
var current_ammo	: int
var total_ammo		: int		= 35


# --- State Variables ---
var is_reloading	: bool		= false
var can_shoot		: bool		= true


func _ready() -> void:
	current_ammo = mag_size

func UpdateGunVisuals(mouse_position: Vector2) -> void:
	_ApplyRotation(mouse_position)
	_ApplyOffset(mouse_position)

func PerformShoot() -> void:
	if not can_shoot or is_reloading or current_ammo <= 0:
		return

	var collider = gun_raycast.get_collider()
	_ApplyDamage(collider)
	_PlayShootEffects()
	_ApplyRecoil()

	current_ammo -= 1

func PerformReload() -> void:
	if is_reloading or current_ammo == mag_size or total_ammo <= 0:
		return

	is_reloading = true
	animation_player.play("reload")
	await animation_player.animation_finished # This pauses execution until the animation is done.

	var ammo_to_reload = mag_size - current_ammo
	var ammo_available = min(ammo_to_reload, total_ammo)

	current_ammo += ammo_available
	total_ammo -= ammo_available

	is_reloading = false

func _ApplyRotation(mouse_position: Vector2) -> void:
	var target_dir: float = (mouse_position - global_position).angle()
	rotation = lerp_angle(rotation, target_dir, rotation_speed)

	var normalized_degrees = fmod(fmod(rotation_degrees, 360.0) + 360.0, 360.0)
	var is_flipped = (normalized_degrees > 90 and normalized_degrees < 270)
	gun_sprite.flip_v = is_flipped
	gun_flash.flip_v  = is_flipped


func _ApplyOffset(mouse_position: Vector2) -> void:
	var distance_to_mouse = global_position.distance_to(mouse_position)
	var offset_ratio = clamp(distance_to_mouse / max_distance, 0.0, 1.0)
	var target_offset = max_offset * offset_ratio

	gun_sprite.position = lerp(gun_sprite.position, target_offset, offset_speed)


func _ApplyRecoil() -> void:
	gun_sprite.position += recoil_offset


func _ApplyDamage(body) -> void:
	if body and body.is_in_group("Enemy") and body.has_method("Damage"):
		body.Damage(damage)


func _PlayShootEffects() -> void:
	animation_player.seek(0.0, true)
	animation_player.play("gun_flash")
