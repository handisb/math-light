extends Node2D
class_name MyConfigurations

# config is the data from the config.json file located in res://config/config.json
var my_configurations = {}

func get_config():
	if my_configurations.empty():
		var json_file = File.new()
		json_file.open("res://config/config.json", File.READ)
		var json = json_file.get_as_text()
		json_file.close()
		my_configurations = JSON.parse(json).result
	return my_configurations

func save_config(save_data):
	if my_configurations.empty():
		get_config()
	my_configurations["configurations"]["saves"].append(save_data)
	
	# convert my_configurations dictionary to json string and write to json file
	var write_str = JSON.print(my_configurations, "    ")	# indent 4 spaces between values
	var file = File.new()
	file.open("res://config/config.json", File.WRITE)
	file.store_string(write_str)
	file.close()
