extends CharacterBody2D


@export var SPEED : float = 200.0
@export var JUMP_VELOCITY : float = -400.0

var is_jumping : bool = false
var jump_time : float = 0.0
var max_jump_time : float = 10.0

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if jump_time < max_jump_time:
			velocity.y += JUMP_VELOCITY * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		jump_time = 0.0

	if Input.is_action_pressed("jump") and is_jumping:
		if jump_time < max_jump_time:
			velocity += get_gravity() * delta
			jump_time += delta
		else:
			is_jumping = false

	if Input.is_action_just_released("ui_accept"):
		is_jumping = false

	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x == 0:
		sprite.play("idle")
	else:
		sprite.play("run")
		if velocity.x > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		
	move_and_slide()
