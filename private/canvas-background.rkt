#lang racket/base

(provide use-from-color-scheme
         canvas-background-mixin
         canvas-background%)

(require racket/class
         (only-in racket/gui/base
                  canvas%
                  canvas<%>)
         (only-in framework
                  color-prefs:lookup-in-color-scheme
                  color-prefs:register-color-scheme-entry-change-callback))

;; use-from-color-scheme : Symbol [(U StyleDelta Color) -> Any] -> Void
(define (use-from-color-scheme sym fn)
  (fn (color-prefs:lookup-in-color-scheme sym))
  (color-prefs:register-color-scheme-entry-change-callback sym fn #t))

;; canvas-background-mixin : Canvas<%> -> Canvas<%>
(define canvas-background-mixin
  (mixin (canvas<%>) (canvas<%>)
    (super-new)
    (inherit set-canvas-background)
    (use-from-color-scheme
     'framework:basic-canvas-background
     (λ (v) (set-canvas-background v)))))

;; canvas-background% : Canvas<%>
(define canvas-background% (canvas-background-mixin canvas%))

