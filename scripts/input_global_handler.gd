# Global input checks e.g. quit game function
extends Node

var lockZ=false;

func quitGame():
	if(Input.is_key_pressed(KEY_ESCAPE)):
		if(Input.is_key_pressed(KEY_SHIFT)):
			get_tree().quit()

func changeEffect():
	if(Input.is_key_pressed(KEY_Z) && not lockZ):
		GLOBAL_SYS.changeEffect()
		print(GLOBAL_SYS.effect)
	
	lockZ=Input.is_key_pressed(KEY_Z);