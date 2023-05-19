#lang racket

; Depending on the token and who it matches the span tag class changes and it's sended to the html as a format
;; O(1)
(define (highlight-token token)
  (cond
    [(not (string? token)) ""]
    [(regexp-match? #px"^\\s+$" token) (format "<span>~a</span>" token)]
    [(regexp-match? #px"^(if|else|break|case|const|continue|for||new|null|private|protected|public|return|short|static|switch|this|throw|try|typeof|void|volatile|while)$" token) (format "<span class=\"keyword\">~a</span>" token)]
    [(regexp-match? #px"^[\\[\\](){}]$" token) (format "<span class=\"block\">~a</span>" token)]
    [(regexp-match? #px"^\".*\"$" token) (format "<span class=\"string\">~a</span>" token)]
    [(regexp-match? #px"^[[:alpha:]][[:alnum:]_]*$" token) (format "<span class=\"var\">~a</span>" token)]
    [(regexp-match? #px"^\\d+\\.\\d+$" token) (format "<span class=\"float\">~a</span>" token)]
    [(regexp-match? #px"^\\.\\d+$" token) (format "<span class=\"float\">~a</span>" token)]
    [(regexp-match? #px"^\\d+$" token) (format "<span class=\"integer\">~a</span>" token)]
    [(regexp-match? #px"^[<>;#.,:!/+*%'=\\|\\-]$" token) (format "<span class=\"punctuation\">~a</span>" token)]
    [else (format "<span>~a</span>" token)]))

; The process-line function creates tokens for every keyword and sends the tokenized version of the line
; to the function highlight-token where it will be processed, this happens to every token due to the map function
(define (process-line line)
  (define (tokenize str)
    ;; O(n)
    (regexp-match* #px"(\\s+|[(){}<>;#.,:!/+*%'=&\\[\\]\\$\\|\\-]|\"[^\"]*\"|[[:alpha:]]+[[:alnum:]_]*|0[xX][[:xdigit:]]+|\\d+\\.\\d+|\\.\\d+|\\d+)" str))
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

; The first line of input contains one number N that represents the number of files to be processed
(define (process-files)
  (define num-files (read))
  ; Creates a list of strings for N files containing each file path
  (define file-paths (for/list ([i num-files]) (read)))

  ; Creates a thread for each file in file-paths
  (define threads
  (for/list ([file-path file-paths]
             [i (length file-paths)])
    (thread (lambda ()
              (display (format "Processing file: ~a: At thread ~a~n" file-path i))
              (process-file file-path (string-append "output-" file-path ".html"))
              (display (format "Finished processing file: ~a: At thread ~a~n" file-path i))))))
  
  (for-each thread-wait threads))

; Main
(process-files)