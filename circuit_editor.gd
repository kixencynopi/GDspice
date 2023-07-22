extends Node2D

#@export_range(0, 300, 1, "suffix:px") var grid_step := 160

@onready var res : SI = $Resistor/Resistance
#
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		res.update_number(res.number + 1)
	if Input.is_action_pressed("ui_down"):
		res.update_number(res.number - 1)
