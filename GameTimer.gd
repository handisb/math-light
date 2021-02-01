extends Timer

func _process(delta):
	var time_left_value = ceil(self.time_left - 1)
	if time_left_value <= 0:
		time_left_value = 0
	$TimerLabel.text = "Time Left: " + str(time_left_value)
