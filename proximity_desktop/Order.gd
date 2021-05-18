extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var table:String
var order:String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func initialize(input_table, input_order):
	table = input_table
	$table.text = table
	order = input_order
	$order_contents.text = order
	var item_timestamp = OS.get_time()
	$timestamp.text = String(item_timestamp["hour"]) + ":" + String(item_timestamp["minute"])

func _on_order_contents_resized():
	var adjust = $order_contents.rect_size[1]
	if adjust < 60:
		adjust = 60
	self.rect_min_size = Vector2(300, 60 + adjust)
