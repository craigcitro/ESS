;;;;; ess-vars.el --- Variable definitions for ESS.

;; Copyright (C) 1997 A.J. Rossini

;; Author: A.J. Rossini <rossini@stat.sc.edu>
;; Maintainer: A.J. Rossini <rossini@stat.sc.edu>
;; Created: 25 July 1997
;; Modified: $Date: 1998/12/11 19:09:34 $
;; Version: $Revision: 5.10 $
;; RCS: $Id: ess-vars.el,v 5.10 1998/12/11 19:09:34 rossini Exp $

;; Keywords: editing and process modes.

;; This file is part of ESS

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
;;
;; In short: you may use this code any way you like, as long as you
;; don't charge money for it, remove this notice, or hold anyone liable
;; for its results.

;;; Code:

(defconst ess-version "5.1.2"
  "Version of ESS currently loaded.")


(defvar no-doc
  "This function is part of ESS, but has not yet been loaded.
Full documentation will be available after autoloading the function."
  "Documentation for autoload functions.")

 ; User changeable variables

;;; Common user changeable variable are described and documented in
;;; ess-site.el.  Please check there first!
;;;=====================================================
;;; In general: Variables with document strings starting with a * are
;;; the ones you can generally change safely, and may have to upon
;;; occasion.

;;*;; Options and Initialization

(defvar ess-use-menus t
  "If t, use the menu system.")

(defvar ess-ask-for-ess-directory t
  "*If non-nil, the process directory will be requested each time S is run")

(defvar ess-ask-about-transfile nil
  "*If non-nil, asks about a transcript file before running ess")

