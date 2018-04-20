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
 song)

;; DEPENDENCIES ---------------------------------------------------

(require (for-syntax syntax/parse))

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