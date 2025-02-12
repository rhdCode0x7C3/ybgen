(*General types*)
type colour = int
type font = { family : string; style : string; size : float }
type font_shaping = Full | None

type module_common = {
  font : font option;
  fg_colour : colour option;
  bg_colour : colour option;
  margin : float option;
  padding : float option;
}
