extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var stageLock=false
var p1BarNode
var p2BarNode
var timer = 0.0
var ceilNode

func _ready():
	set_process(true);
	set_process_input(true);
	p1BarNode=get_node("p1VBox/p1Bar")
	p2BarNode=get_node("p2VBox/p2Bar")
	
	ceilNode=get_node("ceil1/collisionShape2d")
	
	#To disable ceiling
	ceilNode.set_trigger(true)

	pass
	
func _input(event):
	
	if(event.type == InputEvent.MOUSE_BUTTON):
		if(event.button_index == BUTTON_RIGHT):
			var name = GLOBAL_SYS.getPlayerName();
			print(name);
			var power = Globals.get("MAX_POWER_LEVEL");
			print(power);
			get_tree().set_input_as_handled()
	pass
		
func _process(delta):
	
	timer += delta
	if timer >= 1.0:
		timer = 0.0
		var value = p1BarNode.get_value()
		p1BarNode.set_value(value-1)
		
		if (value - 1) == 0:
			p1BarNode.set_value(100);
			
		var value2 = p2BarNode.get_value()
		p2BarNode.set_value(value2-1)
		
		if (value2 - 1) == 0:
			p2BarNode.set_value(100);
	
	
	
	_effectCheck()
	
	if(Input.is_key_pressed(KEY_M) && !stageLock):
		print("Test M")
		GLOBAL_SYS.currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1);
		GLOBAL_SYS.setScene(GLOBAL_SYS.CHAR_SELECT_SCENE_NAME);
	
	stageLock=Input.is_key_pressed(KEY_M)
	
	GLOBAL_INPUT.quitGame();
	pass

func _effectCheck():
	GLOBAL_INPUT.changeEffect();
	
	if(GLOBAL_SYS.effect == 0):
		get_node("overlay").hide()
	else:
		get_node("overlay").show()
		
