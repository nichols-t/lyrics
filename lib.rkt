#lang racket

;; Provides a library for song lyrics
;; Eventually will become a slideshow-based DSL

;; This will allow users to easily input lyrics

;; A Line is the basic unit of song lyrics, so we define them here
;; Each Line will become one (t ...) form in a slide
;; A Section is nothing but a List of Lines

;; PROVIDES -------------------------------------------------------
(provide
 line
 section
 song
 string->slides)

;; DEPENDENCIES ---------------------------------------------------

(require (for-syntax syntax/parse))

;; FUNCTIONS -------------------------------------------------------

(define (string->slides str)
  ;; First, we will parse the string into a list of lines
  ;; (to-lines String String Listof String)
  ;; Parses a single string into a list of lines. Empty strings in the
  ;; output list signify a separate slide
  (define (to-lines str last-line lines)
    (cond
      [(not (non-empty-string? str)) (cons last-line lines)]
      [else ; If first char is a newline, we create a new thing to add to lines
       ; Otherwise we just add
       (define first-str (substring str 0 1))
       (define rest-str (substring str 1))
       (if (equal? first-str "\n")
           (to-lines rest-str "" (cons last-line lines))
           (to-lines rest-str (string-append last-line first-str) lines))]))
  ;; This is a list of lines; slides are separated by an empty line

  ;; (to-slides Listof String Listof Listof String)
  ;; This parses a list of strings into a list of lists of strings
  (define (to-slides los last-slide slides)
    (cond
      [(empty? los) (cons last-slide slides)]
      [else
       (define first-line (first los))
       (define rest-lines (rest los))
       (if (equal? first-line "")
           (to-slides rest-lines '() (cons last-slide slides))
           (to-slides rest-lines (append last-slide (list first-line))
                      slides))]))
  (reverse (to-slides (reverse (to-lines str "" '())) '() '())))

;; MACROS ---------------------------------------------------------

;; SYNTAX (line name String)
;; SEMANTICS binds name to the string
;; INTERPRETATION represents a single line of a song
(define-syntax (line stx)
  (syntax-parse stx
    [(_ name:id content)
     #'(define name content)]))

;; SYNTAX (section name (list line ...))
;; SEMANTICS binds name to the list of lines
;; INTERPRETATION represents a single slide of lines for a song

(define-syntax (section stx)
  (syntax-parse stx
    [(_ name:id lines)
     #'(define name lines)]))

;; SYNTAX (song name (list section ...))
;; SEMANTICS binds name to the list of sections
;; INTERPRETATION represents a full song, separated into
;; each individual slide

(define-syntax (song stx)
  (syntax-parse stx
    [(_ name:id sections)
     #'(define name sections)]))