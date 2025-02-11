type colour = int

type base16_colours = {
  base00 : colour;
  base01 : colour;
  base02 : colour;
  base03 : colour;
  base04 : colour;
  base05 : colour;
  base06 : colour;
  base07 : colour;
  base08 : colour;
  base09 : colour;
  base0A : colour;
  base0B : colour;
  base0C : colour;
  base0D : colour;
  base0E : colour;
  base0F : colour;
}

let colour_of_hex hex = int_of_string hex
let hex_of_colour colour : string = Printf.sprintf "#%06x" colour

type clock_config = { format : string; time_zone : string option }
type module_specific = Clock of clock_config

type module_common = {
  font : string option;
  fg_colour : colour option;
  bg_colour : colour option;
  margin : int option;
  padding : int option;
}

type module_t = { common : module_common; specific : module_specific }
type font = { family : string; style : string; size : float }
