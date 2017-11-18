extends TextureButton

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	

func _on_p2Button_pressed():
	pressed()
	pass

func pressed():
	print ("P2 Selected")
	GLOBAL_SYS.p1_char=GLOBAL_SYS.P2CHAR;
	GLOBAL_SYS.p2_char=GLOBAL_SYS.P1CHAR;
	TRANSITION.fade_to(GLOBAL_SYS.GAME_SCENE_NAME)