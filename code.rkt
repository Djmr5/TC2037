(define (example-function arg1 arg2)
  ;; This is a comment
    ;; This is a comment
      ;; This is a comment
  (define x "hello")
  (define y "world")
  (string-append x ", " y "!"))

(define my-other-list '(1 2 3 4 5))
(length my-other-list) ; output: 5

(define a 1)
(define b 2)
(define result (example-function a b))
(displayln result)

(define (otherFunction)
  (define CONST 1234)
  (define flt 1.4)
  (define flt2 .45)
  (define str "string")
  (define boolean1 #t)
  (define boolean2 #f)
  
  (for ([i (in-range CONST)])
    (if (= i 10)
        (begin (displayln "i equals 10!")
               (break))
        (cond [(= i 5) (continue)]
              [else (displayln i)])))
  
  (switch CONST
          [(1) (displayln "CONST is 1")]
          [(2) (displayln "CONST is 2")]
          [(3) (displayln "CONST is 3")]
          [else (displayln "CONST is not 1, 2, or 3")])
  
  (if (> CONST 1000)
      (displayln "CONST is greater than 1000")
      (displayln "CONST is not greater than 1000"))
  
  (try
   (begin
     (define lst (list "Hello" "World" CONST null))
     (displayln lst)
     (throw "Something went wrong!")))
   (catch
    (lambda (e)
      (displayln e))))
  
  (void))

(define person%
  (class object%
    (init name age)
    (super-new)
    (define/public (greet)
      (displayln (string-append "Hello, my name is " name ", and I am " (number->string age) " years old.")))))

(define alice (new person% ["Alice" 25]))
(send alice greet) ; prints "Hello, my name is Alice, and I am 25 years old."

(define (print-list! lst)
  (for ([elem lst])
    (displayln elem)))

(define my-list (list "foo" "bar" "baz"))
(print-list! my-list) ; prints "foo", "bar", and "baz" on separate lines