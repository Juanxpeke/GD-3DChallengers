extends Item

# Called when the player uses the item.
func use() -> void:
	PlayerManager.add_money(100)
