type t = {
  height : float;
  location : [ `Top | `Bottom ];
  background : Common.colour;
  monitor : string option;
  layer : [ `Overlay | `Top | `Bottom | `Background ] option;
  left_spacing : float option;
  right_spacing : float option;
  spacing : float option;
  left_margin : float option;
  right_margin : float option;
  margin : float option;
  border : b_border option;
  font : Common.font option;
  font_shaping : Common.font_shaping option;
  foreground : Common.colour option;
  trackpad_sensitivity : float option;
}

and b_border = {
  left_width : float option;
  right_width : float option;
  top_width : float option;
  bottom_width : float option;
  width : float option;
  color : Common.colour option;
  left_margin : float option;
  right_margin : float option;
  top_margin : float option;
  bottom_margin : float option;
  margin : float option;
}
