extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -850.0

var alive: bool = true

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

func _physics_process(delta: float) -> void:
	if not alive:
		return

	# Apply gravity and handle air animation
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jumping"

	# Handle jump input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	# Handle horizontal movement and idle/run animations
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.animation = "running" if is_on_floor() else "jumping"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animated_sprite_2d.animation = "idle"

	move_and_slide()

	# Flip sprite based on movement direction
	if direction == 1:
		animated_sprite_2d.flip_h = false
	elif direction == -1:
		animated_sprite_2d.flip_h = true

func die() -> void:
	death_sound.play()
	animated_sprite_2d.animation = "dying"
	alive = false
