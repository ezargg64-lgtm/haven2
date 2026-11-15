extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var alive: bool = true

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

func _physics_process(delta: float) -> void:
	
	if not alive:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = direction < 0
		animated_sprite_2d.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite_2d.play("idle")

	move_and_slide()

func _die() -> void:
	if not alive:
		return
		
	alive = false
	velocity = Vector2.ZERO
	animated_sprite_2d.play("dying")
	
	if death_sound:
		death_sound.play()
