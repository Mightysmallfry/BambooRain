extends Camera2D


@export var follow_speed : float = 3.0
var actual_cam_pos : Vector2
var cam_subpixel_offset : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_current()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Move camera smoothing
	actual_cam_pos = actual_cam_pos.lerp($"../Player".global_position, delta * follow_speed)

	# Calculate the distance from pixel perfect and the camera's current position
	cam_subpixel_offset = actual_cam_pos.round() - actual_cam_pos
	
	# Send the offset to the shader
	Singleton.viewport_container.material.set_shader_parameter("cam_offset", cam_subpixel_offset)
	
	# Set camera position
	global_position = actual_cam_pos.round()
