extends Node
class_name ButtonAnimation

export(ShaderMaterial) var shader_material
export(float) var MAXIMUM_TRHESHOLD = 1.0
export(float) var INITIAL_THRESHOLD = 0.1
export(float) var ANIMATION_DURATION = 1.0
export(float) var SHADE_FACTOR = -0.1

var tween := Tween.new()
onready var parent: Control = get_parent()
	
func _ready() -> void:
	shader_material = shader_material.duplicate()
	add_child(tween)
	parent.set_material(shader_material)
	parent.connect("gui_input", self, '_on_clicked')

func _on_clicked(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var mouse_position = (parent.get_global_mouse_position() - parent.get_global_position()) / parent.get_rect().size
		shader_material.set_shader_param('mouse_position', mouse_position)
		tween.interpolate_method(self, '_animate_shader', INITIAL_THRESHOLD, MAXIMUM_TRHESHOLD, ANIMATION_DURATION, Tween.TRANS_SINE, Tween.EASE_OUT)
		tween.start()

func _animate_shader(value):
	shader_material.set_shader_param('length_threshold', value)
	shader_material.set_shader_param('shade_factor', SHADE_FACTOR * (MAXIMUM_TRHESHOLD - value))
