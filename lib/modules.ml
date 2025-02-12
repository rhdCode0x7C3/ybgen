(*Modules*)
type module_t = { common : module_common; module_y : module_y }

and module_common = {
  font : Common.font option;
  fg_colour : Common.colour option;
  bg_colour : Common.colour option;
  margin : float option;
  padding : float option;
}

and module_y =
  | Clock of {
      time_format : string option;
      date_format : string option;
      utc : bool option;
      content : Particle.t;
    }
  | Label of { content : Particle.t }

let yaml_of_module_common (mc : module_common) =
  `O
    (List.filter_map
       (fun x -> x)
       [
         Option.map (fun v -> ("font", Common.yaml_of_font v)) mc.font;
         Option.map
           (fun v -> ("fg-color", Common.yaml_of_colour v))
           mc.fg_colour;
         Option.map
           (fun v -> ("bg-color", Common.yaml_of_colour v))
           mc.bg_colour;
         Option.map (fun v -> ("margin", `Float v)) mc.margin;
         Option.map (fun v -> ("padding", `Float v)) mc.padding;
       ])
