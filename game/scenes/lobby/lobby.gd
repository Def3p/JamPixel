extends Node

#func _ready() -> void:
	 ##Clear the viewport.
	#var viewport: SubViewport = $SubViewport
	#viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
#
	 ##Retrieve the texture and set it to the viewport quad.
	#$LobbyView/Lobby_test/ViewPortPanel.material_override.albedo_texture = viewport.get_texture()
