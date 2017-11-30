extends Node

const BUTTON_PRESSED_SHADER = preload('res://button_pressed.tres')
const MAXIMUM_TRHESHOLD = 1.0
const INITIAL_THRESHOLD = 0.1
const ANIMATION_DURATION = 1.0
const SHADE_FACTOR = -0.1
const BUTTON_ANIMATION_NAME = 'button_animation_name'
const TWEEN_NODE_NAME = 'tween_node_name'

func attach(button):
  var tween_node = Tween.new()
  var shader_material = BUTTON_PRESSED_SHADER.duplicate()
  var this = self.duplicate()

  tween_node.set_name(TWEEN_NODE_NAME)

  this.set_name(BUTTON_ANIMATION_NAME)
  this.set_meta('shader_material', shader_material)

  button.add_child(tween_node)
  button.add_child(this)
  button.set_material(shader_material)
  button.connect('pressed', self, 'pressed', [button])

func pressed(button):
  var mouse_position = (button.get_global_mouse_pos() - button.get_global_pos()) / button.get_size()
  var this = button.get_node(BUTTON_ANIMATION_NAME)
  var tween_node = button.get_node(TWEEN_NODE_NAME)
  var shader_material = this.get_meta('shader_material')

  shader_material.set_shader_param('mouse_position', mouse_position)
  tween_node.interpolate_method(this, 'animate_shader', INITIAL_THRESHOLD, MAXIMUM_TRHESHOLD, ANIMATION_DURATION, Tween.TRANS_SINE, Tween.EASE_OUT)
  tween_node.start()

func animate_shader(value):
  var shader_material = self.get_meta('shader_material')

  shader_material.set_shader_param('length_threshold', value)
  shader_material.set_shader_param('shade_factor', SHADE_FACTOR * (MAXIMUM_TRHESHOLD - value))