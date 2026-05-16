shader_type canvas_item;

uniform sampler2D screen_texture:hint_screen_texture,repeat_disable,filter_nearest;

void vertex() {
}

void fragment() { 
	// SCREEN_UV is the coordinate of the current pixel.
	vec4 color = texture(screen_texture, SCREEN_UV).rgba;
	color.r = 0.0;
	color.g = 0.0;
	color.b = 0.0;
	color.a = 0.5;
	COLOR.rgba = color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
