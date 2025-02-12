(*Modules*)
type module_y =
  | Clock of {
      time_format : string option;
      date_format : string option;
      utc : bool option;
      content : Types.particle_t;
    }
  | Label of { content : Types.particle_t }

type module_t = { common : Common.module_common; module_y : module_y }
