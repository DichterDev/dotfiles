;; extends

(function_declaration
  parameters: (parameters) @function.inner.start
  "end" @function.inner.end) @function.outer

(function_definition
  parameters: (parameters) @function.inner.start
  "end" @function.inner.end) @function.outer
