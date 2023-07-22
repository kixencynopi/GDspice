class_name ValueLabel
extends Label
## Whatever Node object is supplied, label will show it's returned value from _to_string()
@export var value : Value#:
#	set(_value):
#		value = _value
#		if value:
#			self.text = str(value)
#			print(value)
##			print(value.value_changed.get_connections())
#		else:
#			self.text = ""
#			print("value set to null")


## Called when the node enters the scene tree for the first time.
func _ready():
		self.text = str(value)
#	if self.get_child_count():
#		value = self.get_child(0)
#		print(value)
#	if value:
#		print(value)
#		self.text = "value.value"
#		value.value_changed.connect(_on_value_changed)
#		print(value.value_changed.get_connections())
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	if value:
#		print(value)
#		print(value.value_changed.get_connections())
		pass
	

func _on_value_changed():
	self.text = str(value)
