class_name SI
extends Value


enum UNIT {
	OHM,
	VOLT,
	AMPERE,
}
enum PREFIX {
	TERRA = 12,
	GIGA = 9,
	MEGA = 6,
	KILO = 3,
	NONE = 0,
	MILLI = -3,
	MICRO = -6,
	NANO = -9,
	PICO = -12,
	FEMTO = -15
}
## Dictionary mapping of unit enum to their string represtaion
const UNIT_REPR_DICT := {
	UNIT.OHM: "Ω",
	UNIT.VOLT: "V",
	UNIT.AMPERE: "A"
}
## Dictionary mapping of prefix unit enum to their string represtaion
const PREFIX_REPR_DICT := {
	PREFIX.TERRA: "T",
	PREFIX.GIGA: "G",
	PREFIX.MEGA: "M",
	PREFIX.KILO: "k",
	PREFIX.NONE: "",
	PREFIX.MILLI: "m",
	PREFIX.MICRO: "µ",
	PREFIX.NANO: "n",
	PREFIX.PICO: "p",
	PREFIX.FEMTO: "f"
}
## Just the numerical part of the component value (without the SI unit/prefix)
@export var number : float:
	set = _set_number
## Just the SI unit prefix part of the component value (without the unit)
@export var prefix : PREFIX:
	set = _set_prefix
## SI unit of the component
@export var unit : UNIT
## Whether to only limit to poisitive values
@export var positive_only : bool

## Read-only numerical value in SI unit
var value : float:
	set = _set_value

func _init(
	_number := NAN, 
	_prefix := PREFIX.NONE, 
	_unit := UNIT.OHM,
	_positive_only := false
	):
	self.positive_only = _positive_only
	self.unit = _unit
	self.number = _number
	self.prefix = _prefix


func _to_string():
	# convert upto 2 decimal places
	var number_str := "%.2f" % self.number
	# remove unnecessary 0's.
	if number_str[-1] == "0":
		number_str = number_str.left(-1)
	if number_str[-1] == "0":
		number_str = number_str.left(-2)
	# add spacing and unit
	return (
		number_str + 
		" " + # half-width space
		PREFIX_REPR_DICT[self.prefix] +
		UNIT_REPR_DICT[self.unit]
	)
	

func _set_value(_value : float):
	value = _value
	self.value_changed.emit()
	print_rich(
		"new si unit value: " + 
		"[color=magenta]" +
		_to_string() + 
		"[/color] = " +
		"%.15f" % self.value
	)

# also updates value
func _set_prefix(_prefix : PREFIX):
	prefix = _prefix
	self.value = self.number * 10.0 ** self.prefix
	
func _set_number(_number : float):
	var _prefix = self.prefix
	if self.positive_only and _number <= 0:
		# set to lowest possible positive quantity (e.g. 1 femto)
		_number = 1
		_prefix = PREFIX.values().min()
#	print_rich("from: [color=pink]", self.number, PREFIX_REPR_DICT[self.prefix], "[/color]")
	while absf(_number) >= 1e3-1e-6 and _prefix < PREFIX.values().max():
		_number /= 1e3
		_prefix += 3
#		print("maxi loop: ", self.number, "e", self.prefix)
	# loop to find smaller prefixes	
	while absf(_number) < 1-1e-6 and _prefix > PREFIX.values().min():
		_number *= 1e3
		_prefix -= 3
#		print("mini loop: ", self.number, "e", self.prefix)
	# finally update value in SI unit
#	print_rich("to: [color=cyan]", self.number, PREFIX_REPR_DICT[self.prefix], "[/color]")
	number = _number
	self.prefix = _prefix
