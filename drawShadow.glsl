extern number lightZ = 0.9;

vec4 effect(vec4 c, Image texture, vec2 texture_coords, vec2 pixel_coords) {
  number height = Texel(texture, texture_coords).r;
  if(height >= lightZ){
    return vec4(0, 0, 0, 1);
  }
  vec2 direction = texture_coords * 2 - 1;
  number distance = length(direction);
  if(distance >= 0.80){
    return vec4(0, 0, 0, 1);
  }
  number nbStep = distance * love_ScreenSize.x / 2;
  direction = -direction / 2 / nbStep ;
  number step = 0;
  while(step < nbStep){
    vec2 stepCoords = texture_coords + direction * step;
    number stepHeight = Texel(texture, stepCoords).r;
    if(stepHeight >= lightZ){
      return vec4(0, 0, 0, 1);
    }
    number stepDistance = 1 - ( step / nbStep);
    if(height < clamp((stepHeight - lightZ) / stepDistance + lightZ, 0, 1)){
      return vec4(0, 0, 0, 1);
    }
    step++;
  }
  return vec4(1, 0, 0, 1);
}