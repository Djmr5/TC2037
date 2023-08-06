#lang racket
; First Exercise
(define potencia (thread (lambda ()
                           (printf "Inicia Potencia~n")
                           (for ([i 10])
                           (printf "2^~a = ~a~n" (+ i 1) (expt 2 (+ i 1)))
                           ;(sleep 1)
                           )
                       )
  ))
(thread-wait potencia)
(displayln "Potencia terminó")
(kill-thread potencia)

; Second Exercise
(define output-semaphore (make-semaphore 1))
(define (make-thread name)
  (thread (lambda ()
            (for [(i 10)]
              (semaphore-wait output-semaphore)
              (printf "~a * ~a = ~a~n" name (+ i 1) (* name (+ i 1)))
              (semaphore-post output-semaphore)
              )
            )
          )
  )

(define threads
  (map make-thread '(10 9 8 7 6 5 4 3 2 1)))
(for-each thread-wait threads)
(for-each kill-thread threads)

; Third Exercise
(define output-runner (make-semaphore 1))

(define (make-runner-thread name)
  (thread (lambda ()
            (let loop ([i 0])
              (unless (> i 14)
                (let ([random-number (+ (random 3) 1)])
                  (semaphore-wait output-runner)
                  (set! i (+ random-number i))
                  (printf "Runner ~a, runs ~a km, is at km ~a~n" name random-number i)
                  ;(sleep 2)
                  (semaphore-post output-runner)
                  (loop i))))
            (printf "Runner ~a finished\r" name))))

(define runner-threads
  (map make-runner-thread '(3 2 1)))

(for-each thread-wait runner-threads)
(for-each kill-thread runner-threads)

; Fourth Exercise
(define cake-semaphore (make-semaphore 1))
(define (cake-thread name)
  (thread (lambda ()
            (let loop ([cake 8])
              (unless (> cake 0)
                  (semaphore-wait cake-semaphore)
                  (set! cake (- 1 cake))
                  (printf "Person ~a, eats 1 slice, ~a~n are left" name cake)
                  ;(sleep 3)
                  (semaphore-post cake-semaphore)
                  (loop cake)))
            )
          )
  )

(define cake-threads
  (map cake-thread '(4 3 2 1)))
(for-each thread-wait cake-threads)
(for-each kill-thread cake-threads)