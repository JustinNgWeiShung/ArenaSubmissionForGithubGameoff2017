extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	

func _on_p1Button_pressed():
	pressed()
	
	pass # replace with function body
	
func pressed():
	print ("P1 Selected")
	GLOBAL_SYS.p1_char=GLOBAL_SYS.P1CHAR;
	TRANSITION.fade_to(GLOBAL_SYS.GAME_SCENE_NAME)