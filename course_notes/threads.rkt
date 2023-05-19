#lang racket 
; Thread Definition
(thread (lambda () (displayln "Este es un thread.")))
(thread (lambda () (displayln "Este es un otro thread.")))

; First Example - Single Thread & Sleep
(define worker (thread (lambda ()
                         (let loop ()
                           (displayln "Working...")
                           (sleep 0.2)
                           (loop)
                           )
                         )
                       )
  )
(sleep 2.5)
(kill-thread worker)
; Second Example - Promises/Async
(define workerDos (thread (lambda ()
                         (for ([i 10])
                           (printf "Procesando... ~a~n" i)
                           )
                       )
  ))
(thread-wait workerDos)
(displayln "Worker terminó")
(kill-thread workerDos)

; Third Example - Thread Communication
( define worker-thread (thread
                        (lambda ()
                          (let loop ()
                            (match (thread-receive)
                              [(? number? num)
                               (printf "Procesando ~a~n" num)
                               (loop)]
                              ['done
                               (printf "Ejecutando~n")]
                              )
                            )
                          )
                        )
   )
(for ([i 10])
  (thread-send worker-thread i))
(thread-send worker-thread 'done)
(thread-wait worker-thread)
(kill-thread worker-thread)

; Fourth Example - Semaphores / Multithread
(define output-semaphore (make-semaphore 1))
(define (make-thread name)
  (thread (lambda ()
            (for [(i 10)]
              (semaphore-wait output-semaphore)
              (printf "Hilo ~a: ~a~n" name i)
              (semaphore-post output-semaphore)
              )
            )
          )
  )
(define threads
  (map make-thread '(A B C)))
(for-each thread-wait threads)

; Fifth Example - Channels
(define result-channel (make-channel))
(define result-thread
  (thread (lambda ()
            (let loop ()
              (display (channel-get result-channel))
              (loop)))))

(define work-channel (make-channel))
(define (make-worker thread-id)
  (thread
   (lambda ()
     (let loop ()
       (define item (channel-get work-channel))
       (case item
         [(DONE)
          (channel-put result-channel
                       (format "Hilo ~a hecho\n" thread-id))]
         [else
          (channel-put result-channel
                       (format "Hilo ~a procesando ~a\n" thread-id item ))
          (loop)])))))
  (define work-threads (map make-worker '(1 2)))

  (for ([item '(A B C D E F G H DONE DONE)])
    (channel-put work-channel item))

  (for-each thread-wait work-threads)
  
  (channel-put result-channel "")