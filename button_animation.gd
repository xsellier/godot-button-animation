extends Node

const BUTTON_PRESSED_SHADER = preload('res://button_pressed.tres')
const MAXIMUM_TRHESHOLD = 1.0
const INITIAL_THRESHOLD = 0.1
const ANIMATION_DURATION = 1.0
const SHADE_FACTOR = -0.1

func attach(button):
  var tween_node = Tween.new()
  var shader_material = BUTTON_PRESSED_SHADER.duplicate()

  button.add_child(tween_node)
  button.set_material(shader_material)
  button.connect('pressed', self, 'pressed', [button, shader_material, tween_node])

func pressed(button, shader_material, tween_node):
  var mouse_position = (button.get_global_mouse_pos() - button.get_global_pos()) / button.get_size()
  var this = self.duplicate()
 
  this.set_meta('shader_material', shader_material)
  shader_material.set_shader_param('mouse_position', mouse_position)

  tween_node.interpolate_method(this, 'animate_shader', INITIAL_THRESHOLD, MAXIMUM_TRHESHOLD, ANIMATION_DURATION, Tween.TRANS_SINE, Tween.EASE_OUT)
  tween_node.start()

func animate_shader(value):
  var shader_material = self.get_meta('shader_material')

  shader_material.set_shader_param('length_threshold', value)
  shader_material.set_shader_param('shade_factor', SHADE_FACTOR * (MAXIMUM_TRHESHOLD - value))
