#define PI 3.1415926535897932384626433832795

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords) {
  number distance = abs(texture_coords.x * 2 - 1);
  number angle = texture_coords.y * PI / 2 + PI / 4;
  if(texture_coords.x > 0.5){
    angle += PI / 2;
  }
  vec2 newCoords = vec2(sin(angle), cos(angle)) * distance;
  return vec4(Texel(texture, (newCoords + 1) / 2).r, Texel(texture, (newCoords * -1 + 1) / 2).r ,0,1);
}