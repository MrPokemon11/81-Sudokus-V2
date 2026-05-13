extends Node

# returns a boolean based on if the given values are identical
func check_equality(input1: String, input2: String) -> bool:
	if (input1.capitalize() == input2.capitalize()):
		return true
	else:
		return false
