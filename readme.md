---
author: Charles-Édouard Giguère
date: 2018-03-13
title: Mplus mode for emacs and dictionnary of words for autocompletion.
---

* *mplus-mode*: dictionnary for auto-complete while editing mplus syntax
  file.
  
* *mplus-mode.el*: emacs major mode for mplus syntax file. 

	- add these lines to .emacs.
 
      > ;;; Mplus-mode.   
	  > ;;; changer le path (au besoin).  
      >	(load "C:/charles/Statistiques/Mplus_mode/mplus-mode.el")  
	  > (setq auto-mode-alist (cons '("\\.inp" . mplus-mode) auto-mode-alist))  
      >	(add-hook 'mplus-mode-hook  
      >		  (lambda ()  
      >		    (require 'auto-complete-config)  
	  >		    (add-to-list 'ac-dictionary-directories "~/.emacs.d/es-ac-dict")  
	  >		    (setq-default ac-sources '(ac-source-abbrev  
	  >					       ac-source-dictionary  
	  >					       ac-source-words-in-same-mode-buffers))  
	  >		    (add-to-list 'ac-modes 'mplus-mode)  
	  >		    (add-hook 'mplus-hook (lambda () (auto-complete-mode 1))))  
	  >		  )  
	  
* *test.inp*: Mplus syntax test file.
* *test.dat*: iris data file. 













