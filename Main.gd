extends Control

@onready var word_label = $MainPanel/WordLabel
@onready var timer_label = $TopBar/TimerLabel
@onready var progress_bar = $MainPanel/TimerProgress

func _ready():
	setup_ui_style()
	next_word()

func setup_ui_style():
	# ایجاد استایل بنفش نئونی شبیه عکس
	var sb = StyleBoxFlat.new()
	sb.bg_color = Color("#1e1e2e")
	sb.set_border_width_all(2)
	sb.border_color = Color("#ff00ff") # صورتی نئون
	sb.corner_radius_top_left = 20
	sb.corner_radius_bottom_right = 20
	sb.shadow_size = 10
	sb.shadow_color = Color(1, 0, 1, 0.2)
	
	$MainPanel.add_theme_stylebox_override("panel", sb)

func next_word():
	word_label.text = GameManager.get_random_word()
	GameManager.time_left = 60
	update_ui()

func _process(delta):
	if GameManager.time_left > 0:
		GameManager.time_left -= delta
		update_ui()
	elif GameManager.time_left <= 0:
		word_label.text = "زمان تمام شد!"

func update_ui():
	timer_label.text = str(ceil(GameManager.time_left))
	progress_bar.value = (GameManager.time_left / 60.0) * 100
