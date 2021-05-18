extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var table:String
var order:String
var status

enum ORDER_STATUS {RECEIVED, STARTED, FINISHED, CANCELLED}

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
	status = ORDER_STATUS.RECEIVED

func set_order_status(value):
	match value:
		ORDER_STATUS.STARTED:
			set_modulate(Color(1,1,0,1))
		ORDER_STATUS.FINISHED:
			set_modulate(Color(0.49,0.99,0,1))
		ORDER_STATUS.CANCELLED:
			set_modulate(Color(0.78,0.08,0.52,1))
	status = value
	print(status)

func _on_order_contents_resized():
	var adjust = $order_contents.rect_size[1]
	if adjust < 60:
		adjust = 60
	self.rect_min_size = Vector2(300, 60 + adjust)
	$togglebtn.rect_size = Vector2(300, 60 + adjust)


func _on_togglebtn_pressed():
	if status == ORDER_STATUS.RECEIVED:
		set_order_status(ORDER_STATUS.STARTED)
	elif status == ORDER_STATUS.STARTED:
		set_order_status(ORDER_STATUS.FINISHED)
