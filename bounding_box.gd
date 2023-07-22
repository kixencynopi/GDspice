@tool
class_name BoundingBox
extends CollisionShape2D

## Width of a 1x1 tile in pixels
@onready var circuit_editor_grid_step : int = 160#CircuitEditor.grid_step
## Width and height of the rectangular bounding box containing a component
@export var size_in_grid := Vector2i.ONE :
	get:
		return shape.size / circuit_editor_grid_step
	set(size_in_grid):
		shape.size = size_in_grid * circuit_editor_grid_step
## Position in grid of the rectangular bounding box containing a component
@export var position_in_grid := Vector2i.ZERO :
	get:
		return position / circuit_editor_grid_step
	set(position_in_grid):
		position = position_in_grid * circuit_editor_grid_step


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
