extends MeshInstance3D

var player_chair: PlayerChair

func interaction(pl):
	player_chair = pl
	pl.is_tab = !pl.is_tab
