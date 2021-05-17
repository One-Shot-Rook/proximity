extends MenuButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var item_name:String
var item_amount:int
var item_timestamp

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func initialize(input_name, input_amount):
	item_name = input_name
	$name.text = item_name
	item_amount = input_amount
	$amount.text = "x" + str(input_amount)
	item_timestamp = OS.get_time()
	$timestamp.text = String(item_timestamp["hour"]) + ":" + String(item_timestamp["minute"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
