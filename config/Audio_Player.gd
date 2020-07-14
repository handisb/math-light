extends AudioStreamPlayer

var config_file = MyConfigurations.new()
var configs = config_file.get_config()
var mainConfig = preload("res://config/Main_Config.tres")
var jingle_track = "reward"

func _ready():
	load_audio(jingle_track, false)

func play_audio(new_track = null, loop = false):
	# try playing new_track
	if (load_audio(new_track, loop)):
		play()

func load_audio(new_track, loop):
	# handle some edge cases
	if (!new_track):
		print ("Error: new track is empty")
		return false
	
	var trackIndex = mainConfig.musicNames.find(new_track)
	
	if (trackIndex == -1):
		print ("Error: new track not in audio tracks")
		return false
	
	# load audio file to stream
	var audio_file = mainConfig.music[trackIndex]
	var sfx = audio_file
	if (!sfx):
		print("Error: failed to load new audio track")
		return false
	stream = sfx
	return true
