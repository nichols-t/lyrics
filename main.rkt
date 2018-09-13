#lang slideshow

;; Provides a library to turn the definitions into slides
;; Can turn a single section into a slide, or a list of sections
;; into an entire slideshow

;; DEPENDENCIES --------------------------------------------------

(require (for-syntax syntax/parse)
         "lib.rkt"
         slideshow/text
         racket/draw
         values+)

;; PROVIDES ------------------------------------------------------

(provide
 ;; (set-back! Path)
 ;; Set the background image to whatever is at the given path
 set-back!
 ;; (font-color)
 ;; Get the current font color
 font-color
 ;; (set-font-color! ColorString)
 ;; Set the font to the given color
 set-font-color!
 ;; (set-font-size! N)
 ;; Set the font to the given size
 set-font-size!
 ;; (set-font! FamilyName)
 ;; Set the font size to the given family name
 set-font!
 ;; (source Path.txt)
 ;; Read lyrics from the textfile at the given path and make the slideshow
 source
 ;; (title String)
 ;; Create a title slide with the given string
 title
 ;; (get-colors)
 ;; Get a list of the colors you can use
 get-colors
 ;; (get-fonts)
 ;; Get a list of the fonts you can use
 get-fonts
 ;; Set the text to be center or top aligned
 align-top!
 align-center!
 ;; More advanced things can be done with the regular slideshow bindings
 (all-from-out slideshow))

;; SOME DEFAULT VALUES -------------------------------------------
(current-main-font "Arial")
(current-font-size 36)
(define default-back "back/black.png")
(set-margin! 0)
(define font-color "white")
(define alignment 'center)
(define para-width (- 1024 40))
(define para-align 'center)

;; FUNCTIONS -----------------------------------------------------

;; The slide assembler, which will use the background image

(current-slide-assembler
 (lambda (s v-sep c)
   (ct-superimpose
    (scale-to-fit (bitmap default-back) 1024 768 #:mode 'distort)
    (let ([c (colorize c font-color)])
      c))))

;; (song->slides Song)
;; creates a slideshow out of the given song
(define (song->slide song)
  (apply values (map (λ (section) (section->slide section)) song)))

;; (section->slide Section)
;; turn a single section into a single slide
(define (section->slide section)
  (lines->slide section))

;; Add a title slide with big text
(define (title str)
  (slide #:layout alignment (big (t str))))

;; Change the default background color
(define (set-back! path)
  (set! default-back path))

;; Change the default font
(define (set-font! str)
  (current-main-font str))

;; Change the default font color
(define (set-font-color! color-str)
  (set! font-color color-str))

;; Change the default font size
(define (set-font-size! size)
  (current-font-size size))

;; Return the list of valid color strings
(define (get-colors)
  (send the-color-database get-names))

;; Return the list of valid fonts
(define (get-fonts)
  (get-face-list))

;; Sets the alignment of the text to be top-aligned
(define (align-top!)
  (set! alignment 'top))

;; Sets the alignment of the text to be center-aligned
(define (align-center!)
  (set! alignment 'center))


;; MACROS ------------------------------------------------------------

;; SYNTAX (source String)
;; SEMANTICS a path for the lyrics
;; INTERPRETATION give a path to the textfile containing the lyrics
;; And creates a slideshow from those lyrics
;; This should be the last line

(define-syntax (source stx)
  (syntax-parse stx
    [(_ path)
     #'(song->slide
        (string->slides
                     (port->string
                      (open-input-file path #:mode 'text))))]))

;; SYNTAX (line->slide String ...)
;; SEMANTICS constructs a slide with the given strings as lines

(define-syntax (lines->slide stx)
  (syntax-parse stx
    [(_ lines)
     #'(call-with-values+
        (λ () (apply values+ (map (λ (line) (t line)) lines) #:layout alignment))
        slide)]))

;; This is the stuff we need to turn this into an actual language
;; All we do is provide the regular reader, so this is sort of pointless
;; But now we can type #lang lyrics and this file will be automatically
;; provided, so that's nice because users don't care about Racket's
;; module system.

;; ------------------------------------------------------------------
(module reader syntax/module-reader
  lyrics
  #:read
  read
  #:read-syntax
  read-syntax)