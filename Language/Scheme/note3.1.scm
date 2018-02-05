(load "lib/lib.scm")

(define (make-withdraw balance)
    (lambda (amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount)) balance)
            "Insufficient funds")))


(define w1 (make-withdraw 100))
(assert-equal (w1 10) 90)
(assert-equal (w1 100) "Insufficient funds")