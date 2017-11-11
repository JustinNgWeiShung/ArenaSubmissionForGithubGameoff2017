# Global System functions
extends Node

var currentScene = null
var PlayerName = "Mike"

var effect = 0;

func getPlayerName():
	return PlayerName;
	
func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1);
	Globals.set("MAX_POWER_LEVEL",9000)
	
func setScene(scenePath):
	currentScene.queue_free()
	var s = ResourceLoader.load(scenePath)
	currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)

func changeEffect():
	effect+=1;
	if(effect>2):
		effect=0;