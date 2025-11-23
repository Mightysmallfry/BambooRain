extends Node2D

@export var MovingBackground : Parallax2D

var MouseOffset : Vector2

@export_range(0, 1, 0.01)
var ParallaxStrength : float = 0.05

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	MouseOffset = get_global_mouse_position()
	MovingBackground.scroll_offset = MouseOffset * ParallaxStrength
	
	pass
