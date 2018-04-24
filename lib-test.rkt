#lang lyrics

;; A simple test of the lyrics library/language

;; Set the background image
(set-back! "back/dark-blue.jpeg")

;; Set the title, which will appear in large text
(title "Ob-La-Di")

;; Set the font color - this should affect only the lyrics
;; because we have already made the font slide
(set-font-color! "steelblue")
(set-font! "Calibri")

;; If you wanted to change the font color for the title you
;; should put it before the title declaration

;; At the end, specify the source file
;; to generate and run the slideshow
(source "oldold.txt")

;; Also we can do advanced things with the regular slideshow tools
;; since we have exported those from main.rkt