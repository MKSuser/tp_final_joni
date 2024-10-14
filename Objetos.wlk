import wollok.game.*
import PickleRick.*
import Config.*
import Enemigos.*
import Niveles.*
import intro.*
import Mapas.*

// ---------- Arma , Vida , Placas, Portales ------------

class Portales {
  var image = "portal0.png"
  var position
  //var property mapa = niveles.nivel3()

  method image () = image
  
  method position() = position
  
  method titila() {
    image = "portal1.png"
    game.schedule(75, {image = "portal2.png"})
    game.schedule(75, {image = "portal3.png"})
    game.schedule(75, {image = "portal0.png"})
  }
  /*
  method agarrado(objeto) {
      self.mapa()
  }*/
}
object transicion {
  var image = "portalGrande0.png"
  var position = game.origin()

  method image () = image
  
  method position() = position
  
  method titila() {
    image = "portalGrande1.png"
    game.schedule(75, {image = "portalGrande2.png"})
    game.schedule(75, {image = "portalGrande3.png"})
    game.schedule(75, {image = "portalGrande0.png"})
  }
}

class Armas {
  var position
  var image = "arma.png"

  method position () = position

  method image () = image

  method mover(objeto){
    position = game.at(0,11)
  }

  method titila () {
    image = "armaPalida.png"
    game.schedule(400, {image = "arma.png"})
  }
 
  method agarrado(objeto) {
    self.mover(objeto)
    game.removeTickEvent("titilaArma") 
  }
}


class Placas {
  var property position
  var property image = "placa.png" // Sin declarar en el de Rodra

  method titila () {
    image = "placaPalida.png"
    game.schedule(400, {image = "placa.png"})
  }

  method mover(objeto){
    position = game.at(config.listarPlacas().size(),11)
  }
  
  method agarrado(objeto) {
    //game.removeVisual(objeto)
    //objeto.mover(objeto)
    game.removeTickEvent("titilaPlaca")
    self.mover(objeto)
  }
}

class Lasers {
  var posicion = rick.position()
  var imagen = "laserX.png"
  var property id = 0

  method image () = imagen

  method position () = posicion
  
  method laserAbajo () {
    posicion = posicion.down(1)
  }

  method laserDerecha () {
    posicion = posicion.right(1)
  } 
  
  method laserIzquierda () {
    posicion = posicion.left(1)
  }

  method laserArriba () {
    posicion = posicion.up(1)
  }

  method crearID(){
    id = config.idLaser()
  }

  method disparar () {
    
    if (rick.lasers().size() < 3){
      self.crearID()
      rick.lasers().add(self)
    }

    if ((self.position().x().between(0,game.width()-1)) && (self.position().y().between(0,game.height()-1))){
      
    game.onCollideDo(self, {n => n.kill() //cada vez que choque algo  lo mata,si el objeto entiende el metodo kill()
    self.kill()}) //y ademas el rayo se destruye

    } 
    posicion = rick.position()
    if(rick.image() == "rickfrente1.png" or rick.image() == "rickfrente2.png"){
      game.schedule(300, {
        imagen = "laserY.png" 
        game.addVisual(self) 
        game.onTick(200, "laser" + id.toString(), {if (self.position().y() > 0){self.laserAbajo()} else {self.kill()}}) //cuando sale de la pantalla muere el rayo
      })
    } else if(rick.image() == "rickizquierda1.png" or rick.image() == "rickizquierda2.png"){
      game.schedule(300, {
          imagen = "laserX.png"
          game.addVisual(self)
          game.onTick(200, "laser" + id.toString(), {if (self.position().x() > 0){self.laserIzquierda()} else {self.kill()}})
      })    
    } else if(rick.image() == "rickespalda1.png" or rick.image() == "rickespalda2.png"){
      game.schedule(300, {
        imagen = "laserY.png"
        game.addVisual(self)
        game.onTick(200, "laser" + id.toString(), {if (self.position().y() < 12){self.laserArriba()} else {self.kill()}})
      })  
    } else if(rick.image() == "rickderecha1.png" or rick.image() == "rickderecha2.png"){
      game.schedule(300, {
        imagen = "laserX.png"
        game.addVisual(self)
        game.onTick(200, "laser" + id.toString(), {if (self.position().x() < 12){self.laserDerecha()} else {self.kill()}})
      })
    } 
  }
  
  method kill(){
    game.removeVisual(self)
    game.removeTickEvent("laser" + id.toString())
    posicion = game.at(-1,-1)
  
  }  
}
// Buscar que las balas sea 3-5
// Testear la imagen 