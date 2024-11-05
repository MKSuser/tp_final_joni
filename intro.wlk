import wollok.game.*
import Objetos.*
import PickleRick.*
import Config.*
import Mapas.*
import Niveles.*

/////////////// INTRO + MENU PRINCIPAL
object inicioPlap {
  const ancho = 12
  const alto = 12

  method presentacion(){
    game.clear()
    game.title("Pickle Rick")
    game.height(alto) 
    game.width(ancho)

    rick.reiniciarPuntos() //SI REINICIAS EL JUEGO DE CUALQUIER MANERA ACÁ TE LIMPIA LOS PUNTOS

    sonido.play("plap.mp3")    
    game.addVisual(imagenPlap)
    game.schedule(4000, {selectMenu.inicio()})
  }
  
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
        musicaMenu.iniciarSonidoFondo()
      
        game.whenCollideDo(rickPosta, {mensaje=> mensaje.cambiaColor()})
        
    }
}

