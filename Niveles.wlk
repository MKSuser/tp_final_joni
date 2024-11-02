import wollok.game.*
import PickleRick.*
import Config.*
import Enemigos.*
import Objetos.*
import intro.*
import Mapas.*

//--------------------- Nivel 1 --------------------
/*
class Niveles{
  const ancho = 12 //se mide en celdas de 50 x 50px
  const alto = 12  //se mide en celdas de 50 x 50px

  var property fondo
  const nombre

  method estructura(){

  game.clear()
  config.configurarTeclasRick()

  game.addVisual(fondo)
  game.title(nombre)
  game.height(alto) 
  game.width(ancho)

  config.printearLoQueTenemos()
  niveles.sonidoFondo()

  }
}

object nivel1 inherits Niveles(
  fondo = mapa0,
  nombre = "nivel1"
){

  override method estructura(){
    super()

    config.crearPortal(0,5)
    config.crearPortal(11,5)
    
    config.crearPlaca(4,4)
    config.crearArma(3,3)
    
    game.addVisual(rick)

    config.crearRata()
    config.crearRata()
    config.crearRata()
    config.crearPepita()
    niveles.sonidoFondo()

  }

}

object nivel2 inherits Niveles(
  fondo = mapa1,
  nombre = "nivel2"
){

  override method estructura(){
    super()
    
    config.crearPortal(0,5)
    config.crearPortal(11,5)

    config.crearPlaca(3,4)

    game.addVisual(rick)
    
    config.crearRata()
    niveles.sonidoFondo()

    config.textoCharlado(3000, 6000, saludo2)//Pruebas
  }
}

object nivel3 inherits Niveles(
  fondo = mapa2,
  nombre = "nivel3"
){

  override method estructura(){
    super()
    
    config.crearPortal(0,5)
    config.crearPortal(11,5)

    config.crearPlaca(2,4)

    game.addVisual(rick)
    niveles.sonidoFondo()

    config.crearRata()
    config.textoCharlado(3000, 6000, saludo2)//Pruebas
  }
}

object nivel4 inherits Niveles(
  fondo = mapa3,
  nombre = "nivel4"
){

  override method estructura(){
    super()
    
    config.crearPortal(0,5)
    config.crearPortal(11,5)

    game.addVisual(rick)
    niveles.sonidoFondo()

    config.crearRata()
    config.textoCharlado(3000, 6000, saludo2) //Pruebas
  }
}

object nivel5 inherits Niveles(
  fondo = mapa4,
  nombre = "nivel5"
){

  override method estructura(){
    super()
    
    game.addVisual(rick)
    niveles.sonidoFondo()

    config.crearRata()
    config.textoCharlado(3000, 6000, saludo2) //Pruebas
  }
}

object gameOver inherits Niveles(
  fondo = gameOverImagen,
  nombre = "nivel5"
){
  method gameOver(){
      fondo.stop()
      //game.clear()
      game.addVisual(fondo)
      sonido.play("gameover.mp3")
     
      keyboard.r().onPressDo({inicioPlap.presentacion()})
      //keyboard.s()onPressDo(())
      
      //inicioPlap.habilitador()
      
      rick.reiniciarVida()
      rick.reiniciarPosicion()
      rick.soltarObjetos()
    }
}

object winner inherits Niveles(
  fondo = winnerImagen,
  nombre = "nivel5"
){

  method winner(){
      
      fondo.stop()
      game.clear()
      game.addVisual(fondo)
      
      sonido.play("winner.mp3")
      
      keyboard.r().onPressDo({inicioPlap.presentacion()})
      
      //primeraPantalla.habilitador()
      
      rick.reiniciarVida()
      rick.reiniciarPosicion()
      rick.soltarObjetos()
    }
}
object gameOverImagen {
    method position() = game.origin()
    method image() = "GameOver2.jpg"
  
}
object winnerImagen {
    method position() = game.origin()
    method image() = "Winner2.jpg"
}


object niveles {

const fondo = game.sound("fondo.mp3")

    method sonidoFondo() {
      fondo.shouldLoop(true)
      keyboard.down().onPressDo({ fondo.volume(0) }) 
      keyboard.up().onPressDo({fondo.volume(1)})
      fondo.play()
    }

}
*/


