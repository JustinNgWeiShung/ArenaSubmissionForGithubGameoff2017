extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true);
	set_process_input(true);
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _input(event):
	if(event.type == InputEvent.MOUSE_BUTTON):
		if(event.button_index == BUTTON_RIGHT):
				var name = get_node("/root/globals").getPlayerName();
				print(name);
				var power = Globals.get("MAX_POWER_LEVEL");
				print(power);
				get_tree().set_input_as_handled()
	pass
		
func _process(delta):
	if(Input.is_key_pressed(KEY_Z)):
		get_node("/root/globals").currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1);
		
		get_node("/root/globals").setScene("res://stages/main_menu.tscn");
			
	get_node("/root/globals").quitGame();
	pass
