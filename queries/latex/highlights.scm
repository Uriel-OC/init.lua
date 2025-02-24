;; extends

[ "\\(" "\\)" "\\[" "\\]" ] @punctuation.bracket

["(" ")" "|"] @character

((word) @type
  (#has-ancestor? @type inline_formula))

((word) @type
  (#not-has-ancestor? @type label_definition text_mode begin end)
  (#has-ancestor? @type displayed_equation math_environment))

(text_mode
  content: (curly_group (text) @variable))

((word) @number
  (#lua-match? @number "%d+"))

([(word) (letter) (generic_command)] @nospell
  (#not-has-ancestor? @nospell label_definition text_mode begin end)
  (#has-ancestor? @nospell inline_formula displayed_equation math_environment)
  (#set! priority 1000))
