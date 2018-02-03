(load "lib/list.scm")
(load "lib/assert.scm")

(assert-equal (list-ref (list 1 4 9 16 25 36) 3) 16)

(assert-equal (list-length (list 1 3 5 7)) 4)

(list-eq? (list) (list))
(list-eq? (list) (list 1))
(list-eq? (list 1) (list))
(list-eq? (list 1) (list 1))
(list-eq? (list 1) (list 1 2))

(assert-equal-func list-eq? (append () ()) ())
(assert-equal-func list-eq? (append (list 1) ()) (list 1))
(assert-equal-func list-eq? (append (list 1) (list 2)) (list 1 2))
(assert-equal-func list-eq? (append (list 1 3) (list 2)) (list 1 3 2))
(assert-equal-func list-eq? (append (list 1 3) (list 4 2)) (list 1 3 4 2))

(assert-equal-func list-eq? (last-pair (list 1)) (list 1))
(assert-equal-func list-eq? (last-pair (list 1 2)) (list 2))

(assert-equal-func list-eq? (list-front-insert (list) 0) (list 0))
(assert-equal-func list-eq? (list-front-insert (list 1) 0) (list 0 1))
(assert-equal-func list-eq? (list-front-insert (list 1 2) 0) (list 0 1 2))

(assert-equal-func list-eq? (reverse (list)) (list))
(assert-equal-func list-eq? (reverse (list 1)) (list 1))
(assert-equal-func list-eq? (reverse (list 1 2 3)) (list 3 2 1))

(assert-equal-func list-eq? (map abs (list -10 2 0 -1.5 1.7)) (list 10 2 0 1.5 1.7))


(assert-equal-func list-eq? (filter (lambda (x) (= 0 (remainder x 2))) (list 1 2 3 4 5 6 7)) (list 2 4 6))
(assert-equal-func list-eq? (filter (lambda (x) (not (= 0 (remainder x 2)))) (list 1 2 3 4 5 6 7)) (list 1 3 5 7))

(assert-equal (accumulate + 0 (list 1 2 3 4 5)) 15)
(assert-equal (accumulate * 1 (list 1 2 3 4 5)) 120)
(assert-equal-func list-eq? (accumulate cons () (list 1 2 3 4 5)) (list 1 2 3 4 5))

(assert-equal (filter-number (list)) '(() ()))
(assert-equal (filter-number (list 1 'a 2 'b)) '((1 2) (a b)))
(assert-equal (filter-number (list 1 'a 2 'b 3 '(a b))) '((1 2 3) (a b (a b))))
