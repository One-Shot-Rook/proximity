extends Control

func _ready():
	var network = NetworkedMultiplayerENet.new()
	network.create_server(4242, 2)
	get_tree().set_network_peer(network)
	
	network.connect("peer_connected",self,"_peer_connected")
	network.connect("peer_disconnected",self,"_peer_disconnected")
	get_tree().multiplayer.connect("network_peer_packet",self,"_on_packet_received")

func _on_packet_received(id,packet):
	var content = packet.get_string_from_ascii()
	$Label.text = $Label.text + "\n" + content
	get_parent().incoming_order(content.split("#")[0], content.split("#")[1])

func _peer_connected(id):
	$Label.text = $Label.text + "\nUser " + str(id) + " connected"
	get_node("labelUserCount").text = "Total Users:" + str(get_tree().get_network_connected_peers().size())
  
func _peer_disconnected(id):
	$Label.text = $Label.text + "\nUser " + str(id) + " disconnected"
	get_node("labelUserCount").text = "Total Users:" + str(get_tree().get_network_connected_peers().size())

func _on_buttonSendData_pressed():
	print("Sending data to client")
	var textToSend = get_parent().get_node("textToSend").text
	get_tree().multiplayer.send_bytes(textToSend.to_ascii())
