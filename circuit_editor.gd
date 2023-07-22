extends Node2D

#@export_range(0, 300, 1, "suffix:px") var grid_step := 160

@onready var res : SI = $Resistor/Resistance

var to_add := 0.0

func _process(_delta):
	if Input.is_action_pressed("ui_up"):
		res.number += 1
		
	if Input.is_action_pressed("ui_down"):
		if is_equal_approx(res.number, 1.0):
			to_add = -1e-3
		else:
			to_add = -1
		res.number += to_add