object niveles {
  const ancho = 12 //se mide en celdas de 50 x 50px
  const alto = 12  //se mide en celdas de 50 x 50px

  method nivel1() {
      game.clear()
      config.configurarTeclasRick()

      game.addVisual(mapa0)
      game.title("Pickle Rick")
      game.height(alto) 
      game.width(ancho)

      config.printearLoQueTenemos()

      config.crearPortal(0,5)
      config.crearPortal(11,5)

      config.crearPlaca(4,4)

      config.crearArma(3,3)

      config.crearRata()
      config.crearRata()
      config.crearRata()
      config.crearPepita()

      game.addVisual(rick)
      
      
      self.sonidoFondo()//Nahue

      //Gonza
      game.whenCollideDo(rick, {enemigo=> (rick.runAtacadoTick(enemigo))})
      
      game.addVisual(vidaDanyTrejo)
      game.addVisual(puntosGanados)
      game.addVisual(vidaRick)


  }

  method nivel2() {
      game.clear()
      config.configurarTeclasRick()

      game.addVisual(mapa1)
      game.title("Pickle Rick")
      game.height(alto) 
      game.width(ancho)

      config.printearLoQueTenemos()

      config.crearPortal(0,5)
      config.crearPortal(11,5)
      
      config.crearPlaca(3,4)

      config.crearRata()

      game.addVisual(rick)

      config.textoCharlado(3000, 6000, saludo2)//Pruebas
      self.sonidoFondo()

  }

  method nivel3() {
      game.clear()
      config.configurarTeclasRick()
      
      game.addVisual(mapa2)
      game.title("Pickle Rick")
      game.height(alto) 
      game.width(ancho)

      config.crearPortal(0,5)
      config.crearPortal(11,5)

      config.crearPlaca(2,4)

      config.printearLoQueTenemos()
      
      config.crearRata()
      game.addVisual(rick)
      config.textoCharlado(3000, 6000, saludo2)//Pruebas

      self.sonidoFondo()
  }
  method nivel4() {
      game.clear()
      config.configurarTeclasRick()
      
      game.addVisual(mapa3)
      game.title("Pickle Rick")
      game.height(alto) 
      game.width(ancho)

      config.printearLoQueTenemos()

      config.crearPortal(0,5)
      config.crearPortal(11,5)

      config.crearRata()
      game.addVisual(rick)
      config.textoCharlado(3000, 6000, saludo2) //Pruebas
      self.sonidoFondo()

  }

  method nivel5() {
      game.clear()
      config.configurarTeclasRick()
      
      game.addVisual(mapa4)
      game.title("Pickle Rick")
      game.height(alto) 
      game.width(ancho)

      config.printearLoQueTenemos()
      
      config.crearRata()
      game.addVisual(rick)
      config.textoCharlado(3000, 6000, saludo2) //Pruebas
      self.sonidoFondo()
  }


method gameOver(){
      fondo.stop()
      game.clear()
      game.addVisual(gameOverImagen)
      sonido.play("gameover.mp3")
      keyboard.r().onPressDo({inicioPlap.presentacion()})
      //keyboard.s()onPressDo(())
      //primeraPantalla.habilitador()
      rick.reiniciarVida()
      rick.reiniciarPosicion()
      rick.soltarObjetos()
    }


    method winner(){
      fondo.stop()
      game.clear()
      game.addVisual(winnerImagen)
      sonido.play("winner.mp3")
      keyboard.r().onPressDo({inicioPlap.presentacion()})
      //primeraPantalla.habilitador()
      rick.reiniciarVida()
      rick.reiniciarPosicion()
      rick.soltarObjetos()
    }

const fondo = game.sound("fondo.mp3")

    method sonidoFondo() {
      fondo.shouldLoop(true)
      keyboard.down().onPressDo({ fondo.volume(0) }) 
      keyboard.up().onPressDo({fondo.volume(1)})
      fondo.play()
    }




}
object gameOverImagen {
    method position() = game.origin()
    method image() = "GameOver2.jpg"
  
} 

object winnerImagen {
    method position() = game.origin()
    method image() = "Winner2.jpg"
}