(define (domain apilar-bloques)
  (:requirements :strips)
  (:predicates
    (on-table ?b ?t)   ;; bloque b está en mesa t
    (on ?b ?b2)        ;; bloque b está sobre bloque b2
    (clear ?x)         ;; x está libre
  )

  ;; mover un bloque que está en una mesa hacia otra mesa
  (:action mover-mesa-a-mesa
    :parameters (?b ?from ?to)
    :precondition (and
      (on-table ?b ?from)
      (clear ?b)
    )
    :effect (and
      (not (on-table ?b ?from))
      (on-table ?b ?to)
      (clear ?b)
    )
  )

  ;; mover un bloque que está en una mesa hacia arriba de otro bloque
  (:action mover-mesa-a-bloque
    :parameters (?b ?from ?b2)
    :precondition (and
      (on-table ?b ?from)
      (clear ?b)
      (clear ?b2)
    )
    :effect (and
      (not (on-table ?b ?from))
      (on ?b ?b2)
      (clear ?b)
      (not (clear ?b2))
    )
  )
)
