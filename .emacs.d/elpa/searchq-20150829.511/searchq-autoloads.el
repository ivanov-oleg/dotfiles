;;; searchq-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "searchq" "searchq.el" (23189 25370 481199
;;;;;;  728000))
;;; Generated autoloads from searchq.el

(autoload 'searchq-search "searchq" "\
Make a search task to search MATCH string or regular expression refer to
attributes ARGS. ARGS describes what files, or what directories to search.
Search tasks is delegated to `searchq-backends'.

Format of ARGS
--------------
* Search MATCH in specific files:
  ARGS = :files '(filename1 filename2 filename3 ...)
* Search MATCH in specific directories:
  ARGS = :dirs '(INCLUDES EXCLUDES dirpath1 dirpath2 dirpath3 ...)
  INCLUDES = A filter list for including files.
             ex: '(*.md *.txt) for `searchq-grep-backend'.
  EXCLUDES = A filter list for excluding files.
             ex: '(*.git* *.svn*) for `searchq-grep-backend'.
  !Note: The format of INCLUDES and EXCLUDES depends on the backend you're using.
* Search MATCH in files listed in an input file.
  ARGS = :fromfile filename

Example
-------
* Search MATCH in specific files and directories.
  (searchq-search MATCH :files '(/path/a /path/b) :dirs '(nil nil /path/dir1 /path/dir2))
* Search MATCH in files listed in an input file.
  (searchq-search MATCH :fromfile /path/inputfile)
* Search MATCH in specific directories and ignore subversion files.
  (searchq-search MATCH :dirs '(nil (*.git* *.svn*) /path/dir1 /path/dir2))

\(fn MATCH &rest ARGS)" t nil)

(autoload 'searchq-search-command "searchq" "\
Very similar to `searchq-search' but it takes CMD arguement and pass it to
`searchq-backends' directly.

\(fn CMD)" t nil)

(autoload 'searchq-toggle-result "searchq" "\


\(fn)" t nil)

(autoload 'searchq-stop "searchq" "\
Stop search task of INDEX index.

\(fn INDEX)" t nil)

(autoload 'searchq-stop-all "searchq" "\
Stop all search tasks.

\(fn)" t nil)

(autoload 'searchq-result-mode "searchq" "\
Major mode for search buffers.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("searchq-pkg.el") (23189 25370 529200
;;;;;;  478000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; searchq-autoloads.el ends here
