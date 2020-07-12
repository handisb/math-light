extends AudioStreamPlayer

var config_file = MyConfigurations.new()
var configs = config_file.get_config()
var jingle_song = "res://" + configs["configurations"]["default"]\
					["mathLight"]["audioTracks"]["reward"]

func _ready():
	load_audio(jingle_song, false)

func play_audio(new_song = null):
	# try playing new_song
	if (load_audio(new_song, false)):
		play()
	
	# otherwise play default jingle
	else:
		load_audio(jingle_song, false)
		play()

func load_audio(audio_file, loop):
	var sfx = load(audio_file)
	if (!sfx):
		print("failed to load song")
		return false
	stream = sfx
	return true
