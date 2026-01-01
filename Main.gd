extends Control

@onready var word_label = $WordLabel
@onready var timer_label = $TimerLabel
@onready var bg = $Background

func _ready():
    # اتصال دکمه‌ها
    $CorrectButton.pressed.connect(_on_correct_pressed)
    $SkipButton.pressed.connect(_on_skip_pressed)
    
    # تنظیم فونت
    var f = load("res://assets/fonts/Vazir-Regular.ttf")
    if f:
        word_label.add_theme_font_override("font", f)
        timer_label.add_theme_font_override("font", f)
    
    start_new_game()

func start_new_game():
    GameManager.time_left = 60
    GameManager.score = 0
    next_word()
    
    var timer = Timer.new()
    add_child(timer)
    timer.wait_time = 1.0
    timer.timeout.connect(func():
        if GameManager.time_left > 0:
            GameManager.time_left -= 1
            timer_label.text = str(GameManager.time_left)
        else:
            word_label.text = "وقت تمام! امتیاز: " + str(GameManager.score)
            timer.stop()
    )
    timer.start()

func next_word():
    word_label.text = GameManager.get_random_word()

func _on_correct_pressed():
    if GameManager.time_left > 0:
        GameManager.score += 1
        flash_bg(Color.GREEN)
        next_word()

func _on_skip_pressed():
    if GameManager.time_left > 0:
        flash_bg(Color.RED)
        next_word()

func flash_bg(color):
    var tw = create_tween()
    tw.tween_property(bg, "color", color, 0.1)
    tw.tween_property(bg, "color", Color("#1e1e2e"), 0.2)
