extends ColorRect


func chromatic_abb():
	visible = true
	self.get_material().set_shader_param("offset", 5);
	$ShaderTimer.start()
	

func _on_ShaderTimer_timeout():
	self.get_material().set_shader_param("offset", 0);
	visible = false
