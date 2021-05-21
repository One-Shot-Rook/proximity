extends Control

func _ready():
	var network = NetworkedMultiplayerENet.new()
	network.create_client("127.0.0.1", 4242)
	get_tree().set_network_peer(network)
	network.connect("connection_failed",self,"_on_connection_failed")
	get_tree().multiplayer.connect("network_peer_packet",self,"_on_packet_received")

func _on_connection_failed(error):
	var text = "Error connecting to server " + error
	print(text)

func _on_packet_received(id,packet):
	var data = packet.get_string_from_utf8()
	if data.begins_with("MENU:"):
		data = data.trim_prefix("MENU:")
		get_parent().initialize_menu(data)

func send_order(order):
	var json_data = JSON.print(order)
	get_tree().multiplayer.send_bytes(json_data.to_utf8())
