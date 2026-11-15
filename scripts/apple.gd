extends Area2D

signal collected

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collected_sound: AudioStreamPlayer2D = $CollectedSound
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered(_body: Node2D) -> void:
	animated_sprite_2d.animation = "collected"
	collected_sound.play()
	collected.emit()
	call_deferred("disable_collision")

func disable_collision() -> void:
	collision_shape_2d.disabled = true

func _on_animated_sprite_2d_animation_looped() -> void:
	if animated_sprite_2d.animation == "collected":
		queue_free()
