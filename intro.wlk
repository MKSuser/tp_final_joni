import wollok.game.*
import Objetos.*
import PickleRick.*
import Config.*
import Mapas.*
import Niveles.*

object inicioPlap {
  const ancho = 12
  const alto = 12

  method presentacion(){
    game.title("Pickle Rick")
    game.height(alto) 
    game.width(ancho)

    sonido.play("plap.mp3")    
    game.addVisual(imagenPlap)
    game.schedule(4000, {selectMenu.inicio()})
  }
  
}
object imagenPlap{
  method position() = game.origin()
  method image() = "plap.jpeg"
}

object selectMenu {
    const ancho = 12
    const alto = 12
    const property mensajes = #{mensajeJugar, mensajeCreditos, mensajeSalir}

    method inicio(){
        game.title("Pickle Rick")
        game.height(alto) 
        game.width(ancho)  

        game.addVisual(fondoSelect)
        game.addVisual(rickPosta)

        game.addVisual(mensajeJugar)
        game.addVisual(mensajeCreditos)
        game.addVisual(mensajeSalir)
        config.configurarTeclasRickPosta()
      
        game.whenCollideDo(rickPosta, {mensaje=> mensaje.cambiaColor()})
        
    }
}

object fondoSelect {
  method image () = "menuSeleccion.jpg"
  method position() = game.at(0,0) 
}