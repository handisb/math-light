extends AudioStreamPlayer

var config_file = MyConfigurations.new()
var configs = config_file.get_config()
var jingle_track = "reward"

func _ready():
	load_audio(jingle_track, false)

func play_audio(new_track = null):
	# try playing new_track
	if (load_audio(new_track, false)):
		play()

func load_audio(new_track, loop):
	# handle some edge cases
	if (!new_track):
		print ("Error: new track is empty")
		return false
	if (!new_track in configs["configurations"]["default"]["mathLight"]["audioTracks"]):
		print ("Error: new track not in audio tracks")
		return false
	
	# load audio file to stream
	var audio_file = "res://" + configs["configurations"]["default"]\
				["mathLight"]["audioTracks"][new_track]
	var sfx = load(audio_file)
	if (!sfx):
		print("Error: failed to load new audio track")
		return false
	stream = sfx
	return true
