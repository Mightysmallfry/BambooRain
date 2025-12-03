extends CharacterBody2D


@export var SPEED : float = 200.0
@export var JUMP_FORCE : float = -350.0

var is_jumping : bool = false
var jump_time : float = 0.0
var max_jump_time : float = 10.0

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# ---------
	# Handle Jump
	# ---------
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# -------
	# Handle Animation
	# -------
	
	if velocity.x == 0:
		sprite.play("idle")
	else:
		sprite.play("run")
		if velocity.x > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		
	move_and_slide()
