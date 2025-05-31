;;;; moby-dick.el --- Minor mode for writing overrides for formatting TEI-encoded 'Moby-Dick'
;; Copyright (C) 2025 Antenna House

;; Author: Tony Graham, Antenna House <tgraham@antenna.co.jp>
;; Contributors: 
;; Created: 5 June 2025
;; Keywords: xsl-fo, xslt, xml

;;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


(require 'nxml-mode)

(setq moby-dick-xslt-file "moby-dick.xsl")

(setq moby-dick-insertion-target "</xsl:stylesheet>")

(defun moby-dick-where ()
  "Display the hierarchy of XML elements the point is on as a location path."
  (interactive)
  (let ((location-path nil)
	(name "")
	(count 0))
    (save-excursion
      (save-restriction
        (widen)
	(if (looking-at "<")
	    (forward-char))
        (while (and (< (point-min) (point)) ;; Doesn't error if point is at beginning of buffer
                    (condition-case nil
                        (progn
                          (nxml-backward-up-element) ; always returns nil
			  (setq count 1)
			  (save-excursion
			    (setq name (xmltok-start-tag-local-name))
			    (while (condition-case nil
				       (progn
					 (nxml-backward-element)
					 (if (equal name (xmltok-start-tag-local-name))
					     (setq count (1+ count)))
					 t)
				     (error nil))))
                          t)
                      (error nil)))
          (setq location-path (cons (cons name  count) location-path)))))
    (setq location-path
	    (format "/%s"
		     (mapconcat
		      (lambda (e) (format "%s[%d]" (car e) (cdr e)))
		      location-path "/")))
    (if (called-interactively-p t)
	(message "%s" location-path)
      location-path)))

(defvar moby-dick-exerpt-history nil)

(defun moby-dick-read-exerpt ()
  "Read regexp arg for Moby-Dick experpt using `read-regexp'."
  (read-regexp "Exerpt" 'grep-tag-default 'moby-dick-exerpt-history))

(defun moby-dick-create-override-template (exerpt page)
  (interactive
   (let* ((exerpt (moby-dick-read-exerpt))
	  (default-page (save-excursion
			  (save-match-data
			    (re-search-backward "<pb n=\"[^-]+-\\([^\"]+\\)" nil t)
			    (match-string 1))))
	  (page (read-from-minibuffer
		 (format "Page number: ")
		 default-page)))
     (list exerpt page)))
  (setq location-path
	(string-replace
	 "/TEI[1]/text[1]"
	 "/TEI/text"
	 (moby-dick-where)))
  (switch-to-buffer-other-window moby-dick-xslt-file)
  (goto-char (point-max))
  (search-backward insertion-target)
  (insert (format "<!-- '%s...' (pg. %s) -->\n" exerpt page))
  (insert (format "<xsl:template\n    match=\"%s\">\n  <xsl:next-match>\n    <xsl:with-param name=\"atts\" as=\"attribute()*\">\n" location-path))
  (save-excursion
    (insert "    </xsl:with-param>\n  </xsl:next-match>\n</xsl:template>\n\n"))
  ; Go straight to inserting xsl:attribute, as best I know how.
  (let ((name-value (moby-dick-xsl-attribute-args)))
    (moby-dick-xsl-attribute (car name-value) (car (cdr name-value))))
  )

(defvar moby-dick-attribute-name-history nil)
(defvar moby-dick-attribute-value-history-alist nil)

(defun moby-dick-xsl-attribute-args ()
  "Insert an 'xsl:attribute'."
  ;;(interactive "sName: \nsValue: ")
  (interactive
   (let* ((name (read-from-minibuffer
		 (format "Name: ")
		 nil nil nil 'moby-dick-attribute-name-history))
	  (history (cdr (assoc name moby-dick-attribute-value-history-alist)))
	  (value (read-from-minibuffer
		  (format "Value: ")
		  nil nil nil 'history)))
     ;;(message "%s:%s:%s:%s" name value history moby-dick-attribute-value-history-alist)
     (if (assoc name moby-dick-attribute-value-history-alist)
	 (setcdr (assoc name moby-dick-attribute-value-history-alist) history)
       (add-to-list 'moby-dick-attribute-value-history-alist
		    (cons (format "%s" name) (list (format "%s" value)))))
     ;;(message "%s" moby-dick-attribute-value-history-alist)
     (list name value)))

(defun moby-dick-xsl-attribute (&optional name value)
  "Insert an 'xsl:attribute'."
  ;;(interactive "sName: \nsValue: ")
  (interactive (moby-dick-xsl-attribute-args))
  (insert (format
	   "      <xsl:attribute name=\"%s\" select=\"'%s'\" />\n"
	   name
	   value)))

(define-minor-mode moby-dick-mode
  "Minor mode for overriding 'Moby-Dick' formatting."
  :lighter " M-D"
  :interactive (list 'nxml-mode))
