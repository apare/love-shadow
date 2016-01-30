extern number lightZ = 0.9;

vec4 effect(vec4 c, Image texture, vec2 texture_coords, vec2 pixel_coords) {
  int center = int(love_ScreenSize.x / 2);
  vec2 lightHeight = vec2(0, 0);
  vec2 height = Texel(texture, texture_coords).rg;
  
  int x = center;
  
  while(int(pixel_coords.x) != x && (lightZ > height.r && lightHeight.r <= height.r || lightZ > height.g && lightHeight.g <= height.g)) {
    number diff = abs(x - pixel_coords.x);
    vec2 currentHeight = Texel(texture, vec2(x / love_ScreenSize.x, texture_coords.y)).rg;
    lightHeight = max(lightHeight, vec2(
      currentHeight.r + diff * (currentHeight.r - lightZ) / abs(float(center - x)),
      currentHeight.g + diff * (currentHeight.g - lightZ) / abs(float(center - x))
    ));
    if(pixel_coords.x > x){
      x++;
    } else {
      x--;
    }
  }
  return vec4(lightZ > height.r && lightHeight.r <= height.r? 1: 0, lightZ > height.g && lightHeight.g <= height.g ? 1: 0, 0, 1);
}