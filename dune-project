(lang dune 3.17)

(name ybgen)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Rhys Downing <rhdCode0x7C3@icloud.com>")

(maintainers "Rhys Downing <rhdCode0x7C3@icloud.com>")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name ybgen)
 (synopsis "Generate YAML configuration file for Yambar")
 (description "A longer description")
 (depends ocaml)
 (tags
  ("add topics" "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
