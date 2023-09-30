extends FloatSequencer
class_name WaveSequencer
# Emit a float value aligned with a sin
# wave as defined by the given parameters

# https://www.mathsisfun.com/algebra/amplitude-period-frequency-phase-shift.html
# y = A sin(B(x + C)) + D

# amplitude is A
# period is 2π/B
# horizontal shift (phase shift) is C (positive is to the left)
# vertical shift is D

enum WaveType {SIN, COS}
export(WaveType) var wave_type

export (float) var amplitude = 1.0 #A
export (float) var period = 1.0 #B
export (float) var horizontal_shift #C
export (float) var vertical_shift #D

var current_time = 0.0

func _process(delta):
	current_time += delta
	var raw_value = amplitude * sin(period * (current_time + horizontal_shift)) + vertical_shift
	emit_signal("new_value", raw_value)


func _get_new_raw_value(delta: float) -> float:
	current_time += delta
	var wave_arg = period * (current_time + horizontal_shift)
	var wave_value = 0.0
	match wave_type:
		WaveType.SIN:
			wave_value = sin(wave_arg)
		WaveType.COS:
			wave_value = cos(wave_arg)
			
	var raw_value = amplitude * wave_value + vertical_shift
	return raw_value
