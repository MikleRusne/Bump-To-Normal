extends Node2D



export var _material: ShaderMaterial;
var output_path;
var strength;
var Image_Size: Vector2;
onready var STI = $ShaderToImage

# Called when the node enters the scene tree for the first time.
# not using yield here because it will decouple it from the signal and might cause problems later
var counter =0;
func _ready():
	var input_path = OS.get_cmdline_args()[0];
	print("loading image:"+ input_path);
	input_path = "res://"+input_path;
	output_path = "res://"+ OS.get_cmdline_args()[1];
	var img = Image.new();
	img.load(input_path);
	var tex = ImageTexture.new();
	tex.create_from_image(img);
	$ShaderToImage/Viewport/Shader.texture = tex;
	Image_Size = Vector2(img.get_width(), img.get_height());
	strength = float(OS.get_cmdline_args()[2]);


func _process(delta):
	if counter==1:
		_material.set_shader_param("strength", strength);
		counter+=1;
		$ShaderToImage.generate_image(_material, Image_Size,1.0, {});
	else:
		counter+=1;

func _on_ShaderToImage_generated():
	print("Saving image")
	var image = STI.get_image();
	image.save_png(output_path)
	get_tree().quit();
