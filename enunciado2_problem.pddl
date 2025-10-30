(define (problem apilar-a-f)
  (:domain apilar-bloques)

  (:objects
    a b c d e f
    mesa-superior mesa-inferior
  )

  (:init
    (block a) (block b) (block c) (block d) (block e) (block f)
    (table mesa-superior)
    (table mesa-inferior)

    (on-table a mesa-superior)
    (on-table b mesa-superior)
    (on-table c mesa-superior)
    (on-table d mesa-superior)
    (on-table e mesa-superior)
    (on-table f mesa-superior)

    (clear a)
    (clear b)
    (clear c)
    (clear d)
    (clear e)
    (clear f)
  )

  (:goal
    (and
      (on-table a mesa-inferior)
      (on b a)
      (on c b)
      (on d c)
      (on e d)
      (on f e)
      (clear f)
    )
  )
)
