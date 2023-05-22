#lang racket


(define (is-prime? n)
  (cond
    ((< n 2) #f)
    (else
     (define (check-divisors d)
       (cond
         ((> d (exact-floor (sqrt n))) #t)
         ((= (remainder n d) 0) #f)
         (else (check-divisors (+ d 1)))))
     (check-divisors 2))))

(define (sumaN n)
  (define sum 0)
  (for ([i (in-range 1 (add1 n))])
    (when (is-prime? i)
      (set! sum (+ sum i))))
  sum)

(sumaN 5000000)
