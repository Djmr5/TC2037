#lang racket

; Depending on the token and who it matches the span tag class changes and it's sended to the html as a format
;; O(1)
(define (highlight-token token)
  (cond
    [(not (string? token)) ""]
    [(regexp-match? #px"^\\s+$" token) (format "<span>~a</span>" token)]
    [(regexp-match? #px"^(if|else|break|case|const|continue|for||new|null|private|protected|public|return|short|static|switch|this|throw|try|typeof|void|volatile|while)$" token) (format "<span class=\"keyword\">~a</span>" token)]
    [(regexp-match? #px"^[][(){}]$" token) (format "<span class=\"block\">~a</span>" token)]
    [(regexp-match? #px"^\".*\"$" token) (format "<span class=\"string\">~a</span>" token)]
    [(regexp-match? #px"^[[:alpha:]][[:alnum:]_]*$" token) (format "<span class=\"var\">~a</span>" token)]
    [(regexp-match? #px"^\\d+\\.\\d*$" token) (format "<span class=\"float\">~a</span>" token)]
    [(regexp-match? #px"^\\.\\d+$" token) (format "<span class=\"float\">~a</span>" token)]
    [(regexp-match? #px"^\\d+$" token) (format "<span class=\"integer\">~a</span>" token)]
    [(regexp-match? #px"^[<>;#.,:!/']$" token) (format "<span class=\"punctuation\">~a</span>" token)]
    [else (format "<span>~a</span>" token)]))

; The process-line function creates tokens for every keyword and sends the tokenized version of the line
; to the function highlight-token where it will be processed, this happens to every token due to the map function
(define (process-line line)
  (define (tokenize str)
    ;; O(n)
    (regexp-match* #px"(\\s+|[][(){}<>;#.,:!/']|\"[^\"]*\"|[[:alpha:]]+[[:alnum:]_]*|0[xX][[:xdigit:]]+|\\d+\\.\\d*|\\.\\d+|\\d+)" str))
  ;; O(n^2) 
  (string-join (map highlight-token (tokenize line)) ""))

; Receives the input file and outputs the file into html file
(define (process-file input-file output-file) 
(with-input-from-file input-file
  (lambda ()
    
    (define output-port (open-output-file output-file))
    (display "<html>\n<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\">\n<pre>\n" output-port)
    ;; O(n ^3)
    (for ([l (in-lines)])
      (display (process-line l) output-port)
      (display "\n" output-port))
    (display "</pre>\n</html>\n" output-port)
    (close-output-port output-port))))

; Execution examples as HTML
(process-file "code.cpp" "outputcpp.html")
(process-file "code.js" "outputjs.html")
(process-file "code.rkt" "outputrkt.html")
