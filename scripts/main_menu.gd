extends Panel

func _ready():
	set_process(true);
	
	
	
	pass
	

	
func _process(delta):
	
	if(Input.is_key_pressed(KEY_ESCAPE)):
		if(Input.is_key_pressed(KEY_SHIFT)):
			get_tree().quit()
			
			
	if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
		print(str("Mouse Button pressed at: ", get_global_mouse_pos()));
		
	pass