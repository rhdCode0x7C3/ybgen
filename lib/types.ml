(*Decorations*)
type line = { size : float; color : Common.colour }
type d_border = { size : float option; color : Common.colour }

type decoration =
  | Background of Common.colour
  | Underline of line
  | Overline of line
  | Border of d_border
  | Stack of decoration list

(*Particles*)
type particle_common = {
  left_margin : float option;
  right_margin : float option;
  margin : float option;
  font : Common.font option;
  font_shaping : Common.font_shaping option;
  foreground : Common.colour option;
  on_click : string option;
  on_click_left : string option;
  on_click_right : string option;
  on_click_middle : string option;
  on_click_wheel_up : string option;
  on_click_wheel_down : string option;
  on_click_previous : string option;
  on_click_next : string option;
  deco : decoration option;
}

type particle =
  | String of { text : string; max : float option }
  | Empty
  | List of {
      items : particle list;
      left_spacing : float option;
      right_spacing : float option;
      spacing : float option;
    }
  | Items of particle list

type particle_t = { common : particle_common; particle : particle }
