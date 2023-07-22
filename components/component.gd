class_name Component 
extends Area2D



#
### Available types of electrical components
#enum TYPE {
#	RESISTOR,
#	VOLTAGE_SOURCE,
#	CURRENT_SOURCE,
#}
### Dictionary mapping from component type to their corresponding unit
#const unit_dict := {
#	TYPE.RESISTOR: SI.UNIT.OHM,
#	TYPE.VOLTAGE_SOURCE: SI.UNIT.VOLT,
#	TYPE.CURRENT_SOURCE: SI.UNIT.AMPERE,
#}
#
#### Width of a 1x1 tile in pixels
##@onready var circuit_editor_grid_step :int = $"/root/CircuitEditor".grid_step
##
#### Length and Width of bounding box of the electrical component occupied in the grid
##@export var size := Vector2i.ZERO:
###	get:
###		return $BoundingBox.shape.size/circuit_editor_grid_step
##	set(_size):
##		$BoundingBox.shape.size = _size * circuit_editor_grid_step
##		size = _size
#
### Type of component
#@export var type := Component.TYPE.RESISTOR
### Just the numerical value of the quantity (e.g. -3.4)
#@export var numerical_value := 1.0:
#	set(number):
#		if self.si and numerical_value != number:
#			print("changing number of si quantity to ", number)
#			self.si.update_number(number)
#			numerical_value = self.si.number
#			# if number < 1 or number > 1e3, prefix might need updating
#			self.si_unit_prefix = self.si.prefix
#
#@export var si_unit_prefix := SI.PREFIX.KILO:
#	set(prefix):
#		if self.si and si_unit_prefix != prefix:
#			print("changing prefix of si quantity to ", prefix)
#			self.si.update_prefix(prefix)
#			si_unit_prefix = self.si.prefix
#
### SI value, prefix and unit packaged together
#@onready var si := SI.new(
#	self.numerical_value, 
#	self.si_unit_prefix, 
#	unit_dict[self.type]
#)
#
#func _ready():
#	$Value.text = str(self.si)
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
##	if Input.is_action_just_pressed("ui_up"):
##		self.si.number += 1
##	if Input.is_action_just_pressed("ui_down"):
##		self.si.number -= 1
#	pass
#
#
#
