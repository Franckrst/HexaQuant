extends StaticBody

export var isClickable = true;

func clicked():
	print("I'm clicked")
	$hover.visible = !$hover.visible 
