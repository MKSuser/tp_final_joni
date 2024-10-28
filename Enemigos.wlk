import wollok.game.*
import PickleRick.*
import Config.*
import Mapas.*
import Objetos.*
import intro.*
import Niveles.*

// Aca van los enemigos. Las ratas y el enemigo Final
class Personajes {
    var property vida 
    var property poder 

    method morir() {
        if (self.vida()<=0) {game.removeVisual(self)}
    }

    method vidaRestar(x) {
    self.vida()-x.poder()
    }
}

class Ratas  inherits Personajes (vida = 20, poder = 5) {
  
  var property posicion = game.at((-1.randomUpTo(12)).randomUpTo(12).truncate(0),(-1.randomUpTo(12)).randomUpTo(12).truncate(0))
  var imageRata = "ratafrente1.png"
  //var id = 0
  
  method image () = imageRata

  method position() = posicion

  method derecha() {
    imageRata = "rataderecha2.png"
    posicion = posicion.right(1)
    game.schedule(200, {imageRata = "rataderecha1.png"})
    //posicion = posicion.right(0.5)
  }

  method izquierda() {
    imageRata = "rataizquierda2.png"
    posicion = posicion.left(1)
    game.schedule(200, {imageRata = "rataizquierda1.png"})
    //posicion = posicion.left(0.5)
  }

  method arriba() {
    imageRata = "rataespalda2.png"
    posicion = posicion.up(1)
    game.schedule(200, {imageRata = "rataespalda1.png"})
    //posicion = posicion.up(0.5)
  }

  method abajo() {
    imageRata = "ratafrente2.png"
    posicion = posicion.down(1)
    game.schedule(200, {imageRata = "ratafrente1.png"})
    //posicion = posicion.down(0.5)
  }

  method hayRataDerecha(){
    return game.getObjectsIn(posicion.right(1)).any({ cosa => cosa.className() == "Enemigos.Ratas" })
  }
  method hayRataIzquierda(){
    return game.getObjectsIn(posicion.left(1)).any({ cosa => cosa.className() == "Enemigos.Ratas" })
  }
  method hayRataArriba(){
    return game.getObjectsIn(posicion.up(1)).any({ cosa => cosa.className() == "Enemigos.Ratas" })
  }
  method hayRataAbajo(){
    return game.getObjectsIn(posicion.down(1)).any({ cosa => cosa.className() == "Enemigos.Ratas" })
  }

  method perseguir() {
    if(rick.position().x() > self.position().x()){
      if (self.hayRataDerecha()){
      posicion = self.position()
      } else {
        self.derecha()}

    } else if (rick.position().x() < self.position().x()){
        if (self.hayRataIzquierda()){
        posicion = self.position()
        } else { 
          self.izquierda()}
    }

    if(rick.position().y() > self.position().y()){
      if (self.hayRataArriba()){
      posicion = self.position()
      } else {
        self.arriba()}

    } else if (rick.position().y() < self.position().y()){
      if (self.hayRataAbajo()){
      posicion = self.position()
      } else {
        self.abajo()}
    }  
  }




  //method crearId() {
  //  id = config.idRatas() 
  //}

  method crearRata() {
  //  self.crearId()
    game.onTick(800, "perseguir" + self.identity(), {self.perseguir()})
  }

// Mutee los primeros 2 porque al final solo cambiamos la posición para "matarlas" 
  method kill(){
      //game.removeVisual(self)
      //game.removeTickEvent("perseguir" + self.identity())
      sonido.play("muerteRatas.mp3")
      //muerteRatas.play()
      posicion = game.at((-1.randomUpTo(12)).randomUpTo(12).truncate(0),(-1.randomUpTo(12)).randomUpTo(12).truncate(0))
  }

}

//const rata  = new Ratas(posicion = game.at(-3.randomUpTo(3).truncate(0),-3.randomUpTo(15).truncate(0)))
//const rata2  = new Ratas(posicion = game.at(8.randomUpTo(15).truncate(0),-3.randomUpTo(15).truncate(0)))
//const rata3  = new Ratas(posicion = game.at(-3.randomUpTo(15).truncate(0),8.randomUpTo(15).truncate(0)))
/*
  method nivel1() {

      //config.removerVisuales()
      game.clear()
      config.configurarTeclasRick()
      config.printearLoQueTenemos()

      game.addVisual(fondoRojo)
      game.title("Pickle Rick")
      game.height(alto) 
      game.width(ancho)

      config.crearPortal(0,5)
      config.crearPortal(11,5)

      config.crearPlaca(4,4)
      //config.crearPlaca(3,4)
      //config.crearPlaca(2,4)

      config.crearArma(3,3)

      game.addVisual(rata)
      game.addVisual(rata2)
      game.addVisual(rata3)
      game.onTick(800, "perseguir", {rata.perseguir()})
      game.onTick(900, "perseguir2", {rata2.perseguir()})
      game.onTick(1000, "perseguir3", {rata3.perseguir()})

      game.addVisual(rick)

  }

  method nivel3() {
      //config.removerVisuales()
      game.clear()
      config.configurarTeclasRick()
      config.printearLoQueTenemos()

      game.addVisual(fondoEspacio)
      game.title("Espacio")
      game.addVisual(rata)
      game.addVisual(rick)

      config.crearPlaca(3,4)
      
      config.crearPortal(0,5)
      config.crearPortal2(11,5)
      
  }

}*/