extends PanelContainer
class_name InventorySlot


@export var type: InventoryItem.Type


# Custom init function so that it doesn't error
func init(t: InventoryItem.Type, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms


# _at_position is not used because it doesn't matter where on the panel
# the item is dropped
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is InventoryItem:
		#This is the text that displays uupon pulling an item out.
		if type == InventoryItem.Type.MAIN:
			if get_child_count() == 0:
				return true
			else:
				# Swap two items
				return get_child(0).type == data.type
		elif type == InventoryItem.Type.LOOK:
				return true
		else:
			return data.type == type
	return false


# _at_position is not used because it doesn't matter where on the panel
# the item is dropped
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if data.type == InventoryItem.Type.LOOK:
		if get_child_count() > 0:
			print (get_child(0).lore)
	else:
		if get_child_count() > 0:
			if get_child(0).type == InventoryItem.Type.LOOK:
				print (data.lore)
				return
			else:
				var item := get_child(0)
				if item == data: return
				remove_child(item)
				data.get_parent().add_child(item)
		data.get_parent().remove_child(data)
		add_child(data)
