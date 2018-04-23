#lang racket

;; Provides a reader-like construct for the Lyrics language
;; Should allow users to copy and paste in lyrics from the
;; internet and use the line breaks to parse them into slides

;; DEPENDENCIES

(require (for-syntax syntax/parse))


;; Output file
(define line-file (open-input-file "lines.txt" #:mode 'text))
(define lines-string (port->string line-file))
(string->list lines-string)

;; With the above lines, we now need a function to parse through the
;; list, concatenating characters into words until it hits a newline
;; then it makes a new string
;; if it hits two newlines in a row it makes a list of lists of strings
;; Which is just a song

(define-syntax parse-the-lines
  (syntax-parser
    [(_ line ...) ; I want to put a newline character here but it doesn't exist
   #'('line ...)]))
;; Use string->list
