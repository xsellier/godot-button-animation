extends Control

onready var animate_button_singleton = get_node('/root/button_animation')
onready var button = get_node('button')

func _ready():
  animate_button_singleton.attach(button)
