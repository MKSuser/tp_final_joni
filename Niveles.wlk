import wollok.game.*
import PickleRick.*
import Config.*
import Enemigos.*
import Objetos.*
import intro.*
import Mapas.*

//--------------------- Nivel 1 --------------------

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

    game.addVisual(puntosGanados)
    game.addVisual(vidaRick)

  }

}

object nivel1 inherits Niveles(
  fondo = mapa0,
  nombre = "nivel1"
){

  override method estructura(){
    super()
    music.sonidoFondo()

    config.crearPortal(0,5)
    config.crearPortal(11,5)
    
    config.crearPlaca(4,4)
    config.crearArma(3,3)
    
    game.addVisual(rick)

    config.crearRata()
    config.crearRata()
    config.crearRata()
    config.crearPepita()

//Gonza
      game.whenCollideDo(rick, {enemigo=> (rick.runAtacadoTick(enemigo))})
      

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
    config.crearRata()

    game.addVisual(danyTrejo)
    danyTrejo.seguir()

    game.addVisual(vidaDanyTrejo)
    sonido.play("risaMalvada.mp3")

    game.onTick(3000, "danyDisparo", {danyTrejo.disparar()})

    config.textoCharlado(3000, 6000, saludo2) //Pruebas
  }
}

object gameOver inherits Niveles(
  fondo = gameOverImagen,
  nombre = "gameOver")
  {

  method gameOver(){

      game.clear()
      game.addVisual(fondo)
      sonido.play("gameover.mp3")
     
      keyboard.r().onPressDo({inicioPlap.presentacion()})
      
      rick.reiniciarVida()
      rick.reiniciarPosicion()
      rick.soltarObjetos()
      music.paraSonidoFondo()
      game.addVisual(vidaDanyTrejo)
    }
}

object gameOverImagen {
    method position() = game.origin()
    method image() = "GameOver2.jpg"
  
}

object winner inherits Niveles(
  fondo = winnerImagen,
  nombre = "winner")
  {

  method winner(){
      
    music.paraSonidoFondo()
    game.clear()
    game.addVisual(fondo)
    
    sonido.play("winner.mp3")
    
    keyboard.r().onPressDo({inicioPlap.presentacion()})
    
    rick.reiniciarVida()
    rick.reiniciarPosicion()
    rick.soltarObjetos()
  }
}

object winnerImagen {
    method position() = game.origin()
    method image() = "Winner2.jpg"
}

/////// CREDITOOOOS ///////// Falta completar
object creditos inherits Niveles(
  fondo = estrellas,
  nombre = "creditos")
  {
  
  override method estructura(){
    game.clear()
    game.addVisual(fondo)
    game.title(nombre)
    game.height(alto) 
    game.width(ancho)
    game.addVisual(textoQueSeDesplaza)
    game.onTick(1200, "desplazamientos", { textoQueSeDesplaza.desplazamiento() })
    sonido.play("sw.mp3")
  }
}
object estrellas {
    method position() = game.origin()
    method image() = "estrellas.png"

}

class ImagenMovible{
    var posicion
    var imagen
    
    method position() = posicion
    
    method image() = imagen
    
    method desplazamiento(){
  	const y = (posicion.y()+1)
		posicion = game.at(posicion.x(),y)
		
	}
    
}

object joni inherits ImagenMovible(
    posicion = game.at(5,-10),
    imagen = "joni.png"
){}
object rodri inherits ImagenMovible(
    posicion = game.at(5,-12),
    imagen = "rodri.png"
){}
object nahue inherits ImagenMovible(
    posicion = game.at(5,-14),
    imagen = "nahue.png"
){}
object gonza inherits ImagenMovible(
    posicion = game.at(5,-18),
    imagen = "gonza1.png"
){}

/*
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
}*/