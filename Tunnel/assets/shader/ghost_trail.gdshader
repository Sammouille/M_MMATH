shader_type spatial;
render_mode unshaded, cull_back, depth_draw_opaque;
uniform vec4 ghost_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float ghost_alpha : hint_range(0.0, 1.0) = 1.0;


void fragment() {    // ALBEDO = couleur RGB du pixel (vec3)    ALBEDO = ghost_color.rgb;        // ALPHA = transparence du pixel (float 0-1)    ALPHA = ghost_color.a * ghost_alpha;
	// Called for 
    // ALBEDO = couleur RGB du pixel (vec3)
    ALBEDO = ghost_color.rgb;
    
    // ALPHA = transparence du pixel (float 0-1)
    ALPHA = ghost_color.a * ghost_alpha;
	//EMISSION = ghost_color.rgb;
	
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
