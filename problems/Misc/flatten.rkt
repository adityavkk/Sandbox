(define (flatten xs)
  (foldr (lambda (x ys)
                 (cond ((pair? x) (concat (flatten x) ys))
                       ((null? x) ys)
                       (else (cons x ys))))
         '()
         xs))

(define (concat ys zs)
  (if (null? ys)
      zs
      (cons (car ys) (concat (cdr ys) zs))))
