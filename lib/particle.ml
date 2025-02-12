type t = { common : common option; particle : particle }

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

let yaml_of_line (l : line) : Yaml.value =
  `O [ ("size", `Float l.size); ("color", Common.yaml_of_colour l.color) ]

let yaml_of_d_border (b : border) : Yaml.value =
  `O
    (List.filter_map
       (fun x -> x)
       [
         Option.map (fun s -> ("size", `Float s)) b.size;
         Some ("color", Common.yaml_of_colour b.color);
       ])

let rec yaml_of_decoration (d : decoration) : Yaml.value =
  match d with
  | Background v -> `O [ ("background", Common.yaml_of_colour v) ]
  | Underline v -> `O [ ("underline", yaml_of_line v) ]
  | Overline v -> `O [ ("overline", yaml_of_line v) ]
  | Border v -> `O [ ("border", yaml_of_d_border v) ]
  | Stack d -> `O [ ("stack", `A (List.map yaml_of_decoration d)) ]

let yaml_of_common (pc : common) : Yaml.value =
  `O
    (List.filter_map
       (fun x -> x)
       [
         Option.map (fun v -> ("left-margin", `Float v)) pc.left_margin;
         Option.map (fun v -> ("right-margin", `Float v)) pc.right_margin;
         Option.map (fun v -> ("margin", `Float v)) pc.margin;
         Option.map (fun v -> ("margin", `Float v)) pc.margin;
         Option.map (fun v -> ("font", Common.yaml_of_font v)) pc.font;
         Option.map
           (fun v -> ("font_shaping", Common.yaml_of_font_shaping v))
           pc.font_shaping;
         Option.map
           (fun v -> ("foreground", Common.yaml_of_colour v))
           pc.foreground;
         Option.map (fun v -> ("on-click", `String v)) pc.on_click;
         Option.map (fun v -> ("on-click-left", `String v)) pc.on_click_left;
         Option.map (fun v -> ("on-click-right", `String v)) pc.on_click_right;
         Option.map (fun v -> ("on-click-middle", `String v)) pc.on_click_middle;
         Option.map
           (fun v -> ("on-click-wheel-up", `String v))
           pc.on_click_wheel_up;
         Option.map
           (fun v -> ("on-click-wheel-down", `String v))
           pc.on_click_wheel_down;
         Option.map
           (fun v -> ("on-click-previous", `String v))
           pc.on_click_previous;
         Option.map (fun v -> ("on-click-next", `String v)) pc.on_click_next;
         Option.map (fun v -> ("deco", yaml_of_decoration v)) pc.deco;
       ])

let rec yaml_of_particle (p : particle) : Yaml.value =
  let yaml_of_items i = ("items", `A (List.map yaml_of_particle i)) in
  match p with
  | String { text; max } ->
      `O
        (List.filter_map
           (fun x -> x)
           [
             Some ("text", `String text);
             Option.map (fun m -> ("max", `Float m)) max;
           ])
  | Empty -> `O []
  | List { items; left_spacing; right_spacing; spacing } ->
      `O
        (List.filter_map
           (fun x -> x)
           [
             Some (yaml_of_items items);
             Option.map (fun ls -> ("left-spacing", `Float ls)) left_spacing;
             Option.map (fun rs -> ("right-spacing", `Float rs)) right_spacing;
             Option.map (fun s -> ("spacing", `Float s)) spacing;
           ])
  | Items i -> `O [ yaml_of_items i ]

let to_yaml (pt : t) : Yaml.value =
  match (pt.common, pt.particle) with
  | Some c, p -> (
      match (yaml_of_common c, yaml_of_particle p) with
      | `O c, `O p -> `O (c @ p)
      | _ -> failwith "Invalid YAML structure")
  | None, p -> yaml_of_particle p

(*Builder*)
(*let make_common*)
(*  ?left_margin*)
(*  ?right_margin*)
(*  ?margin*)
(*  ?font*)
(*  ?font_shaping*)
(*  ?foreground*)
(*  ?on_click*)
(*  ?on_click_left*)
(*  ?on_click_right*)
(*  ?on_click_middle*)
(*  ?on_click_wheel_up*)
(*  ?on_click_wheel_down*)
(*  ?on_click_previous*)
(*  ?on_click_next*)
(*  ?deco =*)
