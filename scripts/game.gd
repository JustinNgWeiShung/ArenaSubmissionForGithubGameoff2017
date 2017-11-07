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
			set_pos(Vector2(event.x,event.y))
			get_tree().set_input_as_handled()
	pass
		
func _process(delta):
	if(Input.is_key_pressed(KEY_ESCAPE)):
		if(Input.is_key_pressed(KEY_SHIFT)):
			get_tree().quit()
	pass
