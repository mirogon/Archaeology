extends TextureButton

func _on_PlayButton_pressed():
	get_tree().get_root().get_node("Main").restart_game()