(defvar ess-language nil
  "*Prefix of all ESS processes, and defines the dialect in use.
Currently acceptable values are 'S',  'XLS', 'SAS'.
Can be changed, e.g., to `R'.  Use `setq-default' if setting it in
.emacs (also see ess-site.el).")

(make-variable-buffer-local 'ess-language)
(setq-default ess-language "Initial")

(defvar ess-dialect nil
  "String version of the dialect being run for the inferior process.
This, plus ess-language, should be able to determine the exact
version of the statistical package being executed in the particular
buffer.

Current values could include:
for `ess-dialect' = S3, S4, S+3, S+4, S+5, R, XLS, SAS, STA

Used to adjust for changes in versions of the program")

(make-variable-buffer-local 'ess-dialect)
(setq-default ess-dialect "Initial-dialect")

(defvar ess-directory nil
  "*The directory ESS is run from.  It must end in a slash.
Provided as a default if ess-ask-for-ess-directory is non-nil.
A nil value means use the current buffer's default directory.
Buffer-local: in process buffers, this contains the directory ESS was
run from.")

;;(make-variable-buffer-local 'ess-directory)
;;(setq-default ess-directory nil)

(defvar ess-history-file nil
  "*File to pick up history from.
If this is a relative file name, it is relative to ess-directory.")

(defvar ess-plain-first-buffername t
  "*No fancy process buffname for the first process of each type (novice mode).")

;;*;; Variables concerning editing behaviour

(defvar ess-filenames-map t
  "Declares if the filenames in an attached directory are the same
as objects in that directory (when t). This is not true for DOS and
other OS's with limited filename lengths.  Even if this is set
incorrectly, the right things will probably still happen, however.")

(defvar ess-keep-dump-files 'ask
  "*Variable controlling whether to delete dump files after a successful load.
If nil: always delete.  If `ask', confirm to delete.  If `check', confirm
to delete, except for files created with ess-dump-object-into-edit-buffer.
Anything else, never delete.  This variable only affects the behaviour
of ess-load-file.  Dump files are never deleted if an error occurs
during the load. ")

;;; Boolean flag which determines what to do with the dump files
;;; generated by \\[ess-dump-object-into-edit-buffer], as follows:
;;;
;;; 	If nil: dump files are deleted after each use, and so appear
;;; only transiently. The one exception to this is when a loading error
;;; occurs, in which case the file is retained until the error is
;;; corrected and the file re-loaded.
;;;
;;; 	If non-nil: dump files are not deleted, and backups are kept
;;; as usual.  This provides a simple method for keeping an archive of S
;;; functions in text-file form.
;;;
;;; Auto-save is always enabled in dump-file buffers to enable recovery
;;; from crashes.

(defvar ess-delete-dump-files nil
  "*If non-nil, delete dump files after they are created.
This applies to dump files created with ess-dump-object-into-edit-buffer, only.

This is useful to prevent sources file being created for objects
you don't actually modify.  Once the buffer is modified and saved
however, the file is not subsequently unless ess-keep-dump-files is
nil, and the file is successfully loaded back into S.")

;;; From ess-mode:

(defvar ess-mode-silently-save t
  "*If non-nil, automatically save ESS source buffers before loading")

;;*;; Variables controlling editing

;;;*;;; Edit buffer processing
(defvar ess-function-template " <- function( )\n{\n\n}\n"
  "If non-nil, function template used when editing nonexistent objects.

The edit buffer will contain the object name in quotes, followed by
this string. Point will be placed after the first parenthesis or
bracket.")

;;; By K.Shibayama 5.14.1992
;;; Setting any of the following variables in your .emacs is equivalent
;;; to modifying the DEFAULT style.

;;;*;;; Indentation parameters

(defvar ess-auto-newline nil
  "*Non-nil means automatically newline before and after braces
inserted in S code.")

(defvar ess-tab-always-indent t
  "*Non-nil means TAB in S mode should always reindent the current line,
regardless of where in the line point is when the TAB command is used.")

(defvar ess-indent-level 2
  "*Indentation of S statements with respect to containing block.")

(defvar ess-brace-imaginary-offset 0
  "*Imagined indentation of an open brace following a statement.")

(defvar ess-brace-offset 0
  "*Extra indentation for open braces.
Compares with other text in same context.")

(defvar ess-continued-statement-offset 2
  "*Extra indent for lines not starting new statements.")

(defvar ess-continued-brace-offset 0
  "*Extra indent for substatements that start with open-braces.
This is in addition to ess-continued-statement-offset.")

(defvar ess-arg-function-offset 2
  "*Extra indent for internal substatements of function `foo' that called
in `arg=foo(...)' form.
If not number, the statements are indented at open-parenthesis following foo.")

;;added rmh 2Nov97 at request of Terry Therneau
(defvar ess-close-brace-offset 0
  "*Extra indentation for closing braces")

;;added rmh 2Nov97 at request of Terry Therneau
(defvar ess-fancy-comments t
  "*Non-nil means distiguish between #, ##, and ### for indentation")


;; PD, 1Apr97 :
;;The default ess-else-offset should be 0, not 2 IMHO (try looking at
;;the ls() function, for instance).  Was 2.
(defvar ess-else-offset 0
  "*Extra indent for `else' lines.")

(defvar ess-expression-offset 4
  "*Extra indent for internal substatements of `expression' that specified
in `obj <- expression(...)' form.
If not number, the statements are indented at open-parenthesis following
`expression'.")

;;;*;;; Editing styles

(defvar ess-default-style-list
  (list 'DEFAULT
	(cons 'ess-indent-level ess-indent-level)
	(cons 'ess-continued-statement-offset ess-continued-statement-offset)
	(cons 'ess-brace-offset ess-brace-offset)
	(cons 'ess-expression-offset ess-expression-offset)
	(cons 'ess-else-offset ess-else-offset)
	(cons 'ess-brace-imaginary-offset ess-brace-imaginary-offset)
	(cons 'ess-continued-brace-offset ess-continued-brace-offset)
	(cons 'ess-arg-function-offset ess-arg-function-offset)
	(cons 'ess-close-brace-offset ess-close-brace-offset))
  "Default style constructed from initial values of indentation variables.")

(defvar ess-style-alist
  (cons ess-default-style-list
	'((GNU (ess-indent-level . 2)
	       (ess-continued-statement-offset . 2)
	       (ess-brace-offset . 0)
	       (ess-arg-function-offset . 4)
	       (ess-expression-offset . 2)
	       (ess-else-offset . 0)
	       (ess-close-brace-offset . 0))
	  (BSD (ess-indent-level . 8)
	       (ess-continued-statement-offset . 8)
	       (ess-brace-offset . -8)
	       (ess-arg-function-offset . 0)
	       (ess-expression-offset . 8)
	       (ess-else-offset . 0)
	       (ess-close-brace-offset . 0))
	  (K&R (ess-indent-level . 5)
	       (ess-continued-statement-offset . 5)
	       (ess-brace-offset . -5)
	       (ess-arg-function-offset . 0)
	       (ess-expression-offset . 5)
	       (ess-else-offset . 0)
	       (ess-close-brace-offset . 0))
	  (C++ (ess-indent-level . 4)
	       (ess-continued-statement-offset . 4)
	       (ess-brace-offset . -4)
	       (ess-arg-function-offset . 0)
	       (ess-expression-offset . 4)
	       (ess-else-offset . 0)
	       (ess-close-brace-offset . 0))
	  ;; CLB added rmh 2Nov97 at request of Terry Therneau
	  (CLB (ess-indent-level . 2)
	       (ess-continued-statement-offset . 4)
	       (ess-brace-offset . 0)
	       (ess-arg-function-offset . 0)
	       (ess-expression-offset . 4)
	       (ess-else-offset . 0)
	       (ess-close-brace-offset . 2))))
  "Predefined formatting styles for ess code")

(defvar ess-default-style 'DEFAULT
  "*The default value of ess-style")

(defvar ess-style ess-default-style
  "*The buffer specific ESS indentation style.")

;;*;; Variables controlling behaviour of dump files

(defvar ess-source-directory "/tmp/"
  "*Directory in which to place dump files.
This can be a string (an absolute directory name ending in a slash) or
a lambda expression of no arguments which will return a suitable string
value.  The lambda expression is evaluated with the process buffer as the
current buffer.")
;;; Possible value:
;;; '(lambda () (file-name-as-directory
;;;	      (expand-file-name (concat (car ess-search-list) "/.Src"))))
;;; This always dumps to a sub-directory (".Src") of the current ess
;;; working directory (i.e. first elt of search list)

(defvar ess-dump-filename-template (concat (user-login-name) ".%s.S")
  "*Template for filenames of dumped objects.
%s is replaced by the object name.")
;;; This gives filenames like `user.foofun.S', so as not to clash with
;;; other users if you are using a shared directory. Other alternatives:
;;; "%s.S" ; Don't bother uniquifying if using your own directory(ies)
;;; "dump" ; Always dump to a specific filename. This makes it impossible
;;;          to edit more than one object at a time, though.
;;; (make-temp-name "scr.") ; Another way to uniquify



;;*;; Hooks

(defvar ess-mode-hook '()
  "*Hook for customizing ESS each time it is entered.")

(defvar ess-mode-load-hook '()
  "*Hook to call when ess.el is loaded.")

(defvar ess-pre-run-hook nil
  "*Hook to call before starting up ESS.
Good for setting up your directory.")

(defvar ess-post-run-hook nil
  "*Hook to call just after the ESS process starts up.
Good for evaluating ESS code.")

(defvar inferior-ess-mode-hook '()
  "*Hook for customizing inferior ess mode.
Called after inferior-ess-mode is entered and variables have been initialised.")

(defvar ess-help-mode-hook nil
  "Functions to call when entering ess-help-mode. ")

(defvar ess-send-input-hook nil
  "Hook called just before line input is sent to the process")

(defvar ess-transcript-mode-hook nil
  "Hook for customizing ESS transcript mode.")

 ; System variables

(defvar ess-local-process-name nil
  "The name of the ess process associated with the current buffer.")

(make-variable-buffer-local 'ess-local-process-name)


;;*;; Regular expressions

(defvar ess-function-pattern
  (concat
;;-    "\\(" ; EITHER
;;-    "\\s\"" ; quote
;;-    "\\(\\sw\\|\\s_\\)+" ; symbol
;;-    "\\s\"" ; quote
;;-    "\\s-*\\(<-\\|_\\)\\(\\s-\\|\n\\)*" ; whitespace, assign, whitespace/nl
;;-    "function\\s-*(" ; function keyword, parenthesis
;;-    "\\)\\|\\(" ; OR
;;-    "\\<\\(\\sw\\|\\s_\\)+" ; symbol
;;-    "\\s-*\\(<-\\|_\\)\\(\\s-\\|\n\\)*" ; whitespace, assign, whitespace/nl
;;-    "function\\s-*(" ; function keyword, parenthesis
;;-    "\\)")
   ;;----- new version by  "Stephen C. Pope" <scp@predict.com> :
   "\\(\\(" ; EITHER
   "\\s\"" ; quote
   "\\(\\sw\\|\\s_\\)+\\(<-\\)?" ; symbol (replacement?)
   "\\s\"" ; quote
   "\\)\\|\\(" ; OR
;;   "\\<\\(\\sw\\|\\s_\\)+" ; symbol
;;   "[0-9a-zA-Z0-9$.]+" ; symbol
   "\\(^\\|[ ]\\)" ; beginning of name
   "\\(\\sw\\|\\s_\\)+" ; symbol
   "\\)\\)" ; END EITHER OR
   "\\s-*\\(<-\\|_\\|=\\)" ; whitespace, assign, whitespace/nl
   "\\(\\(\\s-\\|\n\\)*\\s<.*\\s>\\)*" ; whitespace, comment
   "\\(\\s-\\|\n\\)*function\\s-*(" ; whitespace, function keyword, parenthesis
   )
  "The regular expression for matching the beginning of an S function.")

(defvar ess-dumped-missing-re
  "\\(<-\nDumped\n\\'\\)\\|\\(<-\\(\\s \\|\n\\)*\\'\\)"
  "If a dumped object's buffer matches this re, then it is replaced
by ess-function-template.")

(defvar ess-dump-error-re
  (if (string= ess-language "S") "\nDumped\n\\'" "[Ee]rror")
  "Regexp used to detect an error when loading a file.")


 ; ess-inf: variables for inferior-ess.

;;*;; System dependent variables

;; If you need to change the *-program-name variables, do so in
;; ess-site.el.  Do NOT make the changes here!!

(defvar inferior-R-program-name "R"
  "*Program name for invoking an inferior ESS with R().")

(defvar inferior-XLS-program-name "xlispstat"
  "*Program name for invoking an inferior ESS with XLS().")

(defvar inferior-S3-program-name "/disk05/s/S"
  "*Program name for invoking an inferior ESS with S3().")

(defvar inferior-S+3-program-name "Splus"
  "*Program name for invoking an inferior ESS with S+3().")

(defvar inferior-S+4-program-name "Splus"
  "*Program name for invoking an external GUI S+4.")

(defvar inferior-Sqpe+4-program-name "Sqpe"
  "*Program name for invoking an inferior ESS with Sqpe+4().")

(defvar inferior-S-elsewhere-program-name "sh"
  "*Program name for invoking an inferior ESS with S on a different computer.")

(defvar inferior-S4-program-name "S4"
  "*Program name for invoking an inferior ESS with S4().")

(defvar inferior-S+5-program-name "Splus5"
  "*Program name for invoking an inferior ESS with S+5().")

(defvar inferior-SAS-program-name "sas"
  "*Program name for invoking an inferior ESS with SAS().")


;;;;; user settable defaults
(defvar inferior-S-program-name  inferior-S+3-program-name
  "*Program name for invoking an inferior ESS with S().")

(defvar inferior-ess-program nil ;inferior-S-program-name
  "*Default program name for invoking inferior-ess().
The other variables ...-program-name should be changed, for the
corresponding program.")

;;(make-local-variable 'inferior-S-program)
(make-variable-buffer-local 'inferior-ess-program)
(setq-default inferior-ess-program inferior-S-program-name)
;;- (setq inferior-S-program
;;-       (cond ((string= S-proc-prefix "S") "Splus")
;;- 	    ((string= S-proc-prefix "R") "R")
;;- 	    (t "S")
;;- 	    ))



;; AJR: this is a generic function
(defvar inferior-ess-start-args ""
  "*String of arguments passed to the ESS process.
Useful for R and SAS.")

(defvar inferior-ess-start-file nil
  "*File dumped into process, if non-nil.")

(defvar inferior-ess-pager "cat"
  "*Pager to use for reporting help files and similar things.")

(defvar inferior-ess-primary-prompt "[a-zA-Z0-9() ]*> ?"
  "Regular expression used by ess-mode to detect the primary prompt.
Do not anchor to bol with `^'.")

(make-variable-buffer-local 'inferior-ess-primary-prompt)
(setq-default inferior-ess-primary-prompt "[a-zA-Z0-9() ]*> ?")

(defvar inferior-ess-secondary-prompt "+ ?"
  "Regular expression used by ess-mode to detect the secondary prompt.
(This is issued by S to continue an incomplete expression). Do not
anchor to bol with `^'.")

(make-variable-buffer-local 'inferior-ess-secondary-prompt)
(setq-default inferior-ess-secondary-prompt "+ ?")

;;*;; Variables controlling interaction with the S process

(defvar ess-execute-in-process-buffer nil
  "*If non-nil, the ess-execute- commands output to the process buffer.
Otherwise, they get their own temporary buffer.")

(defvar ess-eval-visibly-p t
  "*If non-nil, the ess-eval- commands display the text to be evaluated
in the process buffer.")

(defvar ess-synchronize-evals nil
  "*If t, then all evaluations will synchronize with ess process. This
means ess-mode will wait for S to dent a prompt before sending the next
line of code. This allows users of version 18.57 or less of Emacs to
evaluate large regions of code without causing an error. Users or
18.58 or later usually do not want this feature, since it locks up use
of Emacs until the code has been successfully evaluated by S.")

(defvar ess-eval-visibly-at-end t
  "*If non-nil, the ess-eval- commands display the results of evaluation
  at the bottom of the process buffer.")

(defvar ess-save-lastvalue-command nil
  "Default is currently the S+ version.")

;;(make-variable-buffer-local 'ess-save-lastvalue-command)
;;(setq-default ess-save-lastvalue-command
;;  "assign(\"smode.lvsave\",.Last.value,frame=0)\n")

(defvar ess-retr-lastvalue-command nil
  "Default is currently the S+ version.")

;;(make-variable-buffer-local 'ess-retr-lastvalue-command)
;;(setq-default ess-retr-lastvalue-command
;;	      ".Last.value <- get(\"smode.lvsave\",frame=0)\n")

 ; System variables

;;*;; Variables relating to multiple processes

(defvar ess-current-process-name nil
  "Name of the current S process.")

;; defconst ess-local-process-name now done in S.el

(defvar ess-process-name-list nil
  "Alist of active ess processes.")

;;*;; Inferior ess commands

(defvar inferior-ess-load-command "source(\"%s\")\n"
  "Format-string for building the ess command to load a file.")
;;; This format string should use %s to substitute a file name
;;; and should result in an ess expression that will command the inferior ess
;;; to load that file.

(defvar inferior-ess-dump-command "dump(\"%s\",file=\"%s\")\n"
  "Format-string for building the ess command to dump an object into a file.")
;;; Use first %s to substitute an object name
;;;     second %s substitutes the dump file name.

(defvar inferior-ess-help-command "help(\"%s\")\n"
  "Format-string for building the ess command to ask for help on an object.")
;;; This format string should use %s to substitute an object name.

(make-variable-buffer-local 'inferior-ess-help-command)
(setq-default inferior-ess-help-command "help(\"%s\")\n")


(defvar inferior-ess-exit-command "q()\n"
  "Format-string for building the ess command to exit.")
;;; This format string should use %s to substitute an object name.

(make-variable-buffer-local 'inferior-ess-exit-command)
(setq-default inferior-ess-exit-command "q()\n")


(defvar inferior-ess-search-list-command "search()\n"
  "ess command that prints out the search list.")
;;; i.e. The list of directories and (recursive) objects that ess uses when
;;; it searches for objects.

(defvar inferior-ess-names-command "names(%s)\n"
  "Format string for ess command to extract names from an object.")
;;; %s is replaced by the object name -- usually a list or data frame

(defvar inferior-ess-objects-command "ls()\n" ;; others: in (S) or (R)
  "Format string for ess command to get a list of objects at position %d")
;;; Don't include a newline at the end! Used in ess-execute-objects

(make-variable-buffer-local 'inferior-ess-objects-command)
(setq-default inferior-ess-objects-command "ls()\n")

(defvar inferior-ess-get-prompt-command "options()$prompt\n"
  "Command to find the value of the current S prompt.")

;;*;; Regular expressions

(defvar inferior-ess-prompt nil
  "The regular expression inferior ess mode uses for recognizing prompts.
 Constructed at run time from 'inferior-ess-primary-prompt and
'inferior-ess-secondary-prompt")

(make-variable-buffer-local 'inferior-ess-prompt)

(defvar ess-change-sp-regexp
  "\\(attach(\\([^)]\\|$\\)\\|detach(\\|collection(\\|library(\\)"
  "The regexp for matching the ess commands that change the search path.")

;;*;; Process-dependent variables

(defvar ess-search-list nil
  "Cache of list of directories and objects to search for ess objects.")

(make-variable-buffer-local 'ess-search-list)

(defvar ess-sl-modtime-alist nil
  "Alist of modification times for all ess directories accessed this
session.")  

(make-variable-buffer-local 'ess-sl-modtime-alist)

(defvar ess-sp-change nil
  "This symbol flags a change in the ess search path.")

(make-variable-buffer-local 'ess-sp-change)

(defvar ess-prev-load-dir/file nil
  "This symbol saves the (directory . file) pair used in the last
ess-load-file command.  Used for determining the default in the next one.")

(make-variable-buffer-local 'ess-prev-load-dir/file)

(defvar ess-object-list nil
  ;; This is a list of the currently known object names.  It is
  ;; current only for one command entry; it exists under the
  ;; assumption that the list of objects doesn't change while entering
  ;; a command.
  "Cache of object names")

(make-variable-buffer-local 'ess-object-list)

;;*;; Miscellaneous system variables

(defvar ess-mode-map nil
  "Keymap for ess-mode.")

(defvar ess-external-mode-map nil
  "Keymap for ess-external-mode.")

(defvar ess-eval-map nil
  "Keymap for ess-eval functions.")

(defvar inferior-ess-mode-map nil
  "Keymap for inferior-ess mode.")

(defvar ess-object-name-db-file "ess-namedb"
  "File containing definitions for ess-object-name-db.")

(defvar ess-object-name-db-file-loaded '()
  "List of programs whose name-db file has been loaded.")

(defvar ess-object-name-db nil
  "Alist of lists of object names, with directory names as keys.
The file ess-namedb.el is loaded (if it exists) to define this variable.
See also function ess-create-object-name-db.")

(make-variable-buffer-local 'ess-object-name-db)
(setq-default ess-object-name-db nil)

(defvar ess-loop-timeout 100000
  "Integer specifying how many loops ess-mode will wait for the prompt for
before signaling an error.   This is important for S-PLUS 3.x, not so
important for R or XLispStat.")

(make-variable-buffer-local 'ess-loop-timeout)
(setq-default ess-loop-timeout 100000)

;;;*;;; Font-lock support

;;; for programming, transcript, and inferior process modes.

(defvar inferior-ess-font-lock-input t
  "*If non-nil, input is syntactically font-locked.
If nil, input is in the font-lock-variable-name-face.")

(defvar ess-mode-font-lock-keywords
  '(("<<-\\|<-\\|_\\|->"
     . font-lock-reference-face)
    ("\\<\\(TRUE\\|FALSE\\|T\\|F\\|NA\\|NULL\\|Inf\\|NaN\\)\\>"
     . font-lock-type-face)
    ("\\<\\(library\\|attach\\|detach\\|source\\)\\>"
     . font-lock-reference-face)
    ("\\<\\(while\\|for\\|in\\|repeat\\|if\\|else\\|switch\\|break\\|next\\|return\\|stop\\|warning\\|function\\)\\>" . font-lock-keyword-face)
    ("\\s\"?\\(\\(\\sw\\|\\s_\\)+\\(<-\\)?\\)\\s\"?\\s-*\\(<-\\|_\\)\\(\\s-\\|\n\\)*function"
     1 font-lock-function-name-face t))
  "Font-lock patterns used in ess-mode buffers.")

(defvar inferior-ess-font-lock-keywords
  '(("<<-\\|<-\\|_\\|->"
     . font-lock-reference-face)		; assign
    ("^\\*\\*\\*.*\\*\\*\\*\\s *$"
     . font-lock-comment-face) ; ess-mode msg
    ("\\[,?[1-9][0-9]*,?\\]"
     . font-lock-reference-face)	; Vector/matrix labels
    ("\\<\\(TRUE\\|FALSE\\|T\\|F\\|NA\\|NULL\\|Inf\\|NaN\\)\\>"
     . font-lock-type-face) ; keywords
    ("\\<\\(library\\|attach\\|detach\\|source\\)\\>"
     . font-lock-reference-face) ; modify search list or source new definitions
    ("^Syntax error:"
     . font-lock-reference-face);inferior-ess problems or errors
    ("^Error:"
     . font-lock-reference-face)
    ("^Error in"
     . font-lock-reference-face)
    ("^Dumped"
     . font-lock-reference-face)
    ("^Warning messages:"
     . font-lock-reference-face)
    ("#"
     . font-lock-comment-face) ; comment
    ("^[^#]*#\\(.*$\\)"
     (1 font-lock-comment-face keep t)) ; comments
    ("\\s\"?\\(\\(\\sw\\|\\s_\\)+\\)\\s\"?\\s-*\\(<-\\|_\\)\\(\\s-\\|\n\\)*function"
     1 font-lock-function-name-face t) ; function name
    ("\\<\\(while\\|for\\|in\\|repeat\\|if\\|else\\|switch\\|break\\|next\\|return\\|stop\\|warning\\|function\\)\\>"
     . font-lock-keyword-face) ; keywords
    )
  "Font-lock patterns used in inferior-ess-mode buffers.")

;; add-to-list() places keywords in front of the previous keywords
;; input and prompt must appear in inferior-ess-font-lock-keywords
;; in the order  prompt error, hence they appear here in the reverse
;; order.

(if (not inferior-ess-font-lock-input)
    (add-to-list 'inferior-ess-font-lock-keywords
		 '("^[a-zA-Z0-9 ]*[>+]\\(.*$\\)"
		   (1 font-lock-variable-name-face keep t));don't font-lock input
		 ))
(add-to-list 'inferior-ess-font-lock-keywords
	     '("^[a-zA-Z0-9 ]*[>+]" . font-lock-keyword-face))	; prompt

(defvar ess-trans-font-lock-keywords
 inferior-ess-font-lock-keywords
 "Font-lock patterns used in ess-transcript-mode buffers.")

;;
;;(defvar ess-mode-font-lock-keywords
;; '(("\\s\"?\\(\\(\\sw\\|\\s_\\)+\\)\\s\"?\\s-*\\(<-\\|_\\)\\(\\s-\\|\n\\)*function" 1 font-lock-function-name-face t)
;;   ("<<?-\\|_" . font-lock-reference-face)
;;   ("\\<\\(TRUE\\|FALSE\\|T\\|F\\|NA\\|NULL\\|Inf\\|NaN\\)\\>" . font-lock-type-face)
;;   ("\\<\\(library\\|attach\\|detach\\|source\\)\\>" . font-lock-reference-face)
;;   "\\<\\(while\\|for\\|in\\|repeat\\|if\\|else\\|switch\\|break\\|next\\|return\\|stop\\|warning\\|function\\)\\>")
;; "Font-lock patterns used in ess-mode bufffers.")
;;
;;(defvar essd-S-inferior-font-lock-keywords
;; '(("^[a-zA-Z0-9 ]*[>+]" . font-lock-keyword-face)	; prompt
;;   ("^[a-zA-Z0-9 ]*[>+]\\(.*$\\)"
;;    (1 font-lock-variable-name-face keep t)) ; input
;;   ("<-\\|_" . font-lock-reference-face)		; assign
;;   ("^\\*\\*\\\*.*\\*\\*\\*\\s *$" . font-lock-comment-face) ; ess-mode msg
;;   ("\\[,?[1-9][0-9]*,?\\]" . font-lock-reference-face)	; Vector/matrix labels
;;   ("^Syntax error:" . font-lock-reference-face) ; error message
;;   ("^Error:" . font-lock-reference-face) ; error message
;;   ("^Error in" . font-lock-reference-face) ; error message
;;   ("^Dumped" . font-lock-reference-face) ; error message
;;   ("^Warning:" . font-lock-reference-face) ; warning message
;;   ("\\<\\(TRUE\\|FALSE\\|T\\|F\\|NA\\|NULL\\|Inf\\|NaN\\)\\>"
;;    . font-lock-type-face)) ; keywords
;; "Font-lock patterns for dialects of S, used in highlighting process
;; buffers and transcripts.")
;;
;;(defvar inferior-ess-font-lock-keywords
;;  essd-S-inferior-font-lock-keywords
;; "Font-lock patterns used in inferior-ess-mode buffers.")
;;
;;(defvar ess-trans-font-lock-keywords
;;  essd-S-inferior-font-lock-keywords
;; "Font-lock patterns used in ess-transcript-mode buffers.")


;;;*;;; ess-help variables

 ; ess-help-mode
;; This will never need to be loaded independently of any of the other
;; modules, but they can all call it so we may as well put it here.

;;*;; Variables relating to ess-help-mode

(defconst ess-help-S-sec-regex "^[A-Z. ---]+:$"
  "Reg(ular) Ex(pression) of section headers in help file")



 ; User changeable variables
;;;=====================================================
;;; Users note: Variables with document strings starting
;;; with a * are the ones you can generally change safely, and
;;; may have to upon occasion.

(defvar ess-help-form 'separate-buffer
  "*Place to show help.   NOT IMPLEMENTED YET.
Choices are `separate-buffer', `s-process', `www'.  The latter uses
browse-url to find the location")

;; WWW Help NOT included yet.  Be patient.
(defvar ess-help-w3-url-prefix "http://pyrite.cfas.washington.edu/ESS/R/"
  "*Head URL for finding function help")

(defvar ess-help-w3-url-funs "funs/"
  "Place to find functions")


 ; System variables
;;;=====================================================
;;; Users note: You will rarely have to change these
;;; variables.

;;*;; Variables relating to ess-help-mode

;;-- ess-help-S-.. and  ess-help-R-.. constants now  in   S.el (are used in ess-inf).

(defvar ess-help-sec-keys-alist nil
  "Alist of (key . string) pairs for use in section searching.")

(defvar ess-help-sec-regex nil
  "Reg(ular) Ex(pression) of section headers in help file")

(make-variable-buffer-local 'ess-help-sec-keys-alist)
(make-variable-buffer-local 'ess-help-sec-regex)


 ; ess-mode: editing S source

;;; This syntax table is required by ess-mode.el, ess-inf.el and
;;; ess-trans.el, so we provide it here.
(defvar ess-mode-syntax-table nil "Syntax table for ess-mode.")
(make-variable-buffer-local 'ess-mode-syntax-table)


 ; Buffer local customization stuff

(defvar ess-source-modes '(ess-mode)
  "A list of modes used to determine if a buffer contains ess source code.")
;;; If a file is loaded into a buffer that is in one of these major modes, it
;;; is considered an ess source file.  The function ess-load-file uses this to
;;; determine defaults.

(defvar ess-error-buffer-name "*ESS-errors*"
  "Name of buffer to keep process error messages in.
Created for each process.")

(defvar ess-dribble-buffer (generate-new-buffer "*ESS*")
  "Buffer for temporary use for setting default variable values.
Used for recording status of the program, mainly for debugging.")

(defvar ess-customize-alist nil
  "Variable settings to use for proper behavior.
Not buffer local!")

(defvar ess-local-customize-alist nil
  "Buffer local settings for proper behavior.
Used to store the values for passing on to newly created buffers.")

(make-variable-buffer-local 'ess-local-customize-alist)

(defvar ess-mode-editing-alist nil
  "Variable settings for ess-mode.")

(defvar ess-transcript-minor-mode nil
  "Non-nil if using ess-transcript mode as a minor mode of some other mode.")

(make-variable-buffer-local 'ess-transcript-minor-mode)

(defvar ess-listing-minor-mode nil
  "Non-nil if using ess-listing mode as a minor mode of some other mode.")

(make-variable-buffer-local 'ess-listing-minor-mode)

(defvar ess-external-minor-mode nil
  "Non-nil if using external mode as a minor mode of some other mode.")

(make-variable-buffer-local 'ess-external-minor-mode)

(provide 'ess-vars)

 ; Local variables section

;;; This file is automatically placed in Outline minor mode.
;;; The file is structured as follows:
;;; Chapters:     ^L ;
;;; Sections:    ;;*;;
;;; Subsections: ;;;*;;;
;;; Components:  defuns, defvars, defconsts
;;;              Random code beginning with a ;;;;* comment

;;; Local variables:
;;; mode: emacs-lisp
;;; mode: outline-minor
;;; outline-regexp: "\^L\\|\\`;\\|;;\\*\\|;;;\\*\\|(def[cvu]\\|(setq\\|;;;;\\*"
;;; End:

;;; ess.el ends here
