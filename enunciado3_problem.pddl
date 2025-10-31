(define (problem reparto-ida-vuelta)
  (:domain reparto-robot)

  (:objects
    base
    entrega
  )

  (:init
    ; partimos en la base con batería llena
    (at base)
    (bateria-completa)

    ; hay ida y vuelta
    (conectado base entrega)
    (conectado entrega base)

    ; hay cargador en el punto de entrega (como en la figura)
    ; y también en la base para terminar con batería llena
    (cargador entrega)
    (cargador base)
  )

  ; objetivo: hizo la entrega, volvió a base y quedó con batería
  (:goal
    (and
      (entrega-realizada)
      (at base)
      (bateria-completa)
    )
  )
)
