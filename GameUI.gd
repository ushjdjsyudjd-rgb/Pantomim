extends Control

@onready var word_label = $CanvasLayer/WordLabel
@onready var timer_label = $CanvasLayer/TimerLabel
@onready var color_rect = $CanvasLayer/Background

func _ready():
    # آدرس دقیق فایل فونت در مخزن شما
    var my_font = load("res://assets/fonts/Vazir-Regular.ttf")
    
    # اعمال فونت به نمایشگر کلمه
    if my_font:
        word_label.add_theme_font_override("font", my_font)
        timer_label.add_theme_font_override("font", my_font)
        # تنظیم اندازه فونت برای خوانایی بهتر
        word_label.add_theme_font_size_override("font_size", 72)
    else:
        print("خطا: فایل فونت پیدا نشد!")
    
    # شروع اولین کلمه
    show_new_word()

func show_new_word():
    word_label.text = GameManager.get_random_word()
    # ایجاد یک انیمیشن ساده برای عوض شدن کلمه
    var tween = create_tween()
    word_label.scale = Vector2.ZERO
    tween.tween_property(word_label, "scale", Vector2.ONE, 0.5).set_trans(Tween.TRANS_BACK)

func _on_correct_button_pressed():
    GameManager.score += 1
    color_rect.color = Color.GREEN # تغییر لحظه‌ای رنگ پس‌زمینه به سبز
    await get_tree().create_timer(0.2).timeout
    color_rect.color = Color("#2c3e50") # بازگشت به رنگ اصلی
    show_new_word()

func _on_skip_button_pressed():
    color_rect.color = Color.RED # تغییر لحظه‌ای به قرمز
    await get_tree().create_timer(0.2).timeout
    color_rect.color = Color("#2c3e50")
    show_new_word()
