#define PI 3.1415926535897932384626433832795
extern Image shadowTexture;

vec4 effect(vec4 c, Image texture, vec2 texture_coords, vec2 pixel_coords) {
  vec2 coords = pixel_coords.xy / love_ScreenSize.xy * 2 - 1;
  number distance = length(coords);
  if(distance > 1){
    return vec4(0, 0, 0, 1);
  }
  number angle = mod(atan(coords.y, coords.x) / (PI * 0.5) + 2.5, 1);
  number y = angle;
  
  number shadow = 0;
  
  if(abs(coords.y) > abs(coords.x)) {
    number x = 0;
    if(coords.y < 0){
      shadow = Texel(shadowTexture, vec2(x, y)).r;
    } else{
      shadow = Texel(shadowTexture, vec2(x, y)).g;
    }
  } else {
    number x = 1;
    if(coords.x < 0){
      shadow = Texel(shadowTexture, vec2(x, y)).g;
    } else{
      shadow = Texel(shadowTexture, vec2(x, y)).r;
    }
  }
  return vec4(1 - shadow > distance ? 1 : 0, 0,0,1);
}