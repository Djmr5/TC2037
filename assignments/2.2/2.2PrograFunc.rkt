#lang racket
#|

Alejandro Pozos Aguirre [A01656017]
Carlos Damián Suárez Bernal [A01656277]
Diego Jacobo Martínez [A01656017]

|#
#|
1.La función insert toma dos entradas: un número n y una lista lst que contiene números en orden ascendente.
Devuelve una nueva lista con los mismos elementos de lst pero con n insertado en su lugar correspondiente
|#
;; Función que checa si todos los valores son numéricos
(define (es-num n) (number? n))

;; Función que inserta un número n en una lista lst ordenada
(define (insert n lst)
  (if (and (andmap es-num lst) (number? n))
      (cond
        [(empty? lst) (list n)]
        [(<= n (first lst)) (cons n lst)]
        [else (cons (first lst) (insert n (rest lst)))])
      "not a numeric list or number"))
(write "1. Right (insert 5 '(1 3 6 7 9 16))")
(insert 5 '(1 3 6 7 9 16))
(write "1. Wrong (insert \"a\" '(1 3 6 7 9 16))")
(insert "a" '(1 3 6 7 9 16))
#|
; ---------------------------------------------------------------------------------------------------------
2. La función insertion-sort toma una lista desordenada de números como entrada y devuelve una nueva lista
con los mismos elementos pero en orden ascendente. Se debe usar la función de insert definida en el ejercicio
anterior para escribir insertion-sort. No se debe utilizar la función sort o alguna similar predefinida.
|#

;; Función que ordena una lista usando insert
(define (insertion-sort lst)
 (if (andmap es-num lst)
  (if (empty? lst)
      empty
      (insert (first lst) (insertion-sort (rest lst))))
  "not a list of numbers"))
(write " 2. Right (insertion-sort '(4 3 6 8 3 0 9 1 7))")
(insertion-sort '(4 3 6 8 3 0 9 1 7))
(write " 2. Wrong (insertion-sort '(4 \"a\" 6 8 3 0 9 1 7))")
(insertion-sort '(4 "a" 6 8 3 0 9 1 7))

; ---------------------------------------------------------------------------------------------------------
#|
3. La función rotate-left toma dos entradas: un número entero n y una lista lst. Devuelve la lista que resulta
de rotar lst un total de n elementos a la izquierda. Si n es negativo, rota hacia la derecha.
|#
;; Función que rota a la izquierda n veces o a la derecha -n veces
(define (rotate-left n lst)
  (if (number? n)
      (let ((len (length lst)))
        (if (zero? len)
            '()
            (let ((n (modulo n len)))
              (append (drop lst n) (take lst n)))))
      "not numeric") ; n solo acepta números 
  )

(write "3. Right (rotate-left -8 '(a b c d e f g))")
(rotate-left -8 '(a b c d e f g))
(write "3. Wrong (rotate-left \"a\" '(a b c d e f g))")
(rotate-left "a" '(a b c d e f g))

; ---------------------------------------------------------------------------------------------------------
#|
4. La función prime-factors toma un número entero n como entrada (n ¿ 0) y devuelve una lista que contiene
los factores primos de n en orden ascendente. Los factores primos son los números primos que dividen a un
número de manera exacta. Si se multiplican todos los factores primos se obtiene el número original.
|#

;; Función prime-factors
(define (prime-factors n)

  ;;; Función auxiliar que calcula los factores recursivamente
  (define (factors-rec i m)
    (cond ([<= i (sqrt m)]
           [if (= 0 (modulo m i))
               (cons i (factors-rec i (quotient m i)))
               (factors-rec (+ i 1) m)])
          [else (list m)]))
(if (number? n)
    (cond [(= n 1) '()]
        [(negative? n) (prime-factors (- n))]
        [else (factors-rec 2 n)])
    "not a number")
  )

(write " 4. Right (prime-factors 666)")
(prime-factors 666)
(write " 4. Wrong (rotate-left \"a\" '(a b c d e f g))")
(prime-factors "a")

; ---------------------------------------------------------------------------------------------------------
#|
5. La función gcd toma dos números enteros positivos a y b como entrada, donde a > 0 y b > 0. Devuelve el
máximo com ́un divisor (GCD por sus siglas en inglés) de a y b. No se debe usar la función gcd o similar
predefinida
|#

;; Función que encuentra los valores que se encuentran en ambas listas [intersección] usando tail-recursion
(define (intersection lst1 lst2)
      (cond ([or (null? lst1) (null? lst2)] '())
            ([= (car lst1) (car lst2)]
             (cons (car lst1)
                   (intersection (cdr lst1) (cdr lst2))))
            ([< (car lst1) (car lst2)]
             (intersection (cdr lst1) lst2))
            [else (intersection lst1 (cdr lst2))]))


;; Función para obtener el máximo común divisor de dos números
(define (gcd a b)
  (if (and (number? a) (number? b))
      (let ((factores-a (prime-factors a))
            (factores-b (prime-factors b)))
        (apply * (intersection factores-a factores-b)))
      "not number(s)"))
(write "5. Right (gcd 6307 1995)")
(gcd 6307 1995)
(write "5. Wrong (gcd 6307 \"a\")")
(gcd 6307 "a")

; ---------------------------------------------------------------------------------------------------------
#|
6. La función deep-reverse toma una lista como entrada. Devuelve una lista con los mismos elementos que su
entrada pero en orden inverso. Si hay listas anidadas, estas también deben invertirse.
|#
;; Función deep-reverse
(define (deep-reverse lst)
  ;;; Función auxiliar inner-reverse, procesa listas dentro de listas
  (define (inner-reverse lst)
    (cond [(null? lst) '()]
          [(list? (car lst)) (cons (inner-reverse (car lst)) (inner-reverse (cdr lst)))]
          [else (append (inner-reverse (cdr lst)) (list (car lst)))]))

  (if (list? lst)
      (inner-reverse lst)
      "not a list")
  )
(write " 6. Right (deep-reverse '(a (b (c (d (e (f (g (h i j)))))))))")
(deep-reverse '(a (b (c (d (e (f (g (h i j)))))))))
(write " 6. Wrong (deep-reverse 12)")
(deep-reverse 12)

; ---------------------------------------------------------------------------------------------------------
;; Problema 7
;; La función insert-anywhere toma dos entradas: un objeto x y una lista lst. Devuelve una nueva lista con
;; todas las formas posibles en que se puede insertar x en cada posición de lst.
(define (insert-everywhere x lst)
  (if (list? lst)
      (if (null? lst)
        (list (list x))
        (let ((first (car lst))
              (rest (cdr lst)))
          (append (list (cons x lst))
                  (map (lambda (l) (cons first l))
                      (insert-everywhere x rest)))))
      "No es una lista"))

; ---------------------------------------------------------------------------------------------------------
;; Problema 8
;; La función pack toma una lista lst como entrada. Devuelve una lista de listas que agrupan los elementos
;; iguales consecutivos

(define (pack lst)
  (if (list? lst)
    (if (null? lst)
        '()
        (let ((first-elem (car lst))
              (packed-rest (pack (cdr lst))))
          (if (null? packed-rest)
              (list (list first-elem))
              (if (equal? first-elem (caar packed-rest))
                  (cons (cons first-elem (car packed-rest))
                        (cdr packed-rest))
                  (cons (list first-elem) packed-rest)))))
        "No es una lista"))

; ---------------------------------------------------------------------------------------------------------
;; Problema 9
;; La función compress toma una lista lst como entrada. Devuelve una lista en la que los elementos repetidos
;; consecutivos de lst se reemplazan por una sola instancia. El orden de los elementos no debe modificarse.

(define (compress lst)
  (if (list? lst)
    (if (null? lst)
        '()
        (let ((first-elem (car lst))
              (compressed-rest (compress (cdr lst))))
          (if (null? compressed-rest)
              (list first-elem)
              (if (equal? first-elem (car compressed-rest))
                  compressed-rest
                  (cons first-elem compressed-rest)))))
    "No es una lista"))

; ---------------------------------------------------------------------------------------------------------
;; Problema 10
;; La función encode toma una lista lst como entrada. Los elementos consecutivos en lst se codifican en listas
;; de la forma: (n e), donde n es el n ́umero de ocurrencias del elemento e

(define (encode lst)
  (if (list? lst)
    (if (null? lst)
        '()
        (let ((first-elem (car lst))
              (encoded-rest (encode (cdr lst))))
          (if (null? encoded-rest)
              (list (list 1 first-elem))
              (if (equal? first-elem (cadar encoded-rest))
                  (cons (list (+ 1 (caar encoded-rest))
                              first-elem)
                        (cdr encoded-rest))
                  (cons (list 1 first-elem) encoded-rest)))))
    "No es una lista"))

; ---------------------------------------------------------------------------------------------------------
;; Problema 11
;; La función encode-modified toma una lista lst como entrada. Funciona igual que el problema anterior,
;; pero si un elemento no tiene duplicados simplemente se copia en la lista resultante. Solo los elementos que
;; tienen repeticiones consecutivas se convierten en listas de la forma: (n e).

(define (encode-modified lst)
  (if (not (list? lst))
      "No es una lista"
      (let loop ((count 1) (current (car lst)) (remaining (cdr lst)) (result '()))
        (cond ((null? remaining)
               (if (= count 1)
                   (append result (list current))
                   (append result (list (list count current)))))
              ((equal? current (car remaining))
               (loop (+ count 1) current (cdr remaining) result))
              (else (if (= count 1)
                        (loop 1 (car remaining) (cdr remaining) (append result (list current)))
                        (loop 1 (car remaining) (cdr remaining) (append result (list (list count current))))))))))

; ---------------------------------------------------------------------------------------------------------
;; Problema 12
;; La función de decode toma como entrada una lista codificada lst que tiene la misma estructura que la lista
;; resultante del problema anterior. Devuelve la versión decodificada de lst.

(define (decode lst)
  (define (repeat-element element count)
    (if (<= count 0)
        '()
        (cons element (repeat-element element (- count 1)))))
  (cond ((null? lst) '())
        ((not (pair? (car lst))) (cons (car lst) (decode (cdr lst))))
        (else (append (repeat-element (cadr (car lst)) (car (car lst)))
                      (decode (cdr lst))))))

; ---------------------------------------------------------------------------------------------------------
#|
13. La función args-swap toma como entrada una función de dos argumentos f y devuelve una nueva función
que se comporta como f pero con el orden de sus dos argumentos intercambiados.
|#
;; Función que invierte los argumentos
(define args-swap
  (lambda(f)
    (lambda(x y)
          (f y x)
)))
; ---------------------------------------------------------------------------------------------------------
#|
14. La función there-exists-one? toma dos entradas: una función booleana de un argumento pred y una lista
lst. Devuelve verdadero si hay exactamente un elemento en lst que satisface pred, en otro caso devuelve
falso.
|#
;; Función que dice si existe pred en la lista
(define (there-exists-one? pred lst)
  (if (list? lst)
    (ormap pred lst)
    "El input no es una lista"
))
; ---------------------------------------------------------------------------------------------------------
#|
15. La función linear-search toma tres entradas: una lista lst, un valor x, y una funci ́on de igualdad eq-fun.
Busca secuencialmente x en lst usando eq-fun para comparar x con los elementos contenidos en lst. La
función eq-fun debe aceptar dos argumentos, a y b, y devolver verdadero si se debe considerar que a es igual
a b, o falso en caso contrario.
La funci ́on linear-search devuelve el  ́ındice donde se encuentra la primera ocurrencia de x en lst (el primer
elemento de la lista se encuentra en el  ́ındice 0), o falso si no se encontr ́o
|#
;; Función que hace una búsqueda lineal
(define (linear-search lst x eq-fun)
  (if (list? lst)
      (let ((res (index-where lst (lambda (y) (eq-fun x y)))))
        (if res
            res
            false))
  "El input no es una lista"))
; ---------------------------------------------------------------------------------------------------------
#|
16. La derivada de una funci ́on f (x) con respecto a la variable x se define como:
f ′(x) ≡ lim (h→0) [(f (x + h) - f (x))/h]
Donde f debe ser una función continua. Escribe la funci ́on deriv que toma f y h como entradas, y devuelve
una nueva función que toma x como argumento, y que representa la derivada de f dado un cierto valor de h
|#
;; Función que hace la derivada de una función
(define (deriv f h)
  (if (procedure? f)
      (if (number? h)
          (lambda (x) (/ (- (f (+ x h)) (f x)) h))
       "h no es un numero")
  "f no es una funcion"))
; ---------------------------------------------------------------------------------------------------------
#|
17. El m ́etodo de Newton es un algoritmo para encontrar la ra ́ız de una funci ́on a partir del c ́alculo de aproximaciones
sucesivamente mejores. Se puede resumir de la siguiente manera:
xn = {0                     Si n = 0
      xn-1 - f (xn-1)
             f ′ (xn-1)     Si n > 0
Algunas cosas que es necesario se ̃nalar:
• f debe ser una funci ́on real diferenciable.
• Entre mayor sea el valor de n, mejor es la aproximaci ́on.
• x0 es una aproximaci ́on inicial, y es recomendable que sea un valor cercano a la soluci ́on. Esto permite
calcular el resultado de manera m ́as r ́apida. Sin embargo, por simplicidad, siempre suponemos aqu ́ı que
x0 = 0.
Escribe la función newton que recibe f y n como entradas, y devuelve el valor correspondiente de xn. Usa la
funci ́on deriv del problema anterior para calcular f ′, con h = 0.0001
|#
;; Función que realiza la derivada 
(define (deriv2 f)
  (if (procedure? f)
          (lambda (x) (/ (- (f (+ x 0.0001)) (f x)) 0.0001))
  "f no es una funcion"))
;; Función que hace la derivada con método de Newton
(define (newton f n)
  (if (procedure? f)
      (if (number? n)
          (newtonRec 0 0 n f)
       "n no es un numero")
  "f no es una funcion"))
;; Función de Newton recursiva
(define (newtonRec xn i n f)
  (if (= i n)
        xn
        (newtonRec (- xn (/ (f xn) ((deriv2 f) xn))) (+ i 1) n f)))
; ---------------------------------------------------------------------------------------------------------
#|
18. La función integral toma a y b como limites inferior y superior, n como la cantidad de veces
que se ejecutara el método de Simpson y f como una función dependiente de x. Devuelve el resultado de la
integral definida, usando la regla de Simpson.
|#
;; Función deriv
(define (integral a b n f)
  (if (procedure? f)
      (if (number? a)
          (if (number? b)
              (if (> b a)
                  (if (integer? n)
                      (if (> n 0)
                          (integralSumaRecursive 0 n a (/ (- b a) n) f 0) ;;Inicializa Recursión
                       "n no es menor a 0")
                   "n no es un numero entero")
               "b no es mayor que a")
           "b no es un numero")
       "a no es un numero")
   "f no es una funcion")
)
;; Función integralSumaRecursive que resuelve Simpson de manera Recursiva
(define (integralSumaRecursive i n a h f total)
  (if (= i (+ n 1))
      (* total (/ h 3))
      (if (or (= i 0) (= i n))
          (integralSumaRecursive (+ i 1) n a h f (+ total (f (+ a (* i h)))))
          (if (odd? i)
              (integralSumaRecursive (+ i 1) n a h f (+ total (* 4 (f (+ a (* i h))))))
              (integralSumaRecursive (+ i 1) n a h f (+ total (* 2 (f (+ a (* i h))))))
          ))))