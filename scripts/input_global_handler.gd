# Global input checks e.g. quit game function
extends Node

var lockZ=false
var lockDebug=false

func quitGame():
	if(Input.is_action_pressed("CLOSE_GAME")):
		if(Input.is_key_pressed(KEY_SHIFT) && Input.is_key_pressed(KEY_ESCAPE)):
			get_tree().quit()
		elif(Input.is_key_pressed(KEY_SHIFT) && Input.is_key_pressed(KEY_Q)):
			get_tree().quit()

func changeEffect():
	if(Input.is_key_pressed(KEY_Z) && not lockZ):
		print("Z Pressed")
		GLOBAL_SYS.changeEffect()
		print(GLOBAL_SYS.effect)
	lockZ=Input.is_key_pressed(KEY_Z);
	
func setDebug():
	if(Input.is_key_pressed(KEY_Q) && not lockDebug):
		print("Q Pressed")
		GLOBAL_SYS.debug=!GLOBAL_SYS.debug
	lockDebug=Input.is_key_pressed(KEY_Q);
		
	