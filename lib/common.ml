(*General types*)
type colour = int
type font = { family : string; style : string; size : float }
type font_shaping = Full | None

(*internal conversions*)
let colour_of_hex hex = int_of_string hex
let hex_of_colour colour : string = Printf.sprintf "#%06x" colour

(*Yaml conversions*)
let yaml_of_colour (c : colour) = `String (hex_of_colour c)

let yaml_of_font (f : font) =
  `O
    [
      ("family", `String f.family);
      ("style", `String f.style);
      ("size", `Float f.size);
    ]

let yaml_of_font_shaping (fs : font_shaping) =
  `String (match fs with Full -> "full" | None -> "none")
