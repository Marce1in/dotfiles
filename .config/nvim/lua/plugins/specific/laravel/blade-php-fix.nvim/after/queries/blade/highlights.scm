; extends

; ==============================================================================
; Blade Directive Highlighting
; ==============================================================================

; Blade directives (@if, @foreach, @extends, etc.)
([
  (directive)
  (directive_start)
  (directive_end)
] @keyword
  (#set! priority 102))

; Keyword nodes
((keyword) @keyword
  (#set! priority 102))

; Conditional keywords (@elseif, @else, etc.)
((conditional_keyword) @keyword
  (#set! priority 102))

; ==============================================================================
; Blade Echo Brackets
; ==============================================================================

; Echo brackets {{ }} and {!! !!}
([
  (bracket_start)
  (bracket_end)
] @punctuation.special
  (#set! priority 102))

; ==============================================================================
; Blade Comments
; ==============================================================================

((comment) @comment
  (#set! priority 102))
