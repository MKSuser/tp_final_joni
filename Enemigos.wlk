import wollok.game.*
import PickleRick.*
import Config.*
import Mapas.*
import Objetos.*
import intro.*
import Niveles.*

// Aca van los enemigos. Las ratas y el enemigo Final

class Enemigos {
  var property vida
  var property poder
  var property posicion = game.at((-1.randomUpTo(12)).randomUpTo(12).truncate(0),(-1.randomUpTo(12)).randomUpTo(12).truncate(0))

  method morir() {
    if (self.vida()<=0) {game.removeVisual(self)}

  }

  method vidaRestar(x) {
  self.vida()-x.poder()
  }

  var property imagen

  var property imagenFrente1
  var property imagenFrente2
  var property imagenDerecha1
  var property imagenDerecha2
  var property imagenIzquierda1
  var property imagenIzquierda2
  var property imagenEspalda1
  var property imagenEspalda2
  
  method image () = imagen

  method position() = posicion

  method derecha() {
    imagen = imagenDerecha2
    posicion = posicion.right(1)
    game.schedule(200, {imagen = imagenDerecha1})
    //posicion = posicion.right(0.5)
  }

  method izquierda() {
    imagen = imagenIzquierda2
    posicion = posicion.left(1)
    game.schedule(200, {imagen = imagenIzquierda1})
    //posicion = posicion.left(0.5)
  }

  method arriba() {
    imagen = imagenEspalda2
    posicion = posicion.up(1)
    game.schedule(200, {imagen = imagenEspalda1})
    //posicion = posicion.up(0.5)
  }

  method abajo() {
    imagen = imagenFrente2
    posicion = posicion.down(1)
    game.schedule(200, {imagen = imagenFrente1})
    //posicion = posicion.down(0.5)
  }

  method hayIgualDerecha(){
    return game.getObjectsIn(posicion.right(1)).any({ cosa => cosa.className() == self.className() })
  }

  method hayIgualIzquierda(){
    return game.getObjectsIn(posicion.left(1)).any({ cosa => cosa.className() == self.className() })
  }

  method hayIgualArriba(){
    return game.getObjectsIn(posicion.up(1)).any({ cosa => cosa.className() == self.className() })
  }

  method hayIgualAbajo(){
    return game.getObjectsIn(posicion.down(1)).any({ cosa => cosa.className() == self.className() })
  }

  method perseguir() {
    if(rick.position().x() > self.position().x()){
      if (self.hayIgualDerecha()){
      posicion = self.position()
      } else {
        self.derecha()}

    } else if (rick.position().x() < self.position().x()){
        if (self.hayIgualIzquierda()){
        posicion = self.position()
        } else { 
          self.izquierda()}
    }

    if(rick.position().y() > self.position().y()){
      if (self.hayIgualArriba()){
      posicion = self.position()
      } else {
        self.arriba()}

    } else if (rick.position().y() < self.position().y()){
      if (self.hayIgualAbajo()){
      posicion = self.position()
      } else {
        self.abajo()}
    }  
  }

  //method crearId() {
  //  id = config.idRatas() 
  //}

  method crearEnemigo() {
  //  self.crearId()
    game.onTick(800, "perseguir" + self.identity(), {self.perseguir()})
  }

// Mutee los primeros 2 porque al final solo cambiamos la posición para "matarlas" 
  method kill(){
      //game.removeVisual(self)
      //game.removeTickEvent("perseguir" + self.identity())
      //muerteRatas.play()
      posicion = game.at((-1.randomUpTo(12)).randomUpTo(12).truncate(0),(-1.randomUpTo(12)).randomUpTo(12).truncate(0))
      rick.puntos(self.vida())
  }

}

class Ratas inherits Enemigos(
  vida = 20,
  poder = 5,
  imagen = "ratafrente1.png",
  imagenFrente1 = "ratafrente1.png",
  imagenFrente2 = "ratafrente2.png",
  imagenDerecha1 = "rataderecha1.png",
  imagenDerecha2 = "rataderecha2.png",
  imagenIzquierda1 = "rataizquierda1.png",
  imagenIzquierda2 = "rataizquierda2.png",
  imagenEspalda1 = "rataespalda1.png",
  imagenEspalda2 = "rataespalda2.png")
  {

  override method kill(){
    super()
    sonido.play("muerteRatas.mp3")
  }
}

class Pepitas inherits Enemigos(
  
  vida = 20,
  poder = 5,

  imagen = "pepitaderecha.png",
  imagenFrente1 = "pepitaabajo.png",
  imagenFrente2 = "pepitaabajo.png",
  imagenDerecha1 = "pepitaderecha.png",
  imagenDerecha2 = "pepitaderecha.png",
  imagenIzquierda1 = "pepitaizquierda.png",
  imagenIzquierda2 = "pepitaizquierda.png",
  imagenEspalda1 = "pepitaarriba.png",
  imagenEspalda2 = "pepitaarriba.png")
  {

  override method kill(){
    super()
    sonido.play("muerteRatas.mp3")//CAMBIAR POR PAJARO
  }

}