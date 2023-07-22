@tool
class_name BoundingBox
extends CollisionShape2D

## Width of a 1x1 tile in pixels
@onready var circuit_editor_grid_step : int = 160#CircuitEditor.grid_step
## Width and height of the rectangular bounding box containing a component
@export var size_in_grid := Vector2i.ONE :
	get:
		var _size_in_grid : Vector2i = shape.size / circuit_editor_grid_step
		shape.size = _size_in_grid * circuit_editor_grid_step
		return _size_in_grid
	set(_size_in_grid):
		size_in_grid = _size_in_grid
		shape.size = size_in_grid * circuit_editor_grid_step
## Position in grid of the rectangular bounding box containing a component
@export var position_in_grid := Vector2i.ZERO :
	get:
		var _position_in_grid : Vector2i = position / circuit_editor_grid_step		
		position = _position_in_grid * circuit_editor_grid_step
		return _position_in_grid
	set(_position_in_grid):
		position_in_grid = _position_in_grid
		position = position_in_grid * circuit_editor_grid_step


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
