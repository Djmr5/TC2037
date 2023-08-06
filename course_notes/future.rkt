#lang racket
; Pararelism with Future
(define (any-double? l)
  (for/or ([i (in-list l)])
    (for/or ([i2 (in-list l)])
      (= i2 (* 2 i)))))

(define l1 (for/list ([i (in-range 5000)])
             (+ (* 2 i) 1)))

(any-double? l1)

(define l2 (for/list ([i (in-range 5000)])
             (- (* 2 i) 1)))

(let ([f (future (lambda () (any-double? l2)))])
  (or (any-double? l1)
      (touch f))
  )

; Future visualizer
(require future-visualizer)
(visualize-futures
 (let ([f (future (lambda () (any-double? l2)))])
  (or (any-double? l1)
      (touch f))
  )
 )