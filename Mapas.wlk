import wollok.game.*
import PickleRick.*
import Config.*
import Enemigos.*
import Objetos.*
import intro.*
import Niveles.*


//----------------------------- Mapas --------------------------
class Mapas {
  var imagen
  var property poder = 0

  method image () = imagen
  method position() = game.origin()

  method transicion () {
    transicion.titila()
  }
}

//////////////////////////////////////////////
const mapa0 = new Mapas (imagen = "fondoTierra.jpg")

const mapa1 = new Mapas (imagen = "fondoPasto.jpg")

const mapa2 = new Mapas (imagen = "fondoRojo.jpg")

const mapa3 = new Mapas (imagen = "fondoMadera.jpg")

const mapa4 = new Mapas (imagen = "fondoPiedra.jpg") //LA FINAL

//Selecciona un mapa random a menos que tenga los 4 objetos y va a la final

object mapaRandom {
  const listaNiveles = [nivel1, nivel2, nivel3, nivel4]
  var property nivelActual = nivel1

  method transicionMapa(_mapa) {
    sonido.play("mapaTransicion3.mp3")
    game.addVisual(transicion)
    transicion.titila()
    game.schedule(800, {_mapa.estructura()})
  }

  method removerMapaLista(_mapa){
    listaNiveles.remove(_mapa) //Borro el mapa de la lista de niveles para que no vuelva mas ahí
  }
  
  method elegirMapa (){

    if (listaNiveles.size() == 0) {
      self.transicionMapa(nivel5)
    }  
    
    var nivelElegido = listaNiveles.anyOne()

    nivelActual = nivelElegido
    
    if (nivelElegido == nivel1) {
      self.transicionMapa(nivelElegido)
    }
    else if (nivelElegido == nivel2) {
      self.transicionMapa(nivelElegido)
    }
    else if (nivelElegido == nivel3) {
      self.transicionMapa(nivelElegido)
    }
    else if (nivelElegido == nivel4) {
      self.transicionMapa(nivelElegido)
    }
  }
  
}