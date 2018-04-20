#lang racket

;; Ob-La-Di, Ob-La-Da

(require "lib-slideshow.rkt"
         "lib.rkt")

(set-back! "back/trip.jpg")

(section v1
         '("Desmond has a barrow in the marketplace"
           "Molly is the singer in a band"
           "Desmond says to Molly, girl, I like your face"
           "And Molly says this as she takes him by the hand"))
(section c
         '("Ob la di, ob-la-da, life goes on, bra"
           "La-la, how the life goes on"
           "Ob-la di, ob-la-da, life goes on, bra"
           "La-la, how the life goes on"))
(section v2
         '("Desmond takes a trolley to the jeweller's store"
           "Buys a twenty carat golden ring"
           "Takes it back to Molly waiting at the door"
           "And as he gives it to her she begins to sing"))
(section v3
         '("In a couple of years they have built"
           "A home sweet home"
           "With a couple of kids running in the yard"
           "Of Desmond and Molly Jones"))
(section v4
         '("Happy ever after in the market place"
           "Desmond lets the children lend a hand"
           "Molly stays at home and does her pretty face"
           "And in the evening she still sings it with the band"))
(section end
         '("And if you want some fun, sing ob-la-di, bla-da"))

(song oldold (list v1 c v2 c v3 v4 c c end))
(song->slide oldold)