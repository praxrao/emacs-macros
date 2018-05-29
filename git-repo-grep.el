;;; git-repo-grep.el --- Macro to perform a git-repo-wide grep search of the expression at current cursor position in a buffer window. 

;; It is assumed that the buffer is displaying the content of a file under git source-control.
;; The expression is searched in select file types only.
    
(require 'thingatpt)

(defun git_repo_grep (arg) "git_repo_grep"
       (interactive "p")
       (setq root_dir (shell-command-to-string "git rev-parse --show-toplevel | tr '\n' ' ' 2>/dev/null"))
       (setq inc_types "--include=\\*.{c,h,xml,htf,py,mak,txt,htm,smudge,proto,php,css,json}")
       (setq search_str (thing-at-point 'symbol))
       (setq grep_cmd (concat "grep " inc_types " -nir \"" search_str "\" " root_dir))
       (setq grep_cmd_final (read-string "Run grep like this: " grep_cmd))
       (grep grep_cmd_final))

(global-set-key (kbd "C-q") 'git_repo_grep)
