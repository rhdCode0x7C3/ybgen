(*Internal conversions*)
let colour_of_hex hex = int_of_string hex
let hex_of_colour colour : string = Printf.sprintf "#%06x" colour

(*Yaml conversions*)
let yaml_of_colour (c : Types.colour) = `String (hex_of_colour c)

let yaml_of_font (f : Types.font) =
  `O
    [
      ("family", `String f.family);
      ("style", `String f.style);
      ("size", `Int f.size);
    ]

let yaml_of_line (l : Types.line) =
  `O [ ("size", `Int l.size); ("color", yaml_of_colour l.color) ]

let yaml_of_border (b : Types.border) =
  `O
    (List.filter_map
       (fun x -> x)
       [
         Option.map (fun s -> ("size", `Int s)) b.size;
         Some ("color", yaml_of_colour b.color);
       ])

let rec yaml_of_decoration (d : Types.decoration) =
  match d with
  | Background v -> `O [ ("background", yaml_of_colour v) ]
  | Underline v -> `O [ ("underline", yaml_of_line v) ]
  | Overline v -> `O [ ("overline", yaml_of_line v) ]
  | Border v -> `O [ ("border", yaml_of_border v) ]
  | Stack d -> `O [ ("stack", `A (List.map yaml_of_decoration d)) ]

let yaml_of_particle_common (pc : Types.particle_common) =
  `O
    (List.filter_map
       (fun x -> x)
       [
         Option.map (fun v -> ("left-margin", `Int v)) pc.left_margin;
         Option.map (fun v -> ("right-margin", `Int v)) pc.right_margin;
         Option.map (fun v -> ("margin", `Int v)) pc.margin;
         Option.map (fun v -> ("margin", `Int v)) pc.margin;
         Option.map (fun v -> ("font", yaml_of_font v)) pc.font;
         Option.map (fun v -> ("foreground", yaml_of_colour v)) pc.foreground;
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

let rec yaml_of_particle (p : Types.particle) =
  let yaml_of_items i = ("items", `A (List.map yaml_of_particle i)) in
  match p with
  | String { text; max } ->
      `O
        (List.filter_map
           (fun x -> x)
           [
             Some ("text", `String text);
             Option.map (fun m -> ("max", `Int m)) max;
           ])
  | Empty -> `O []
  | List { items; left_spacing; right_spacing; spacing } ->
      `O
        (List.filter_map
           (fun x -> x)
           [
             Some (yaml_of_items items);
             Option.map (fun ls -> ("left-spacing", `Int ls)) left_spacing;
             Option.map (fun rs -> ("right-spacing", `Int rs)) right_spacing;
             Option.map (fun s -> ("spacing", `Int s)) spacing;
           ])
  | Items i -> `O [ yaml_of_items i ]

let yaml_of_particle_t (pt : Types.particle_t) =
  `O [ yaml_of_particle_common pt.common; yaml_of_particle pt.particle ]

let yaml_of_module_common (mc : Types.module_common) =
  `O
    (List.filter_map
       (fun x -> x)
       [
         Option.map (fun v -> ("font", yaml_of_font v)) mc.font;
         Option.map (fun v -> ("fg-color", yaml_of_colour v)) mc.fg_colour;
         Option.map (fun v -> ("bg-color", yaml_of_colour v)) mc.bg_colour;
         Option.map (fun v -> ("margin", `Int v)) mc.margin;
         Option.map (fun v -> ("padding", `Int v)) mc.padding;
       ])
