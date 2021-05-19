extends Panel

var rng = RandomNumberGenerator.new()

var load_order = preload("res://Order.tscn")

var title:String = "placeholder" setget set_title, get_title

func set_title(value) -> bool:
	if typeof(value) != TYPE_STRING:
		return false
	title = value
	self.name = title
	$Title.text = title
	return true

func get_title() -> String:
	return title

func _ready():
	rng.randomize()

func spawn_order():
	var order = load_order.instance()
	order.initialize("test" + String(rng.randi_range(1,100)),"Coke:\n- no ice\n- lemon\nSteak:\n- medium rare")
	$scrollC/vbox.add_child(order)

func order_received(content):
	if content.empty():
		return
	var order = load_order.instance()
	order.initialize("test" + String(rng.randi_range(1,100)),content)
	$scrollC/vbox.add_child(order)
