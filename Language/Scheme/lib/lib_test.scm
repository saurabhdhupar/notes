(load "lib/lib.scm")

(assert-false (>= 1 2))

(assert-equal (gcd 1 1) 1)
(assert-equal (gcd 5 10) 5)
(assert-equal (gcd 5 -20) 5)
(assert-equal (gcd 3 -21) 3)
(assert-equal (gcd -7 49) 7)