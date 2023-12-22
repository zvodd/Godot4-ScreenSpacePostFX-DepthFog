extends ColorRect
# Simple Fade In effect using Canavas
# Fog is implimented with a Mesh placed infront of the Camera in a specific configuration.

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, 1.0, 0.0, 2)
	
func set_shader_value(value: float):
	material.set_shader_parameter("black_amount", value)
	
