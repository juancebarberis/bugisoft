extends ColorRect


func chromatic_abb():
	self.get_material().set_shader_param("offset", 25);
	$ShaderTimer.start()
	



func _on_ShaderTimer_timeout():
	self.get_material().set_shader_param("offset", 0);
