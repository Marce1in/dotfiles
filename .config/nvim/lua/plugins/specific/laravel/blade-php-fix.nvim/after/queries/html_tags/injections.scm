; extends

; ==============================================================================
; Alpine.js JavaScript Injection
; ==============================================================================

; Inject JavaScript into x-* directive values (x-data, x-show, x-if, x-for, etc.)
((attribute
  (attribute_name) @_attr
  (quoted_attribute_value
    (attribute_value) @injection.content))
  (#lua-match? @_attr "^x%-")
  (#set! injection.language "javascript"))

; Inject JavaScript into @ event handler values (@click, @submit, etc.)
((attribute
  (attribute_name) @_attr
  (quoted_attribute_value
    (attribute_value) @injection.content))
  (#lua-match? @_attr "^@")
  (#set! injection.language "javascript"))

; Inject JavaScript into : bind shorthand values (:class, :style, etc.)
((attribute
  (attribute_name) @_attr
  (quoted_attribute_value
    (attribute_value) @injection.content))
  (#lua-match? @_attr "^:")
  (#set! injection.language "javascript"))
