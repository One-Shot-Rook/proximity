extends Control

func _ready():
	var network = NetworkedMultiplayerENet.new()
	network.create_server(4242, 2)
	get_tree().set_network_peer(network)
	
	network.connect("peer_connected",self,"_peer_connected")
	network.connect("peer_disconnected",self,"_peer_disconnected")
	get_tree().multiplayer.connect("network_peer_packet",self,"_on_packet_received")

func _on_packet_received(id,packet):
	var data = packet.get_string_from_utf8()
	$Label.text = $Label.text + "\n" + data
	var jsonParseResult: JSONParseResult = JSON.parse(data)
	var order = jsonParseResult.result
	get_parent().incoming_order(order)

func _peer_connected(id):
	$Label.text = $Label.text + "\nUser " + str(id) + " connected"
	get_node("labelUserCount").text = "Total Users:" + str(get_tree().get_network_connected_peers().size())
	send_menu_data()
  
func _peer_disconnected(id):
	$Label.text = $Label.text + "\nUser " + str(id) + " disconnected"
	get_node("labelUserCount").text = "Total Users:" + str(get_tree().get_network_connected_peers().size())

func send_menu_data():
	print("Sending data to client")
	var menu = JSON.print(Menu.get_menu())
	menu = "MENU:" + menu
	get_tree().multiplayer.send_bytes(menu.to_utf8())
