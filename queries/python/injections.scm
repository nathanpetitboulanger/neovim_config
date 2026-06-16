;; ── GraphQL injection in Python ──────────────────────────────────
;;
;; Usage: put  # language=graphql  on the line right before a string.
;; Treesitter will then highlight the string contents as GraphQL.
;;
;; Example:
;;
;;   # language=graphql
;;   QUERY = """
;;   query GetProduct($id: ID!) {
;;     product(id: $id) { name price }
;;   }
;;   """
;;

; Block-level: comment immediately followed by an expression_statement with a string
(block
  (comment) @_marker
  .
  (expression_statement
    (string
      (string_content) @injection.content))
  (#match? @_marker "# ?language=graphql")
  (#set! injection.language "graphql"))

; Module-level fallback (for top-level strings in the file)
(module
  (comment) @_marker
  .
  (expression_statement
    (string
      (string_content) @injection.content))
  (#match? @_marker "# ?language=graphql")
  (#set! injection.language "graphql"))
