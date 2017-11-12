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
	TRANSITION.fade_to(get_node("/root/GLOBAL_SYS").GAME_SCENE_NAME)