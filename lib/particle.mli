type t = { common : common option; particle : particle }
(** The type for a Yambar particle. A particle must contain one of the variants
    defined in [particle], and may optionally contain any of the fields defined
    in [common]. *)

(*Particles*)
and common = {
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

and particle =
  | String of { text : string; max : float option }
  | Empty
  | List of {
      items : particle list;
      left_spacing : float option;
      right_spacing : float option;
      spacing : float option;
    }
  | Items of particle list

(*Decorations*)
and decoration =
  | Background of Common.colour
  | Underline of line
  | Overline of line
  | Border of border
  | Stack of decoration list

and line = { size : float; color : Common.colour }
and border = { size : float option; color : Common.colour }

val to_yaml : t -> Yaml.value
