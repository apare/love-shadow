extern Image shadow;

vec4 effect(vec4 c, Image texture, vec2 texture_coords, vec2 pixel_coords) {
  if(texture_coords.x < 0.5){
    vec2 coords = texture_coords * vec2(0.5,1);
    vec2 a = Texel(texture, coords).rg;
    vec2 b = Texel(texture, vec2(0.5 - coords.x, coords.y)).rg;
    return vec4(max(a,b), 0, 1);
  } else {
    vec2 coords = (texture_coords - vec2(0.5, 0)) * vec2(0.5, 1);
    vec2 a = Texel(texture, vec2(1 - coords.x, coords.y)).rg;
    vec2 b = Texel(texture, vec2(0.5 + coords.x, coords.y)).rg;
    return vec4(max(a,b), 0, 1);
  }
}

vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    return transform_projection * vertex_position * vec4(0.5, 1, 0, 1) - vec4(0.5, 0, 0, 0);
}