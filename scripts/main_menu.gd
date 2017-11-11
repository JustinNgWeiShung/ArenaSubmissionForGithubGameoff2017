extends Panel

func _ready():
	set_process(true);
	
	
	
	pass
	

	
func _process(delta):
	_effectCheck()
	
	get_node("/root/GLOBAL_INPUT").quitGame();
	#if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
		#print(str("Mouse Button pressed at: ", get_global_mouse_pos()));
		
	pass
	
func _effectCheck():
	GLOBAL_INPUT.changeEffect();
	
	if(GLOBAL_SYS.effect == 0):
		get_node("overlay").hide()
	else:
		get_node("overlay").show()