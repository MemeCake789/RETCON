extends RigidBody2D

signal damage(amount : float)
signal kill()

@export var health : float = 100.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func Damage(amount : float):
	if health > 0:
		animation_player.seek(0.0,true)
		animation_player.play("hurt")
		health -= amount
	else:
		#kill.emit()
		queue_free()

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass
