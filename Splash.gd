extends Control

func _ready():
	$ProgressBar.value = 0
	var tween = create_tween()
	# پر شدن نوار در ۲ ثانیه
	tween.tween_property($ProgressBar, "value", 100, 2.0)
	# بعد از اتمام، رفتن به صحنه اصلی
	tween.finished.connect(func(): get_tree().change_scene_to_file("res://Main.tscn"))
