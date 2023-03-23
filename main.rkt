#lang racket

(require racket/format)

; returns the html span with the word
(define (highlight-word word)
  (format "<span class='highlight'>~a</span>" word))

; sends all the words inside a line to the highlight word function
(define (process-line line)
  (string-join (map highlight-word (string-split line)) " "))

(define (process-file input-file output-file)
  (with-input-from-file input-file
    (lambda ()
      (with-output-to-file output-file
        (lambda ()
          (display "<pre>\n")
          ; for loop for all lines inside file
          (for ([line (in-lines)])
            (display (process-line line))
            (display "\n"))
          (display "</pre>\n"))))))

;(process-file "code.py" "output.html")
