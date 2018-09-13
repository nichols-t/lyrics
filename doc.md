# User Guide

Lyrics is a simple library built on top of Racket's slideshow language that will make it very easy for you to create slideshows with song lyrics.

## Workflow

### 1. Installation
Run the `make-package.rkt` in [DrRacket](https://racket-lang.org/) to install lyrics.

### 2. Copy lyrics into a textfile  
Go to your favorite lyrics site and copy the song lyrics into a textfile. Make sure that each line is separated by exactly one newline,
and each slide is separated by an additional newline. An example is shown below:

Desmond has a barrow in the marketplace  
Molly is the singer in a band  
Desmond says to Molly, girl, I like your face  
And Molly says this as she takes him by the hand  

Ob la di, ob-la-da, life goes on, bra  
La-la, how the life goes on  
Ob-la di, ob-la-da, life goes on, bra  
La-la, how the life goes on  


The above text will create two slides with four lines each. Save the textfile.

### 3. Create a Lyrics file  
You must now create a racket file. Change the #lang line to read `#lang lyrics`. Now you can begin formatting
  #### a. Formatting  
  Format the slideshow as you wish. The formatting options are detailed below.
  #### b. Source textfile  
  Type `(source <path-to-textfile>)` to generate the slideshow. Please note that this will only use formatting options typed before
  it. You can do this multiple times with different formatting options to make a multiple-song slideshow.

## Formatting Options

`(set-back! <path-to-background-image>)` : set the background of the slideshow to the background image at the given path. Most image formats
are supported.  

`(set-font-color! <color>)` : sets the color of the text to the given color. `(get-colors)` in DrRacket's interactions window
will return the list of colors you can use.  

`(set-font-size! <number>)` : sets the size of the text.  

`(set-font! <Font Name>)` : sets the current font being used to draw the text. `(get-fonts)` in DrRacket's interactions window
will return the list of fonts you can use.  

`(title <String>)` : creates a title slide with slightly larger text. This will be inserted at the point you write it, so be sure
to put it before your `source` call to make sure it appears at the front.  

`(align-top!)` : aligns your text to the top of the slide instead of the center. Useful if you have things in the way near the bottom of a projector screen.

`(align-center)` : aligns your text to the center of the slide. This is the default option, and can be overridden by `(align-top!)`.
