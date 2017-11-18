extends Control

var label

func _ready():
	label = get_node("CenterContainer/Label")
	set_process(true)
	pass
	
func _process(delta):
	if(GLOBAL_SYS.matchWonBy=="p1"):
		label.set_text("P1 Won")
	elif(GLOBAL_SYS.matchWonBy=="p2"):
		label.set_text("P2 Won")
	elif(GLOBAL_SYS.matchWonBy=="draw"):
		label.set_text("DRAW")
	
	pass