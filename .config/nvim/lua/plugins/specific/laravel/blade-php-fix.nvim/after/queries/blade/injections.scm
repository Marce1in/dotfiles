; extends

; ==============================================================================
; PHP Injection for Blade Files
; ==============================================================================
; The base nvim-treesitter queries already handle:
; - (text) -> html
; - (php_only) -> php_only
; - (parameter) -> php_only

; Inject PHP for text nodes that start with <?php (full PHP blocks)
; This overrides the default html injection for these specific text nodes
((text) @injection.content
  (#lua-match? @injection.content "^%s*<%?php")
  (#set! injection.language "php")
  (#set! injection.combined))
