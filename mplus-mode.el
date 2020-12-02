;;; -*- coding: utf-8; lexical-binding: t; -*-
;;; mplus-mode.el --- sample major mode for editing mplus. 

;; Author: Charles-Édouard Giguère ( ce.giguere@gmail.com )
;; Version: 1.0
;; Created: 7 march 2018
;; Keywords: Mplus-language

;; This file is not part of GNU Emacs.

;;; License:
;; You can redistribute this program and/or modify it under
;; the terms of the GNU General Public License version 2.


;;; Define a hook (to add auto-completion for example).
(defvar mplus-mode-hook nil)

;;; Open Mplus to see plot file (gh5 files);
(fset 'view-gh5
      (lambda () (interactive)
	(w32-shell-execute "open" (replace-regexp-in-string
				   "[.]inp$" ".gh5"
				   (buffer-file-name)))
	)
      )


;;; Open output file in a new window;
(fset 'open-output
      (lambda () (interactive)
	(find-file-other-window (replace-regexp-in-string
		    "[.]inp$" ".out"
		    (buffer-file-name)))
	)
      )

;;; Run the file in mplus;
(fset 'run-mplus
      (lambda () (interactive)
	(shell-command (concat "mplus " "\"" (buffer-name) "\""))
	)
      )

;;; A map for common binding in mplus mode;
(defvar mplus-mode-map
  (let ((map (make-keymap)))
    (define-key map "\C-j" 'newline-and-indent)
    (define-key map "\C-v" 'view-gh5)
    (define-key map "\C-r" 'run-mplus)
    (define-key map "\C-o" 'open-output) map)
    "Keymap for mplus major mode")


;;; 
(defconst mplus-font-lock-keywords-1
  (list
   '("[!].*$"
     . font-lock-comment-face)
   '("\\<\\(ANALYSIS\\|D\\(?:ATA\\(?: \\(?:COHORT\\|IMPUTATION\\|LONGTOWIDE\\|MISSING\\|SURVIVAL\\|TWOPART\\|WIDETOLONG\\)\\)?\\|EFINE\\)\\|MO\\(?:DEL\\(?: \\(?:CO\\(?:NSTRAINT\\|VERAGE\\)\\|INDIRECT\\|MISSING\\|P\\(?:OPULATION\\|RIORS\\)\\|TEST\\)\\)?\\|NTECARLO\\)\\|OUTPUT\\|PLOT\\|SAVEDATA\\|\\(?:TIT\\|VARIAB\\)LE\\)\\>"
     . font-lock-builtin-face)
   '("\\('\\w*'\\)" . font-lock-variable-name-face))
  "highlighting expressions for mplus mode")




(defconst mplus-font-lock-keywords-2
  (append mplus-font-lock-keywords-1
		  (list
		   '("\\(A\\(?:CONVERGENCE\\|D\\(?:APTIVE\\|DFREQUENCY\\)\\|ITERATIONS\\|L\\(?:GORITHM\\|IGNMENT\\)\\|STARTS\\|UXILIARY\\)\\|B\\(?:2WEIGHT IS\\|3WEIGHT IS\\|ASEHAZARD\\(?: IS\\)?\\|CONVERGENCE\\|ETWEEN ARE\\|I\\(?:NARY\\|TERATIONS\\)\\|OOTSTRAP\\|PARAMETERS IS\\|SEED\\|W\\(?:EIGHT\\|TSCALE IS\\)\\)\\|C\\(?:ATEGORICAL ARE\\|ENSORED ARE\\|H\\(?:AINS\\|OLESKY\\)\\|L\\(?:\\(?:ASSE\\|USTER I\\)S\\)\\|O\\(?:H\\(?:ORT IS\\|RECODE\\)\\|N\\(?:STRAINT\\|TINUOUS\\|VERGENCE\\)\\|PATTERN IS\\|UNT ARE\\|V\\(?:ARIANCE IS\\|ERAGE\\)\\)\\|SIZES\\|UTPOINTS?\\)\\|D\\(?:ESCRIPTIVE\\|I\\(?:FFTEST\\(?: IS\\)?\\|STRIBUTION\\)\\|SURVIVAL ARE\\)\\|EST\\(?:BASELINE IS\\|IMAT\\(?:ES ARE\\|OR\\)\\)\\|F\\(?:ACTORS\\(?: ARE\\)?\\|BITERATIONS\\|I\\(?:LE IS\\|NITE\\)\\|ORMAT\\(?: IS\\)?\\|REQWEIGHT IS\\)\\|G\\(?:EN\\(?:CLASSES\\|ERATE\\)\\|ROUPING IS\\)\\|H\\(?:1\\(?:CONVERGENCE\\|\\(?:ITERATION\\|START\\)S\\)\\|AZARDC\\)\\|I\\(?:DVARIABLE\\(?: IS\\)?\\|MPUTE\\|N\\(?:FORMATION\\|TE\\(?:GRATION\\|RACTIVE\\)\\)\\|TERATIONS\\)\\|K\\(?:-1STARTS\\|APLANMEIER IS\\|NOWNCLASS\\|OLMOGOROV\\)\\|L\\(?:AGGED ARE\\|I\\(?:NK\\|STWISE\\)\\|O\\(?:G\\(?:CRITERION\\|HIGH\\|LOW\\)\\|NG\\)\\|R\\(?:ESPONSES\\(?: ARE\\)?\\|T\\(?:BOOTSTRAP\\|STARTS\\)\\)\\)\\|M\\(?:ATRIX\\|C\\(?:CONVERGENCE\\|ITERATIONS\\|ONVERGENCE\\|SEED\\)\\|DITERATIONS\\|ETRIC\\|F\\(?:ILE\\|ORMAT\\)\\|I\\(?:SS\\(?:FLAG\\|ING\\(?: ARE\\)?\\)\\|TERATIONS\\|X[CU]\\)\\|MISSING\\|NAMES\\|O\\(?:DEL\\|NITOR IS\\)\\|SELECT\\|U\\(?:CONVERGENCE\\|ITERATIONS\\|LTIPLIER\\(?: IS\\)?\\)\\)\\|N\\(?:AMES\\(?: ARE\\)?\\|CSIZES\\|DATASETS\\|GROUPS\\|O\\(?:BSERVATIONS\\(?: ARE\\)?\\|MINAL ARE\\)\\|REPS\\)\\|O\\(?:PTSEED\\|UTLIERS ARE\\)\\|P\\(?:A\\(?:RA\\(?:LLEL\\|METERIZATION\\)\\|T\\(?:\\(?:MIS\\|PROB\\|TERN I\\)S\\)\\)\\|OINT\\|R\\(?:EDICTOR\\|IOR\\|OCESSORS\\)\\)\\|R\\(?:ANKING IS\\|CONVERGENCE\\|E\\(?:CORDLENGTH IS\\|P\\(?:ETITION\\|\\(?:S\\|WEIGHTS AR\\)E\\)\\|S\\(?:PONSE IS\\|ULTS ARE\\)\\)\\|ITERATIONS\\|LOGCRITERION\\|O\\(?:TATION\\|UNDING\\|WSTANDARDIZATION\\)\\|STARTS\\)\\|S\\(?:A\\(?:MPLE IS\\|VE\\)\\|DITERATIONS\\|E\\(?:ED\\|RIES IS\\)\\|I\\(?:GBETWEEN IS\\|MPLICITY\\)\\|T\\(?:ARTS\\|CONVERGENCE\\|D\\(?:DISTRIBUTION IS\\|RESULTS ARE\\)\\|ITERATIONS\\|RATIFICATION IS\\|S\\(?:CALE\\|EED\\)\\|VALUES\\)\\|U\\(?:BPOPULATION IS\\|RVIVAL ARE\\)\\|WMATRIX\\(?: IS\\)?\\)\\|T\\(?:ECH\\(?:[34] IS\\)\\|HIN\\|I\\(?:ME\\(?:CENSORED ARE\\|MEASURES\\)\\|NTERVAL IS\\)\\|NAMES\\|OLERANCE\\|RA\\(?:INING\\|NSFORM\\)\\|SCORES ARE\\|YPE\\(?: IS\\)?\\)\\|U\\(?:\\(?:CELLSIZ\\|SE\\(?:\\(?:OBSERVATION\\|VARIABLE\\)S AR\\)\\)E\\)\\|VA\\(?:LUES\\|RIANCES?\\)\\|W\\(?:EIGHT IS\\|I\\(?:\\(?:D\\|THIN AR\\)E\\)\\|TSCALE IS\\)\\)"
		     . font-lock-keyword-face)
		   '("\\<\\(%\\(?:BETWEEN%\\|COLUMN\\|OVERALL%\\|ROW\\|TOTAL\\|WITHIN%\\)\\|AL\\(?:IGNMENT\\|L\\(?:FREE\\)?\\)\\|B\\(?:A\\(?:S\\(?:EHAZARD\\|IC\\)\\|YES\\)\\|C\\(?:BOOTSTRAP\\|HWEIGHTS\\)\\|I-\\(?:CF-QUARTIMAX\\|GEOMIN\\)\\|OOTSTRAP\\|RR\\)\\|C\\(?:ENTER\\|F-\\(?:EQUAMAX\\|FACPARSIM\\|\\(?:PARS\\|QUART\\|VAR\\)IMAX\\)\\|HECK\\|INTERVAL\\|LUSTER\\(?:_MEAN\\)?\\|O\\(?:M\\(?:BINATION\\|PLEX\\)\\|N\\(?:FIGURAL\\|VERGENCE\\)\\|OKS\\|RRELATION\\|UNT\\|VARIANCE\\)\\|PROBABILITIES\\|R\\(?:AWFER\\|OSS\\(?:CLASSIFIED\\|TABS\\)\\)\\|UT\\)\\|D\\(?:ELTA\\|IFFERENCE\\|O\\)\\|E\\(?:CLUSTER\\|FA\\|MA?\\|NTROPY\\|QTAIL\\|XPECTED\\)\\|F\\(?:A\\(?:LSE\\|Y\\)\\|IXED\\|OURTHRT\\|REE\\|S\\(?:CO\\(?:EFFICIENT\\|MPARISON\\|RES\\)\\|DETERMINACY\\)?\\|ULLCO\\(?:RR\\|V\\)\\)\\|G\\(?:AUSSHERMITE\\|E\\(?:NERAL\\|OMIN\\)\\|\\(?:IBB\\|L\\)S\\)\\|H\\(?:1\\(?:MODEL\\|SE\\|TECH3\\)\\|PD\\)\\|I\\(?:F\\|MPUTATION\\|N\\(?:D\\(?:IVIDUAL\\)?\\|FLUENCE\\|TEGRATION\\)\\|TERATIONS\\)\\|JACKKNIFE\\|KAISER\\|L\\(?:ATENT\\|O\\(?:G\\(?:IT\\|LI\\(?:KELIHOOD\\|NEAR\\)\\|RANK\\)\\|OP\\)\\|RESPONSES\\)\\|M\\(?:AHALANOBIS\\|CMC\\|E\\(?:ANS?\\|DIAN\\|TRIC\\)\\|I\\(?:SSING\\|XTURE\\)\\|L\\(?:MV\\|[FMR]\\)\\|O\\(?:D\\(?:E\\|INDICES\\)?\\|NTECARLO\\)\\|UML\\|[HL]\\)\\|N\\(?:EW\\|O\\(?:C\\(?:H\\(?:ECK\\|ISQUARE\\)\\|OVARIANCES\\)\\|MEANSTRUCTURE\\|RMAL\\|SERROR\\)\\)\\|O\\(?:B\\(?:LIMIN\\|SERVED\\)\\|DLL\\|FF\\|N\\)\\|P\\(?:ATTERNS\\|ERTURBED\\|LOT[123]?\\|RO\\(?:B\\(?:ABILITY\\|IT\\)\\|DUCT\\|MAX\\|PENSITY\\)\\|SR\\|X[123]\\)\\|QUARTIMIN\\|R\\(?:ANDOM\\|E\\(?:FGROUP\\|GRESSION\\|PWEIGHTS\\|S\\(?:COVARIANCES\\|IDUAL\\)\\)\\|W\\)\\|S\\(?:AMP\\(?:LE\\|STAT\\)\\|CALAR\\|E\\(?:NSITIVITY\\|QUENTIAL\\)\\|KEW\\(?:NORMAL\\|T\\)\\|QRT\\|T\\(?:ANDARD\\(?:IZED?\\)?\\|D\\(?:EVIATIONS\\|YX?\\)\\)\\|VALUES\\|YMMETRIC\\)\\|T\\(?:ARGET\\|DISTRIBUTION\\|ECH\\(?:1[0-6]\\|[1-9]\\)\\|H\\(?:ETA\\|REELEVEL\\)\\|RUE\\|WOLEVEL\\)\\|U\\(?:LS\\(?:MV\\)?\\|N\\(?:\\(?:PERTURB\\|SCAL\\)ED\\)\\)\\|V\\(?:ARIMAX\\|IA\\)\\|WLS\\(?:MV?\\)?\\|_MISSING\\)\\>"
		     . font-lock-function-name-face)		   
		   '("\\<WITH\\|ON\\|BY\\|PON\\|PWITH\\|AT\\|XWITH\\>"
		     . font-lock-doc-face)))
  "Additional Keywords to highlight in mplus mode")

(defvar mplus-font-lock-keywords mplus-font-lock-keywords-2
  "Default highlighting expressions for mplus mode")

(defun mplus-indent-line ()
  "Indent current line as mplus code"
  (interactive)
  (beginning-of-line)
  (if (bobp)  ; Check for rule 1
      (indent-line-to 0)
    (if (looking-at ".*[:].*") ; Check for rule 2
	(indent-line-to 0)
      (indent-line-to 4))))


(defun mplus-mode ()
  "Major mode for editing Workflow Process Description Language files"
  (interactive)
  (kill-all-local-variables)
  ;;(set-syntax-table mplus-mode-syntax-table)
  (use-local-map mplus-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(mplus-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'mplus-indent-line)
  (set (make-local-variable 'comment-start) "! ")
  (set (make-local-variable 'comment-end) "")
  (set (make-local-variable 'comment-start-skip) "!+ *")
  (setq major-mode 'mplus-mode)
  (setq mode-name "Mplus")
  (run-hooks 'mplus-mode-hook))

(provide 'mplus-mode)


;;; Generating the regexp for the main commands.

;;; (regexp-opt '("TITLE"
;;; 	      "DATA"
;;; 	      "DATA IMPUTATION"
;;; 	      "DATA WIDETOLONG"
;;; 	      "DATA LONGTOWIDE"
;;; 	      "DATA TWOPART"
;;; 	      "DATA MISSING"
;;; 	      "DATA SURVIVAL"
;;; 	      "DATA COHORT"
;;; 	      "VARIABLE"
;;; 	      "DEFINE"
;;; 	      "ANALYSIS"
;;; 	      "MODEL"
;;; 	      "MODEL INDIRECT"
;;; 	      "MODEL CONSTRAINT"
;;; 	      "MODEL TEST"
;;; 	      "MODEL PRIORS"
;;; 	      "MODEL POPULATION"
;;; 	      "MODEL COVERAGE"
;;; 	      "MODEL MISSING"
;;; 	      "OUTPUT"
;;; 	      "SAVEDATA"
;;; 	      "PLOT"
;;; 	      "MONTECARLO") 'words)


;;; Generating the regexp for secondary commands.

;;;(regexp-opt '("FILE IS"
;;;	      "FORMAT IS"
;;;	      "TYPE IS"
;;;	      "NOBSERVATIONS ARE"
;;;	      "NGROUPS"
;;;	      "LISTWISE"
;;;	      "SWMATRIX"
;;;	      "VARIANCES"
;;;	      "IMPUTE"
;;;	      "NDATASETS"
;;;	      "SAVE"
;;;	      "FORMAT"
;;;	      "MODEL"
;;;	      "VALUES"
;;;	      "ROUNDING"
;;;	      "THIN"
;;;	      "WIDE"
;;;	      "LONG"
;;;	      "IDVARIABLE"
;;;	      "REPETITION"
;;;	      "NAMES"
;;;	      "CUTPOINT"
;;;	      "BINARY"
;;;	      "CONTINUOUS"
;;;	      "TRANSFORM"
;;;	      "TYPE"
;;;	      "DESCRIPTIVE"
;;;	      "COHORT IS"
;;;	      "COPATTERN IS"
;;;	      "COHRECODE"
;;;	      "TIMEMEASURES"
;;;	      "TNAMES"
;;;	      "NAMES ARE"
;;;	      "USEOBSERVATIONS ARE"
;;;	      "USEVARIABLES ARE"
;;;	      "MISSING ARE"
;;;	      "CENSORED ARE"
;;;	      "CATEGORICAL ARE"
;;;	      "NOMINAL ARE"
;;;	      "COUNT ARE"
;;;	      "DSURVIVAL ARE"
;;;	      "GROUPING IS"
;;;	      "IDVARIABLE IS"
;;;	      "FREQWEIGHT IS"
;;;	      "TSCORES ARE"
;;;	      "AUXILIARY"
;;;	      "CONSTRAINT"
;;;	      "PATTERN IS"
;;;	      "STRATIFICATION IS"
;;;	      "CLUSTER IS"
;;;	      "WEIGHT IS"
;;;	      "WTSCALE IS"
;;;	      "BWEIGHT"
;;;	      "B2WEIGHT IS"
;;;	      "B3WEIGHT IS"
;;;	      "BWTSCALE IS"
;;;	      "REPWEIGHTS ARE"
;;;	      "SUBPOPULATION IS"
;;;	      "FINITE"
;;;	      "CLASSES"
;;;	      "KNOWNCLASS"
;;;	      "TRAINING"
;;;	      "WITHIN ARE"
;;;	      "BETWEEN ARE"
;;;	      "SURVIVAL ARE"
;;;	      "TIMECENSORED ARE"
;;;	      "LAGGED ARE"
;;;	      "TINTERVAL IS"
;;;	      "ESTIMATOR"
;;;	      "ALIGNMENT"
;;;	      "DISTRIBUTION"
;;;	      "PARAMETERIZATION"
;;;	      "LINK"
;;;	      "ROTATION"
;;;	      "ROWSTANDARDIZATION"
;;;	      "PARALLEL"
;;;	      "REPSE"
;;;	      "BASEHAZARD"
;;;	      "CHOLESKY"
;;;	      "ALGORITHM"
;;;	      "INTEGRATION"
;;;	      "MCSEED"
;;;	      "ADAPTIVE"
;;;	      "INFORMATION"
;;;	      "BOOTSTRAP"
;;;	      "LRTBOOTSTRAP"
;;;	      "STARTS"
;;;	      "STITERATIONS"
;;;	      "STCONVERGENCE"
;;;	      "STSCALE"
;;;	      "STSEED"
;;;	      "OPTSEED"
;;;	      "K-1STARTS"
;;;	      "LRTSTARTS"
;;;	      "RSTARTS"
;;;	      "ASTARTS"
;;;	      "H1STARTS"
;;;	      "DIFFTEST"
;;;	      "MULTIPLIER"
;;;	      "COVERAGE"
;;;	      "ADDFREQUENCY"
;;;	      "ITERATIONS"
;;;	      "SDITERATIONS"
;;;	      "H1ITERATIONS"
;;;	      "MITERATIONS"
;;;	      "MCITERATIONS"
;;;	      "MUITERATIONS"
;;;	      "RITERATIONS"
;;;	      "AITERATIONS"
;;;	      "CONVERGENCE"
;;;	      "H1CONVERGENCE" 
;;;	      "LOGCRITERION"
;;;	      "RLOGCRITERION"
;;;	      "MCONVERGENCE"
;;;	      "MCCONVERGENCE"
;;;	      "MUCONVERGENCE"
;;;	      "RCONVERGENCE"
;;;	      "ACONVERGENCE"
;;;	      "MIXC"
;;;	      "MIXU"
;;;	      "LOGHIGH"
;;;	      "LOGLOW"
;;;	      "UCELLSIZE"
;;;	      "VARIANCE"
;;;	      "SIMPLICITY"
;;;	      "TOLERANCE"
;;;	      "METRIC"
;;;	      "MATRIX"
;;;	      "POINT"
;;;	      "CHAINS"
;;;	      "BSEED"
;;;	      "STVALUES"
;;;	      "PREDICTOR"
;;;	      "ALGORITHM"
;;;	      "BCONVERGENCE"
;;;	      "BITERATIONS"
;;;	      "FBITERATIONS"
;;;	      "THIN"
;;;	      "MDITERATIONS"
;;;	      "KOLMOGOROV"
;;;	      "PRIOR"
;;;	      "INTERACTIVE"
;;;	      "PROCESSORS"
;;;	      "MISSFLAG"
;;;	      "RECORDLENGTH IS"
;;;	      "SAMPLE IS"
;;;	      "COVARIANCE IS"
;;;	      "SIGBETWEEN IS"
;;;	      "SWMATRIX IS"
;;;	      "RESULTS ARE"
;;;	      "STDRESULTS ARE"
;;;	      "STDDISTRIBUTION IS"
;;;	      "ESTIMATES ARE"
;;;	      "DIFFTEST IS"
;;;	      "TECH3 IS"
;;;	      "TECH4 IS"
;;;	      "KAPLANMEIER IS"
;;;	      "BASEHAZARD IS"
;;;	      "ESTBASELINE IS"
;;;	      "RESPONSE IS"
;;;	      "MULTIPLIER IS"
;;;	      "BPARAMETERS IS"
;;;	      "RANKING IS"
;;;	      "TYPE IS"
;;;	      "FACTORS"
;;;	      "LRESPONSES"
;;;	      "MFILE"
;;;	      "MNAMES"
;;;	      "MFORMAT"
;;;	      "MMISSING"
;;;	      "MSELECT"
;;;	      "SERIES IS"
;;;	      "FACTORS ARE"
;;;	      "LRESPONSES ARE"
;;;	      "OUTLIERS ARE"
;;;	      "MONITOR IS"
;;;	      "NOBSERVATIONS"
;;;	      "NGROUPS"
;;;	      "NREPS"
;;;	      "SEED"
;;;	      "GENERATE"
;;;	      "CUTPOINTS"
;;;	      "GENCLASSES"
;;;	      "NCSIZES"
;;;	      "CSIZES"
;;;	      "HAZARDC"
;;;	      "PATMISS"
;;;	      "PATPROBS"
;;;	      "MISSING") t)

;;; Generating the regexp for the constant in mplus.



;;;(regexp-opt '("TRUE"
;;;	      "FALSE"
;;;	      "ON"
;;;	      "OFF"
;;;	      "CHECK"
;;;	      "NOCHECK"
;;;	      "MISSING"
;;;	      "FREE"
;;;	      "INDIVIDUAL"
;;;	      "COVARIANCE"
;;;	      "CORRELATION"
;;;	      "FULLCOV"
;;;	      "FULLCORR"
;;;	      "MEANS"
;;;	      "STDEVIATIONS"
;;;	      "MONTECARLO"
;;;	      "IMPUTATION"
;;;	      "SEQUENTIAL"
;;;	      "REGRESSION"
;;;	      "UNSCALED"
;;;	      "CLUSTER"
;;;	      "ECLUSTER"
;;;	      "UNSCALED"
;;;	      "SAMPLE"
;;;	      "CENTER"
;;;	      "IF"
;;;	      "_MISSING"
;;;	      "DO"
;;;	      "STANDARDIZE"
;;;	      "CUT"
;;;	      "CLUSTER_MEAN"
;;;	      "GENERAL"
;;;	      "BASIC"
;;;	      "RANDOM"
;;;	      "COMPLEX"
;;;	      "MIXTURE"
;;;	      "TWOLEVEL"
;;;	      "THREELEVEL"
;;;	      "CROSSCLASSIFIED"
;;;	      "EFA"
;;;	      "ML"
;;;	      "MLM"
;;;	      "MLMV"
;;;	      "MLR"
;;;	      "MLF"
;;;	      "MUML"
;;;	      "WLS"
;;;	      "WLSM"
;;;	      "WLSMV"
;;;	      "ULS"
;;;	      "ULSMV"
;;;	      "GLS"
;;;	      "BAYES"
;;;	      "CONFIGURAL"
;;;	      "METRIC"
;;;	      "SCALAR"
;;;	      "NOMEANSTRUCTURE"
;;;	      "NOCOVARIANCES"
;;;	      "ALLFREE"
;;;	      "FIXED"
;;;	      "FREE"
;;;	      "NORMAL"
;;;	      "SKEWNORMAL"
;;;	      "TDISTRIBUTION"
;;;	      "SKEWT"
;;;	      "DELTA"
;;;	      "THETA"
;;;	      "LOGIT"
;;;	      "LOGLINEAR"
;;;	      "PROBABILITY"
;;;	      "RESCOVARIANCES"
;;;	      "PROBIT"
;;;	      "GEOMIN"
;;;	      "QUARTIMIN"
;;;	      "CF-VARIMAX"
;;;	      "CF-QUARTIMAX"
;;;	      "CF-EQUAMAX"
;;;	      "CF-PARSIMAX"
;;;	      "CF-FACPARSIM"
;;;	      "CRAWFER"
;;;	      "OBLIMIN"
;;;	      "VARIMAX"
;;;	      "PROMAX"
;;;	      "TARGET"
;;;	      "BI-GEOMIN"
;;;	      "BI-CF-QUARTIMAX"
;;;	      "KAISER"
;;;	      "BOOTSTRAP"
;;;	      "JACKKNIFE"
;;;	      "BRR"
;;;	      "FAY"
;;;	      "EM"
;;;	      "EMA"
;;;	      "FS"
;;;	      "ODLL"
;;;	      "INTEGRATION"
;;;	      "STANDARD"
;;;	      "GAUSSHERMITE"
;;;	      "OBSERVED"
;;;	      "EXPECTED"
;;;	      "COMBINATION"
;;;	      "ITERATIONS"
;;;	      "CONVERGENCE"
;;;	      "SQRT"
;;;	      "FOURTHRT"
;;;	      "REFGROUP"
;;;	      "PRODUCT"
;;;	      "MEDIAN"
;;;	      "MEAN"
;;;	      "MODE"
;;;	      "UNPERTURBED"
;;;	      "PERTURBED"
;;;	      "LATENT"
;;;	      "OBSERVED"
;;;	      "GIBBS"
;;;	      "PX1"
;;;	      "PX2"
;;;	      "PX3"
;;;	      "RW"
;;;	      "MH"
;;;	      "MCMC"
;;;	      "PSR"
;;;	      "IND"
;;;	      "VIA"
;;;	      "MOD"
;;;	      "NEW"
;;;	      "PLOT"
;;;	      "LOOP"
;;;	      "DIFFERENCE"
;;;	      "%OVERALL%"
;;;	      "%WITHIN%"
;;;	      "%BETWEEN%"
;;;	      "SAMPSTAT"
;;;	      "CROSSTABS"
;;;	      "COUNT"
;;;	      "%ROW"
;;;	      "%COLUMN"
;;;	      "%TOTAL"
;;;	      "STANDARDIZED"
;;;	      "STDYX"
;;;	      "STDY"
;;;	      "CLUSTER"
;;;	      "RESIDUAL"
;;;	      "MODINDICES"
;;;	      "ALL"
;;;	      "CINTERVAL"
;;;	      "SYMMETRIC"
;;;	      "BOOTSTRAP"
;;;	      "BCBOOTSTRAP"
;;;	      "EQTAIL"
;;;	      "HPD"
;;;	      "EQTAIL"
;;; 	      "SVALUES"
;;;	      "NOCHISQUARE"
;;;	      "NOSERROR"
;;;	      "H1SE"
;;;	      "H1TECH3"
;;;	      "H1MODEL"
;;;  	      "PATTERNS"
;;;	      "FSCOEFFICIENT"
;;;	      "FSDETERMINACY"
;;;	      "FSCOMPARISON"
;;;	      "BASEHAZARD"
;;;	      "LOGRANK"
;;;	      "ALIGNMENT"
;;;	      "ENTROPY"
;;;	      "TECH1"
;;;	      "TECH2"
;;;	      "TECH3"
;;;	      "TECH4"
;;;	      "TECH5"
;;;	      "TECH6"
;;;	      "TECH7"
;;;	      "TECH8"
;;;	      "TECH9"
;;;	      "TECH10"
;;;	      "TECH11"
;;;	      "TECH12"
;;;	      "TECH13"
;;;	      "TECH14"
;;;	      "TECH15"
;;;	      "TECH16"
;;;	      "FSCORES"
;;;	      "LRESPONSES"
;;;	      "PROPENSITY"
;;;	      "CPROBABILITIES"
;;;	      "REPWEIGHTS"
;;;	      "MAHALANOBIS"
;;;	      "LOGLIKELIHOOD"
;;;	      "INFLUENCE"
;;;	      "COOKS"
;;;	      "BCHWEIGHTS"
;;;	      "PLOT1"
;;;	      "PLOT2"
;;;	      "PLOT3"
;;;	      "SENSITIVITY"
;;;	      ) 'words)
