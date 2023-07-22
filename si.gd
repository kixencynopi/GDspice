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
@export var number := NAN
## Just the SI unit prefix part of the component value (without the unit)
@export var prefix := PREFIX.NONE
## SI unit of the component
@export var unit := UNIT.OHM
## Numerical value in SI unit
var value := NAN

func _init(_number := NAN, _prefix := PREFIX.NONE, _unit := UNIT.OHM):
	self.number = _number
	self.prefix = _prefix
	self.unit = _unit
	update_value()


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
	
func update_value():
	self.value_changed.emit()
	self.value = self.number * 10.0 ** self.prefix
	print_rich(
		"new si unit value: ", 
		"[color=magenta]", 
		_to_string(),
		"[/color] = ",
		self.value
	)
	
func update_prefix(_prefix:PREFIX):
	self.prefix = _prefix
	update_value()
	
func update_number(_number:float):
	self.number = _number
#	print_rich("from: [color=pink]", self.number, PREFIX_REPR_DICT[self.prefix], "[/color]")
	while absf(self.number) >= 1e3-1e-6 and self.prefix < PREFIX.values().max():
		self.number /= 1e3
		self.prefix += 3
#		print("maxi loop: ", self.number, "e", self.prefix)
	# loop to find smaller prefixes	
	while absf(self.number) < 1-1e-6 and self.prefix > PREFIX.values().min():
		self.number *= 1e3
		self.prefix -= 3
#		print("mini loop: ", self.number, "e", self.prefix)
	# finally update value in SI unit
#	print_rich("to: [color=cyan]", self.number, PREFIX_REPR_DICT[self.prefix], "[/color]")
	update_value()
