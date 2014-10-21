;; 25 Nov 2005

(wjh-add-to-load-path "muse")
(require 'muse-mode)

;; publishing styles
(require 'muse-html)
(require 'muse-latex)

;; Muse projects
(require 'muse-project)
(setq muse-project-alist
      '(("TestBed" ; trying out Muse mode 25 Nov 2005
	 ("~/Muse/TestBed" :default "index")
	 (:base "html" :path "~/Muse/HTML/TestBed")	 
	 (:base "pdf" :path "~/Muse/HTML/TestBed/pdf"))))

