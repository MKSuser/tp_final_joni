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

  const property listaPlaca = []

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

    game.whenCollideDo(rick, {enemigo=> (rick.runAtacadoTick(enemigo))})
    music.sonidoFondo()

  }

}

object nivel1 inherits Niveles(
  fondo = mapa0,
  nombre = "nivel1"
){

  override method estructura(){
    super()
    
    //music.iniciarSonidoFondo()

    config.crearPortal(0,5)
    config.crearPortal(11,5)
    
    config.crearArma(3,3,self)
    
    game.addVisual(rick)

    config.crearRata()
    config.crearRata()
    config.crearRata()
    
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

    config.crearPlaca(3,4, self)

    game.addVisual(rick)
    
    config.crearRata()
    config.crearRata()
    config.crearRata()

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

    config.crearPlaca(2,4, self)

    game.addVisual(rick)
    config.crearRata()
    config.crearRata()
    config.crearRata()

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
    config.crearPlaca(10,10, self)

    game.addVisual(rick)
    config.crearPepita()
    config.crearPepita()
    config.crearPepita()

  }
}

object nivel5 inherits Niveles(
  fondo = mapa4,
  nombre = "nivel5"
){

  override method estructura(){
    super()
    
    game.addVisual(rick)
    //config.crearRata()

    game.addVisual(danyTrejo)
    danyTrejo.seguir()

    game.addVisual(vidaDanyTrejo)
    sonido.play("risaMalvada.mp3")

    game.onTick(3000, "danyDisparo", {danyTrejo.disparar()})


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
      music.pararSonidoFondo()
      game.addVisual(vidaDanyTrejo)
      
      danyTrejo.generarVidaDany()
      rick.reiniciarPuntos()
    }
}

object gameOverImagen {
    method position() = game.origin()
    method image() = "gameOver.jpeg"
  
}

object winner inherits Niveles(
  fondo = winnerImagen,
  nombre = "winner")
  {

  method winner(){
      
    //music.pararSonidoFondo()
    game.clear()
    game.addVisual(fondo)
    
    game.schedule(3000,{sonido.play("winner4.mp3")})
    //puntosGanados.position() = game.at(9,3)
    
    game.addVisual(puntosGanados)//CORREGIR LA POSICION
    
    keyboard.r().onPressDo({inicioPlap.presentacion()})
    
    rick.reiniciarVida()
    rick.reiniciarPosicion()
    rick.soltarObjetos()
    danyTrejo.generarVidaDany()
    rick.reiniciarPuntos()
  }

}

object winnerImagen {
    method position() = game.origin()
    method image() = "winner.jpeg"
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
    game.addVisual(joni)
    game.addVisual(rodri)
    game.addVisual(nahue)
    game.addVisual(gonza)
    game.onTick(1200, "desplazamientos", { textoQueSeDesplaza.desplazamiento()
                                            joni.desplazamiento()
                                            nahue.desplazamiento()
                                            rodri.desplazamiento()
                                            gonza.desplazamiento() })
    sonido.play("sw.mp3")
    game.schedule(40000, {inicioPlap.presentacion() musicaCreditos.paraSonidoFondo()})
    musicaCreditos.sonidoFondo()
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

object rodri inherits ImagenMovible(
    posicion = game.at(3,-6),
    imagen = "zrodri.png"
){}

object nahue inherits ImagenMovible(
    posicion = game.at(3,-11),
    imagen = "znahue.png"
){}

object joni inherits ImagenMovible(
    posicion = game.at(3,-16),
    imagen = "zjoni.png"
){}

object gonza inherits ImagenMovible(
    posicion = game.at(4,-20),
    imagen = "zgonza1.png"
){}

object textoQueSeDesplaza {
  var property position = game.at(5,-11) //se mide en celdas de 50 x 50px
  
  method text() = "
  






  PICKLE RICK!!


  Integrantes:
  
  CASCO, Rodrigo
  
  
  





  
  
  
  GARCÍA, Nahuel
  
  









  
  
  
  GÓMEZ CIRANNA, Jonathan
  
  






  
  
  
  
  LOPEZ, Gonzalo
  


  
  
  
  
  
  
  
  
  
  
  

  Materia:
  Algoritmos 1

  Trabajo Práctico - WOLLOK Game

  UNSAM (Univ.Nacional de San Martín)"

  method textColor() = paleta.amarillo()

	method desplazamiento(){
  	const y = (position.y()+1)
		position = game.at(position.x(),y)
		
	}
}

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