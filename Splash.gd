extends Control

func _ready():
	$ProgressBar.value = 0
	# ایجاد انیمیشن نرم برای پر شدن نوار
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($ProgressBar, "value", 100, 3.0)
	
	# تغییر متن به صورت مرحله‌ای (اختیاری)
	await get_tree().create_timer(1.0).timeout
	$Label.text = "آماده‌سازی..."
	
	# انتقال به صحنه اصلی بعد از اتمام انیمیشن
	tween.finished.connect(func(): get_tree().change_scene_to_file("res://Main.tscn"))
