(define (example-function arg1 arg2)
  ;; This is a comment
    ;; This is a comment
      ;; This is a comment
  (define x "hello")
  (define y "world")
  (string-append x ", " y "!"))

(define a 1)
(define b 2)
(define result (example-function a b))
(displayln result)
