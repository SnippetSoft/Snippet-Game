extends TextureRect
class_name InventoryItem

#Look - Temporary, but to observe items in inventory. Potentially in environment
#Tool - For items that are used, such as keys
#Main - Needs to stay so the blank inventory slots can still function
#If more are needed they can be implemented, but I think this should cover all cases.
enum Type {LOOK, TOOL, MAIN}

@export var type: Type
@export var lore: String
@export var itemName: String

# Custom init function so that it doesn't error
func init(t: Type, i: Texture2D, x: String, s:String) -> void:
	type = t
	itemName = x
	lore = s
	texture = i
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED


# _at_position is not used because it doesn't matter where we click on
# the inventory item.
func _get_drag_data(_at_position: Vector2) -> Variant:
	set_drag_preview(make_drag_preview())
	return self

# displays item and to show it being dragged, but also can display data.
func make_drag_preview() -> TextureRect:
	var t := TextureRect.new()
	# within console, displays "attack" of item with slight delay, do not use for setting text.
	print(itemName)
	t.texture = texture
	t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	t.custom_minimum_size = size
	return t

func _process(_delta):
	return
