extends ColorRect

export (float, 1, 1000) var factor
func _ready():
	pass # Replace with function body.

func update_hp(hp):
	self.anchor_right = hp/factor
