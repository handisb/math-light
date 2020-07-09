extends Timer

func _process(delta):
	$TimerLabel.text = str(ceil(self.time_left))
