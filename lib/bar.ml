open Types

type location = Top | Bottom

type layer =
  | Overlay of string
  | Top of string
  | Bottom of string
  | Background of string

type border = {
  left_width : int option;
  right_width : int option;
  top_width : int option;
  bottom_width : int option;
  width : int option;
  color : colour;
  left_margin : int option;
  right_margin : int option;
  top_margin : int option;
  bottom_margin : int option;
  margin : int option;
}

type bar = {
  height : int;
  location : location;
  background : colour;
  monitor : string option;
  layer : layer option;
  left_spacing : int option;
  right_spacing : int option;
  spacing : int option;
  left_margin : int option;
  right_margin : int option;
  margin : int option;
  border : border option;
  font : font option;
  foreground : colour option;
  trackpad_sensitivity : int option;
  left : module_t list option;
  center : module_t list option;
  right : module_t list option;
}
