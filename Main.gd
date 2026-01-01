extends Control

@onready var word_label = $MainPanel/WordLabel
@onready var timer_label = $TopBar/TimerLabel
@onready var progress_bar = $MainPanel/TimerProgress
@onready var score_label = $TopBar/ScoreLabel

func _ready():
    # تنظیمات ظاهری برای ابعاد ۱۲۸۰ در ۷۲۰
    apply_visual_style()
    next_round()

func apply_visual_style():
    var style = StyleBoxFlat.new()
    style.bg_color = Color("#1a1a2e")
    style.border_width_all = 4
    style.border_color = Color("#ff00ff")
    style.corner_radius_top_left = 30
    style.corner_radius_bottom_right = 30
    style.shadow_size = 25
    style.shadow_color = Color(1, 0, 1, 0.2)
    
    $MainPanel.add_theme_stylebox_override("panel", style)

func _process(delta):
    if GameManager.time_left > 0:
        GameManager.time_left -= delta
        update_ui()
    else:
        on_time_up()

func update_ui():
    timer_label.text = str(ceil(GameManager.time_left))
    score_label.text = "امتیاز: " + str(GameManager.score)
    progress_bar.value = (GameManager.time_left / 60.0) * 100

func next_round():
    GameManager.time_left = 60
    word_label.text = GameManager.get_random_word()
    # افکت انیمیشن برای کلمه جدید
    var tween = create_tween()
    word_label.scale = Vector2(0.8, 0.8)
    tween.tween_property(word_label, "scale", Vector2(1.0, 1.0), 0.3).set_trans(Tween.TRANS_BACK)

func on_time_up():
    word_label.text = "وقت تموم شد!"
    if OS.has_feature("mobile"):
        Input.vibrate_handheld(500)

func _on_correct_pressed():
    GameManager.score += 10
    next_round()

func _on_wrong_pressed():
    next_round()
