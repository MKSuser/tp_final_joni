import Niveles.*
import wollok.game.*
import PickleRick.*
import Config.*
import Enemigos.*
import Objetos.*
import Mapas.*


object mensajeInicio {
  method position() = game.at(5,5) //se mide en celdas de 50 x 50px
  method text() = "Presiona E para empezar"
  method textColor() = "#ffffffff"
}

object fondoInicio {
  method image () = "fondoInicio.jpeg"
  method position() = game.at(-7,0)
}

object primeraPantalla {
  const ancho = 12 //se mide en celdas de 50 x 50px
  const alto = 12   //se mide en celdas de 50 x 50px
//////////
  var property habilitado = true

  method deshabilitador(){
    habilitado = false
  }  
//////////  
  method inicio() {
    config.removerVisuales()
    
    game.title("Pickle Rick")
	  game.height(alto) 
	  game.width(ancho)  
    game.addVisual(fondoInicio)
    game.addVisual(mensajeInicio)
//////////
    keyboard.e().onPressDo({ self.corroboro() })
  
  }

  // Si uno no pone el condicional la "e" sigue haciendo lo que se le pide
  // en todo escenario
  method corroboro(){
    if (habilitado){
      game.removeVisual(mensajeInicio)
      game.removeVisual(fondoInicio)
      self.deshabilitador()
      //niveles.habilitador()
      niveles.nivel1() 
    }
  }
//////////
}