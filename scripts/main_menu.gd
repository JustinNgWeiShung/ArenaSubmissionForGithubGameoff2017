extends Panel

func _ready():
	set_process(true);
	
	
	
	pass
	

	
func _process(delta):
	get_node("/root/globals").quitGame();	
			
	if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
		print(str("Mouse Button pressed at: ", get_global_mouse_pos()));
		
	pass