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
  var property poder = 0
  //var property mapa = niveles.nivel3()

  method image () = image
  
  method position() = position
  
  method titila() {
    image = "portal1.png"
    game.schedule(1000, {image = "portal2.png"})
    game.schedule(2000, {image = "portal3.png"})
    game.schedule(3000, {image = "portal0.png"})
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
    game.schedule(250, {image = "portalGrande2.png"})
    game.schedule(500, {image = "portalGrande3.png"})
    game.schedule(1000, {image = "portalGrande0.png"})
  }
}

class Armas {
  var position
  var image = "arma.png"
  var property poder = 0

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
    (mapaRandom.nivelActual()).listaPlaca().remove(self)
    mapaRandom.removerMapaLista(mapaRandom.nivelActual())
  }

}

class Placas {
  var property position
  var property image = "placa.png" // Sin declarar en el de Rodra
  var property poder = 0

  method titila () {
    image = "placaPalida.png"
    game.schedule(400, {image = "placa.png"})
  }

  method mover(objeto){
    position = game.at(config.listarPlacas().size(),11)
  }

  method agarrado(objeto) {
    game.removeTickEvent("titilaPlaca")
    self.mover(objeto)
    (mapaRandom.nivelActual()).listaPlaca().remove(self)
    mapaRandom.removerMapaLista(mapaRandom.nivelActual())
  }

}

class Lasers {
  var posicion
  var imagenXderecha
  var imagenXizquierda
  var imagenYarriba
  var imagenYabajo
  var sonidoArma
  var imagen = imagenXderecha
  var property poder = 0
  
  var property imagenFrente1 = "rickfrente1.png"
  var property imagenFrente2 = "rickfrente2.png"
  var property imagenDerecha1 = "rickderecha1.png"
  var property imagenDerecha2 = "rickderecha2.png"
  var property imagenIzquierda1 = "rickizquierda1.png"
  var property imagenIzquierda2 = "rickizquierda2.png"
  var property imagenEspalda1 = "rickespalda1.png"
  var property imagenEspalda2 = "rickespalda2.png"

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

  method disparoXizquierda() {
    imagen = imagenXizquierda
    game.addVisual(self)
    game.onTick(200, "laser" + self.identity(), {if (self.position().x() > 0){self.laserIzquierda()} else {self.kill()}})   
  }

  method disparoXderecha() {
    imagen = imagenXderecha
    game.addVisual(self) 
    game.onTick(200, "laser" + self.identity(), {if (self.position().x() < 12){self.laserDerecha()} else {self.kill()}})  
  }

  method disparoYabajo() {
    imagen = imagenYabajo
    game.addVisual(self) 
    game.onTick(200, "laser" + self.identity(), {if (self.position().y() > 0){self.laserAbajo()} else {self.kill()}})   
  }

  method disparoYarriba() {
    imagen = imagenYarriba
    game.addVisual(self) 
    game.onTick(200, "laser" + self.identity(), {if (self.position().y() < 12){self.laserArriba()} else {self.kill()}}) 
  }

  method disparar (_entidad) {
    
    sonido.play(sonidoArma)
    
    // Compara si ya hay 3 lasers creados. Si no es así 
    // genera un nuevo ID y agrega el laser a la pistola
    if (_entidad.lasers().size() < config.cantBalas()){
   //   self.crearID()
      _entidad.lasers().add(self)
    }

    //if ((self.position().x().between(0,game.width()-1)) && (self.position().y().between(0,game.height()-1))){
      
    game.onCollideDo(self, {n => n.kill() //cada vez que choque algo  lo mata,si el objeto entiende el metodo kill()
    self.kill()}) //y ademas el rayo se destruye

    //}

    // Reseteamos la posición del rayo donde está la entidad
    posicion = _entidad.position()

    // Logica para al traso del disparo
    if(_entidad.image() == imagenFrente1 or _entidad.image() == imagenFrente2){
      game.schedule(300, {
        self.disparoYabajo()
      })
    } else if(_entidad.image() == imagenIzquierda1 or _entidad.image() == imagenIzquierda2){
      game.schedule(300, {
        self.disparoXizquierda()
      })
    } else if(_entidad.image() == imagenEspalda1 or _entidad.image() == imagenEspalda2){
      game.schedule(300, {
        self.disparoYarriba()
      })
    } else if(_entidad.image() == imagenDerecha1 or _entidad.image() == imagenDerecha2){
      game.schedule(300, {
        self.disparoXderecha()
      })
    } 
  }
  
  // Metodo para "deshacer" el laser
  // Para no saturar el procesador, utilizamos los mismo lasers una y otra vez.
  method kill(){
    game.removeVisual(self)
    game.removeTickEvent("laser" + self.identity())
    posicion = game.at(13,13)
  }  
}

object sonido{

  method play(sonido){
    game.sound(sonido).play()
  }

}
