tool
extends Node

# =========================================================================
# Handles destruction of the parent node
#
# When `destroy` is called, the parent node gets removed
# and shards are added to the `shard_container`. A `shard_template` is used
# to configure how the `shard_scene` will be converted to `RigidBodies`.
# =========================================================================

export(PackedScene) var shard_template = preload("res://Addons/Destruction/ShardTemplates/ShardTemplate.tscn")
export(PackedScene) var shard_scene
export var shard_container := @"../../" setget set_shard_container

const DestructionUtils = preload("res://Addons/Destruction/DestructionUtils.gd")

# Destroys the parent node and spawns shards in its position.
func destroy() -> void:
	var shards := DestructionUtils.create_shards(shard_scene.instance(), shard_template)
	get_node(shard_container).add_child(shards)
	shards.global_transform = get_parent().global_transform
	get_parent().queue_free()


# Destroys the parent node and spawns shards in its position, the shards
# dispawn after the given amount of time.
func destroy_with_shards(time : int) -> void:
	var shards := DestructionUtils.create_shards(shard_scene.instance(), shard_template)
	get_node(shard_container).add_child(shards)
	shards.global_transform = get_parent().global_transform
	get_parent().queue_free()
	
	var tree_timer := get_tree().create_timer(time)
	tree_timer.connect("timeout", shards, "queue_free")

# =========================================================================
# Utility
# =========================================================================

# Sets the shard container variable.
func set_shard_container(to : NodePath) -> void:
	shard_container = to
	update_configuration_warning()

# Notification behaviour.
func _notification(what : int) -> void:
	if what == NOTIFICATION_PATH_CHANGED:
		update_configuration_warning()

# Configuration warning message.
func _get_configuration_warning() -> String:
	return "The shard container is a PhysicsBody or has a PhysicsBody as a parent. This will make the shards added to it behave in unexpected ways." if get_node(shard_container) is PhysicsBody or _has_parent_of_type(get_node(shard_container), PhysicsBody) else ""

# Util function for determining if there is a parent of the given type.
static func _has_parent_of_type(node : Node, type) -> bool:
	if not node.get_parent():
		return false
	if node.get_parent() is type:
		return true
	return _has_parent_of_type(node.get_parent(), type)
