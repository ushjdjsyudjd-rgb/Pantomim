extends Control

# ارجاع به گره‌های صحنه
@onready var word_label = $MainPanel/WordLabel
@onready var timer_label = $TopBar/TimerLabel
@onready var score_label = $TopBar/ScoreLabel
@onready var progress_bar = $MainPanel/TimerProgress

func _ready():
	# تنظیم ظاهر نئونی در شروع بازی
	apply_visual_style()
	# شروع اولین دور بازی
	next_round()

func apply_visual_style():
	# ایجاد استایل بنفش/صورتی نئون مشابه عکس
	var style = StyleBoxFlat.new()
	style.bg_color = Color("#1a1a2e") # سرمه‌ای تیره
	style.border_width_left = 4
	style.border_top_width = 4
	style.border_right_width = 4
	style.border_bottom_width = 4
	style.border_color = Color("#ff00ff") # صورتی نئون
	style.corner_radius_top_left = 25
	style.corner_radius_bottom_right = 25
	style.shadow_size = 20
	style.shadow_color = Color(1, 0, 1, 0.2) # سایه ملایم نئونی
	
	$MainPanel.add_theme_stylebox_override("panel", style)

func _process(delta):
	# مدیریت زمان در هر فریم
	if GameManager.time_left > 0:
		GameManager.time_left -= delta
		update_ui()
	else:
		on_time_up()

func update_ui():
	# به‌روزرسانی متن تایمر و امتیاز
	timer_label.text = str(ceil(GameManager.time_left))
	score_label.text = "امتیاز: " + str(GameManager.score)
	
	# به‌روزرسانی نوار پیشرفت (تایمر پر شونده)
	progress_bar.value = (GameManager.time_left / 60.0) * 100
	
	# قرمز شدن تایمر در لحظات آخر
	if GameManager.time_left < 10:
		timer_label.add_theme_color_override("font_color", Color.RED)
	else:
		timer_label.add_theme_color_override("font_color", Color.WHITE)

func next_round():
	# بازنشانی زمان و انتخاب کلمه جدید
	GameManager.time_left = 60
	word_label.text = GameManager.get_random_word()
	
	# انیمیشن ساده برای ظاهر شدن کلمه (Fade
