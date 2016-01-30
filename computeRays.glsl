#define PI 3.1415926535897932384626433832795

vec4 effect(vec4 c, Image texture, vec2 texture_coords, vec2 pixel_coords) {
  vec2 coords = texture_coords.xy * 2 - 1;
  number distance = length(coords);
  if(distance > 0.99){
    return vec4(0, 0, 0, 1);
  }
  number angle = mod(atan(coords.y, coords.x) / (PI * 0.5) + 2.5, 1);
  number y = 1 - angle;
  if(abs(coords.y) > abs(coords.x)) {
    number x = (distance + 1) / 2;
    if(coords.y < 0){
      vec4 color = Texel(texture, vec2(x, y));
      return vec4(color.r, 0, 0, 1);
    } else{
      vec4 color = Texel(texture, vec2(x, y));
      return vec4(color.g, 0,0,1);
    }
  } else {
    number x = (1 - distance) / 2;
    if(coords.x < 0){
      vec4 color = Texel(texture, vec2(x, y));
      return vec4(color.g, 0, 0, 1);
    } else {
      vec4 color = Texel(texture, vec2(x, y));
      return vec4(color.r, 0,0,1);
    }
  }
  return vec4(0, 0,0,1);
}