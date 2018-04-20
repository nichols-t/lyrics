#lang slideshow

;; Provides a library to turn the definitions into slides
;; Can turn a single section into a slide, or a list of sections
;; into an entire slideshow

;; DEPENDENCIES --------------------------------------------------

(require (for-syntax syntax/parse)
         "lib.rkt")

;; PROVIDES ------------------------------------------------------

(provide
 section->slide
 song->slide
 set-back!)

;; SOME DEFAULT VALUES -------------------------------------------
(current-main-font "Arial")
(define default-back "eigengrau.png")
(set-margin! 0)

;; FUNCTIONS -----------------------------------------------------

;; The slide assembler, which will use the background image

(current-slide-assembler
 (lambda (s v-sep c)
   (cc-superimpose
    (scale-to-fit (bitmap default-back) 1024 768 #:mode 'distort)
    (let ([c (colorize c "white")])
      c))))

;; (song->slides Song)
;; creates a slideshow out of the given song
(define (song->slide song)
  (apply values (map (λ (section) (section->slide section)) song)))

;; (section->slide Section)
;; turn a single section into a single slide
(define (section->slide section)
  (call-with-values
   (λ () (apply values (map (λ (line) (t line)) section)))
   slide))

;; Change the default background color
(define (set-back! path)
  (set! default-back path))

;; Brief example song

(section a '("Hello" "World" "This" "Is" "A Slide"))
(section b '("I" "Am" "Another" "Slide"))
(song ab (list a b))
#;
(song->slide ab)