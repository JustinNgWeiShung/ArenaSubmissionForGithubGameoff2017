extends CanvasLayer

# STORE THE SCENE PATH
var path = ""

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
# PUBLIC FUNCTION. CALLED WHENEVER YOU WANT TO CHANGE SCENE
func fade_to(scn_path):
	self.path = scn_path # store the scene path
	get_node("animplayer").play("transition") # play the transition animation

# PRIVATE FUNCTION. CALLED AT THE MIDDLE OF THE TRANSITION ANIMATION
func change_scene():
	print("Scene Change")
	if path != "":
		get_tree().change_scene(path)