;;;; alice.lisp

(in-package #:alice)

;;; "alice" goes here. Hacks and glory await!

(defclass course ()
  ((students :accessor students :initarg :students)
   (name :accessor name :initarg :name)
   (classes :accessor classes :initarg :classes :initform (list))))

(defmethod find-class-by-name ((self course) (name string))
  (find name (classes self) :test #'string= :key #'name))

(defclass dance-class ()
  ((moves :accessor moves :initarg :moves)
   (name :accessor name :initarg :name)))

(defclass db ()
  ((moves :accessor moves :initform nil)
   (courses :accessor courses :initform nil)
   (students :accessor students :initform nil)))

(defvar *db* nil)
(defun load-db ()
  (setf *db* (cl-store:restore "/home/ryan/alice.cl-store")))

(defun save-db (&optional (db *db*))
  (cl-store:store db "/home/ryan/alice.cl-store")
  (setf *db* db))

(defun make-classes (move-str)
  (iter (for moves in (split-sequence #\newline move-str))
	(for i from 1)
	(collect (make-instance 'dance-class
				:name i
				:moves (iter (for m in (split-sequence #\, moves))
					     (collect (string-trim " " m)))))))

(defun %data-entry ()
  (push 
   (make-instance 'course
		 :name "Shambling Shimmies Tribal Belly Dance Format: Moves and Cues – Level 1 Part 1"
		 :classes (make-classes "Taxim, Singles, Double Shimmy
Maya, Choo-Choo (w/o arc turn)
Reach & Lean Combo, Hip Drop / Hip Drop – Kick
Basic Arms, ¾ Shimmy / Shimmy Walk
Horizontal Figure 8′s w/ turn, Egyptian w/ turns
Body Roll, Arabic")
		 :students '("Tara" "Kristin" "Brittany" "Joyce")
		 )
   (courses *db*))
  (save-db)
  )

(defvar *cc* nil)

(defun wiki-heading-text (content)
  (string-trim "= " (first (split-sequence #\newline content :count 1))))

(defun current-course ()
  (first (courses *db*)))
