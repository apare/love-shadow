vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords) {
	vec4 result = vec4(0,0,0,0);
  float distance = length(texture_coords.xy-0.5)*2;
  int blur = int(smoothstep(0, 1.0, distance) * 5);
  float ratio = 1.0 / ((blur * 2.0 + 1)*(blur * 2.0 + 1.0));

  for (float i= -1 * blur; i <= blur; i++) {
    for (float j= -1 * blur; j <= blur; j++) {
      result += Texel(texture, texture_coords.xy + vec2(i, j) / love_ScreenSize.xy) * ratio;
    }
  }
  
  return result;
}