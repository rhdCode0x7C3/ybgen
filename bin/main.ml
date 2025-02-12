let () =
  let yaml_value = `O [ ("hello", `String "world") ] in
  let out_channel = Format.std_formatter in
  Yaml.pp out_channel yaml_value
