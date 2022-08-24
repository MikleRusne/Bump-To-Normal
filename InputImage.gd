extends Node2D

onready var _TRect = $"%TextureRect"
onready var _Camera = $"%Camera2D"
var output_path = "";
var _counter =0;
onready var viewport = $"%Viewport"
func _ready():
	var input_path = OS.get_cmdline_args()[1];
	print("loading image:"+ input_path);
	input_path = "res://"+input_path;
	output_path = OS.get_cmdline_args()[2];
	var img = Image.new();
	img.load(input_path);
	#OS.set_window_size(Vector2(img.get_width(),img.get_height()))
	viewport.set_size_override(true,Vector2(img.get_width(), img.get_height()));

	var tex = ImageTexture.new();
	tex.create_from_image(img);
	_TRect.texture = tex;


func _process(delta):
	if(_counter==3):
		print("Creating the image");
		var data = get_viewport().get_texture().get_data();
		data.save_png(output_path);
		var camdata = _Camera.get_viewport().get_texture().get_data();
		camdata.save_png("res://camdata.png")
		_counter+=1;
		#get_tree().quit();
	else:
		_counter+=1;
