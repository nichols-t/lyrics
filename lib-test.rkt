#lang racket

;; A simple test of the lyrics library

(require "lib-slideshow.rkt"
         "lib.rkt")

(set-back! "cluster.jpg")

(section verse1
         '("When I find myself in times of trouble"
           "Mother Mary comes to me"
           "Speaking words of wisdom"
           "\"Let it Be\""))
(section verse2
         '("And in my hour of darkness"
           "She is standing right in front of me"
           "Speaking words of wisdom"
           "\"Let it Be\""))
(section chorus
         '("Let it be, let it be, let it be, let it be"
           "Whisper words of wisdom"
           "Let it be"))
(section verse3
         '("And when the brokenhearted people"
           "Living in the world agree"
           "There will be an answer"
           "Let it be"))
(section verse4
         '("For though they may be parted"
           "There is still a chance that they will see"
           "There will be an answer"
           "Let it be"))

(song let-it-be (list verse1 verse2 chorus verse3 verse4 chorus chorus))
(song->slide let-it-be)