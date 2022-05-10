tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("Destruction", "Node", load("res://Addons/Destruction/Destruction.gd"), load("res://Addons/Destruction/destruction_icon.svg"))


func _exit_tree():
	remove_custom_type("Destruction")

