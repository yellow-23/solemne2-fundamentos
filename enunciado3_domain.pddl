(define (domain reparto-robot)
  (:requirements :strips)
  (:predicates
    (at ?l)               ; el robot está en el lugar ?l
    (conectado ?a ?b)     ; hay camino de ?a a ?b
    (bateria-completa)    ; batería llena
    (bateria-baja)        ; batería gastada
    (cargador ?l)         ; en ?l hay punto de carga
    (entrega-realizada)   ; ya se hizo la entrega
  )

  ;--- moverse gasta batería
  (:action ir
    :parameters (?from ?to)
    :precondition (and
      (at ?from)
      (conectado ?from ?to)
      (bateria-completa)
    )
    :effect (and
      (not (at ?from))
      (at ?to)
      (not (bateria-completa))
      (bateria-baja)
    )
  )

  ;--- recargar donde haya cargador
  (:action recargar
    :parameters (?l)
    :precondition (and
      (at ?l)
      (cargador ?l)
      (bateria-baja)
    )
    :effect (and
      (not (bateria-baja))
      (bateria-completa)
    )
  )

  ;--- entregar SOLO en el lugar "entrega"
  (:action entregar
    :parameters ()
    :precondition (and
      (at entrega)              ; <- aquí se obliga a estar en "entrega"
      (not (entrega-realizada))
    )
    :effect (entrega-realizada)
  )
)
