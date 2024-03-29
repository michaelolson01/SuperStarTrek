(defvar *d* (make-array '(8) :initial-element "NO"))
(defvar *f* (make-array '(8) :initial-element "NO"))
(defvar *n* (make-array '(8) :initial-element "NO"))
(defvar *k* (make-array '(8) :initial-element "NO"))
(defvar *w* (make-array '(8) :initial-element "NO"))
(defvar *p* (make-array '(8) :initial-element "NO"))
(defvar *r* (make-array '(8) :initial-element "NO"))
(defvar *e* (make-array '(8) :initial-element "NO"))
(defvar *b* (make-array '(8) :initial-element "NO"))

(defun initialize ()
  (format t "SUPER STAR TREK~%   ~%")
  (format t "THE FEDERATION IS BEING~%")
  (format t "INVADED BY THE KLINGON~%")
  (format t "EMPIRE. YOUR MISSION IS~%")
  (format t "TO DESTROY THEIR STAR~%")
  (format t "BASES AND SAVE THE~%")
  (format t "FEDERATION. GOOD LUCK!~%   ~%")
  (setf *d* (make-array '(8) :initial-element "NO"))
  (setf *f* (make-array '(8) :initial-element "NO"))
  (setf *n* (make-array '(8) :initial-element "NO"))
  (setf *k* (make-array '(8) :initial-element "NO"))
  (setf *w* (make-array '(8) :initial-element "NO"))
  (setf *p* (make-array '(8) :initial-element "NO"))
  (setf *r* (make-array '(8) :initial-element "NO"))
  (setf *e* (make-array '(8) :initial-element "NO"))
  (setf *b* (make-array '(8) :initial-element "NO"))
  (setf *p* 5))

(defun rnd (x)
  (random x))

(defun dispatch ()
  (format t "COMMAND? ")
  (let ((command (read)))
    (cond ((equal command 'nav) (navigation))
          ((equal command 'srs) (short-range-scan))
          ((equal command 'lrs) (long-range-scan))
          ((equal command 'pha) (phasers))
          ((equal command 'tor) (torpedoes))
          ((equal command 'she) (shield-control))
          ((equal command 'com) (computer-status))
          ((equal command 'xxx) (game-over))
          (t (format t "HUH?~%"))))
  (dispatch))

(defun navigation ()
  (format t "COURSE (1-9): ")
  (let ((course (read)))
    (cond ((or (<= course 0) (> course 9)) (format t "COURSE OUT OF RANGE~%"))
          ((= *p* 0) (format t "WARP ENGINES ARE DAMAGED.~%"))
          ((= course 9) nil)
          (t (loop repeat course do
                    (if (= *p* 0) (return-from navigation))
                    (format t "SPACE OR PLANET: ")
                    (let ((choice (read)))
                      (cond ((equal choice 'planet) (return-from navigation))
                            ((< (rnd 10) 5) (format t "THERE ARE NO STARS HERE.~%"))
                            ((= (rnd 10) 9) (format t "KLINGONS!~%"))
                            ((= (rnd 10) 10) (format t "STARBASE!~%"))
                            (t (format t "DISTANCE: ")
                               (let ((distance (read)))
                                 (cond ((< distance 0) (format t "DISTANCE OUT OF RANGE.~%"))
                                       ((= distance 0) (format t "THAT'S A SHORT TRIP.~%"))
                                       ((> distance *p*) (format t "INSUFFICIENT POWER.~%"))
                                       (t (setf *p* (- *p* distance))
                                          (format t "NAVIGATING...~%")
                                          (loop repeat distance do
                                                (format t "~a---~%" distance)
                                                (dotimes (k 300) nil))
                                          (format t "ARRIVED.~%")
                                          (return-from navigation)))))))))))
  (dispatch))

(defun short-range-scan ()
  (format t "   SRS~%")
  (format t "1 2 3 4 5 6 7 8 9~%")
  (format t "-----------------~%")
  (loop for i from 1 to 8 do
        (format t "~a " i)
        (loop for j from 1 to 9 do
              (format t "~a " (aref *s* i j)))
        (format t "~%"))
  (format t "   ~%")
  (dispatch))

(defun long-range-scan ()
  (format t "   LRS~%")
  (format t "1 2 3 4 5 6 7 8 9~%")
  (format t "-----------------~%")
  (loop for i from 1 to 8 do
        (format t "~a " i)
        (loop for j from 1 to 9 do
              (if (or (<= (abs (- i *a*)) 1) (<= (abs (- j *b*)) 1))
                  (format t "* ")
                  (format t " ")))
        (format t "~%"))
  (format t "   ~%")
  (dispatch))

(defun phasers ()
  (format t "PHASER CONTROL~%   ~%")
  (format t "ENEMY SHIPS LEFT: ~a~%" *e*)
  (format t "PHASER ENERGY:    ~a~%" *p*)
  (format t "   ~%")
  (format t "ENERGY TO FIRE? ")
  (let ((energy (read)))
    (cond ((or (< energy 0) (> energy *p*)) (format t "WEAPON MALFUNCTION.~%"))
          ((= *e* 0) (format t "NO ENEMY SHIPS.~%"))
          ((> energy *e*) (format t "WEAPON MALFUNCTION.~%"))
          (t (format t "   ~%")
             (format t "FIRING PHASERS...~%")
             (loop repeat energy do
                   (format t "~a---~%" energy)
                   (dotimes (k 300) nil))
             (format t "HIT.~%")
             (setf *e* (- *e* energy)))))
  (dispatch))

(defun torpedoes ()
  (format t "TORPEDO CONTROL~%   ~%")
  (format t "ENEMY STAR BASES: ~a~%" *b*)
  (format t "PHOTON TORPEDOES: ~a~%" *t*)
  (format t "   ~%")
  (format t "TORPEDO COURSE? ")
  (let ((course (read)))
    (cond ((or (< course 1) (> course 9)) (format t "COURSE OUT OF RANGE~%"))
          ((= *t* 0) (format t "NO TORPEDOES.~%"))
          ((= course 9) (format t "TORPEDO LOCKED.~%"))
          (t (format t "MISS.~%"))))
  (dispatch))

(defun shield-control ()
  (format t "SHIELD CONTROL~%   ~%")
  (format t "SHIELDS ARE ~a~%" *s*)
  (format t "   ~%")
  (format t "NEW SHIELD STATUS? ")
  (let ((status (read)))
    (cond ((equal status 'up) (setf *s* "UP"))
          ((equal status 'down) (setf *s* "DOWN"))
          (t (format t "UNKNOWN STATUS.~%"))))
  (dispatch))

(defun computer-status ()
  (format t "COMPUTER STATUS~%   ~%")
  (format t "ENEMY SHIPS LEFT: ~a~%" *e*)
  (format t "ENEMY STAR BASES: ~a~%" *b*)
  (format t "PHASER ENERGY:    ~a~%" *p*)
  (format t "PHOTON TORPEDOES: ~a~%" *t*)
  (format t "   ~%")
  (dispatch))

(defun game-over ()
  (format t "   ~%")
  (if (= *e* 0)
      (format t "THE FEDERATION IS SAFE.~%")
      (format t "THE FEDERATION IS DOOMED.~%"))
  (format t "   ~%")
  (format t "   GAME OVER~%   ~%")
  (initialize)
  (dispatch))

(defun play-super-star-trek ()
  (initialize)
  (dispatch))

(play-super-star-trek)