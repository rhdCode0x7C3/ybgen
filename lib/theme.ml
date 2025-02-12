type status_colours = {
  error : Common.colour;
  warning : Common.colour;
  info : Common.colour;
  success : Common.colour;
}

type theme_colours = {
  fg_primary : Common.colour;
  fg_secondary : Common.colour;
  fg_dimmed : Common.colour;
  bg_primary : Common.colour;
  bg_secondary : Common.colour;
  accent : Common.colour;
  status : status_colours;
  border : Common.colour;
}

type theme_fonts = { normal : Common.font; mono : Common.font }

type theme_metrics = {
  bar_height : float;
  module_padding : float;
  module_spacing : float;
  border_width : float;
  border_radius : float;
  line_weight : float;
}

type theme = {
  colours : theme_colours;
  fonts : theme_fonts;
  metrics : theme_metrics;
}
