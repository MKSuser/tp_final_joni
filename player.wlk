import nivelesJoni.*
import miscelaneos.*
import wollok.game.*

object rick {

  var posicion = game.at(5,5)
  var imageRick = "rick0.png"
  const property objetos = []
  var property cantidadPlacas = 0

  method image () = imageRick
  method position() = posicion

  method derecha() {
    imageRick = "rick7.png"
    posicion = posicion.right(0.5)
    game.schedule(200, {imageRick = "rick6.png"})
    posicion = posicion.right(0.5)
  }

  method izquierda() {
    imageRick = "rick3.png"
    posicion = posicion.left(0.5)
    game.schedule(200, {imageRick = "rick2.png"})
    posicion = posicion.left(0.5)
  }

  method arriba() {
    imageRick = "rick5.png"
    posicion = posicion.up(0.5)
    game.schedule(200, {imageRick = "rick4.png"})
    posicion = posicion.up(0.5)
  }

  method abajo() {
    imageRick = "rick1.png"
    posicion = posicion.down(0.5)
    game.schedule(200, {imageRick = "rick0.png"})
    posicion = posicion.down(0.5)
  }

  method queHacemosConLoAgarrado(objeto){
    
    if (objeto == arma){
      config.textoCharlado(0000,4000,pichium)
      objeto.agarrado()
    }

    if (objeto == placa){
      if (cantidadPlacas < 3) {
        cantidadPlacas += 1
      }
    }
    if (objeto == placaa){
      if (cantidadPlacas < 3) {
        cantidadPlacas += 1
      }
    }
    if (objeto == placaaa){
      if (cantidadPlacas < 3) {
        cantidadPlacas += 1
      }
    }
    objeto.agarrado()
    
  }

  
  method agarrar(objeto) {
    objetos.add(objeto)
		game.removeVisual(objeto)

    self.queHacemosConLoAgarrado(objeto)
  }
}

class Ratas {
  var posicion
  var imageRata = "rata0.png"
  
  method image () = imageRata
  method position() = posicion

  method derecha() {
    imageRata = "rata7.png"
    posicion = posicion.right(0.5)
    game.schedule(200, {imageRata = "rata6.png"})
    posicion = posicion.right(0.5)
  }

  method izquierda() {
    imageRata = "rata3.png"
    posicion = posicion.left(0.5)
    game.schedule(200, {imageRata = "rata2.png"})
    posicion = posicion.left(0.5)
  }

  method arriba() {
    imageRata = "rata5.png"
    posicion = posicion.up(0.5)
    game.schedule(200, {imageRata = "rata4.png"})
    posicion = posicion.up(0.5)
  }

  method abajo() {
    imageRata = "rata1.png"
    posicion = posicion.down(0.5)
    game.schedule(200, {imageRata = "rata0.png"})
    posicion = posicion.down(0.5)
  }
}

const rata = new Ratas(posicion = game.at(5,5))
