extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	


func _on_Button_pressed():
	print ("Hello")
	transition.fade_to("res://stages/game.tscn")
	
	pass # replace with function body
