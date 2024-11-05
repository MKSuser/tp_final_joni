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

  method agregarALista(_objeto) {
    listaPlaca.add(_objeto)
  }

  method borrarDeLista(_objeto) {
    listaPlaca.remove(_objeto)
  }

  method reiniciarListaPlaca() = listaPlaca.clear()

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
    

  }

}

object nivel1 inherits Niveles(
  fondo = mapa0,
  nombre = "nivel1"){

  override method estructura(){
    super()
    config.textoCharlado(0,3000,nombreNivel1)
    config.textoCharlado(0,4000,holaRatas)

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
  nombre = "nivel2"){

  override method estructura(){
    super()
    config.textoCharlado(0,4000,nombreNivel2)
    
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
  nombre = "nivel3"){

  override method estructura(){
    super()
    config.textoCharlado(0,4000,nombreNivel3)
    
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
  nombre = "nivel4"){

  override method estructura(){
    super()
    config.textoCharlado(0,4000,nombreNivel4)
    config.textoCharlado(0,4000,holaPepita)

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
  nombre = "nivel5"){

  override method estructura(){
    super()
    config.textoCharlado(0,4000,nombreNivel5)
    config.textoCharlado(0,4000,holaDany)
    
    game.addVisual(rick)

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

  method reiniciarListasPlacas() {
    nivel1.reiniciarListaPlaca()
    nivel2.reiniciarListaPlaca()
    nivel3.reiniciarListaPlaca()
    nivel4.reiniciarListaPlaca()
  }  

  method gameOver(){

      game.clear()
      music.pararSonidoFondo()
      game.addVisual(fondo)
      sonido.play("gameover.mp3")
     
      keyboard.r().onPressDo({inicioPlap.presentacion()})
      keyboard.s().onPressDo({game.stop()})
      
      rick.reiniciarVida()
      rick.reiniciarPosicion()
      rickPosta.reiniciarPosicion()
      rick.soltarObjetos()
      danyTrejo.generarVidaDany()
      self.reiniciarListasPlacas()
      mapaRandom.llenarListaNiveles()

    }
}

object winner inherits Niveles(
  fondo = winnerImagen,
  nombre = "winner")
  {

  method reiniciarListasPlacas() {
    nivel1.reiniciarListaPlaca()
    nivel2.reiniciarListaPlaca()
    nivel3.reiniciarListaPlaca()
    nivel4.reiniciarListaPlaca()
  }  
  
  method winner(){
    
    game.clear()
    music.pararSonidoFondo()
    game.addVisual(fondo)
    
    game.schedule(1000,{sonido.play("winner99.mp3")})
    
    game.addVisual(ganaste)
    game.addVisual(puntosTotales)
    
    keyboard.r().onPressDo({inicioPlap.presentacion()})
    keyboard.s().onPressDo({game.stop()})
    
    rick.reiniciarVida()
    rick.reiniciarPosicion()
    rickPosta.reiniciarPosicion()
    rick.soltarObjetos()
    danyTrejo.generarVidaDany()
    self.reiniciarListasPlacas()
    mapaRandom.llenarListaNiveles()
  }

}

/////// CREDITOOOOS ///////// Falta completar
object creditos inherits Niveles(
  fondo = estrellas,
  nombre = "creditos")
  {
  
  override method estructura(){
    game.clear()
    musicaCreditos.iniciarSonidoFondo()
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
    game.schedule(45000, {game.removeTickEvent("desplazamientos")
                          musicaCreditos.pararSonidoFondo()
                          config.resetearPosicionesCreditos()
                          inicioPlap.presentacion()})                
    
  }
}

object comic inherits Niveles(
  fondo = comicImagen,
  nombre = "creditos")
  {
  
  override method estructura(){
    game.clear()
    game.addVisual(fondo)
    game.title(nombre)
    game.height(alto) 
    game.width(ancho)
    game.schedule(1000, {game.addVisual(cuadro1)})
    game.schedule(2500, {game.addVisual(cuadro2)})
    game.schedule(4000, {game.addVisual(cuadro3)})
    game.schedule(5500, {game.addVisual(cuadro4)})
    game.schedule(7000, {game.addVisual(cuadro5)})
    game.schedule(8500, {game.addVisual(cuadro6)})
    /*game.addVisual(cuadro2)
    game.addVisual(cuadro3)
    game.addVisual(cuadro4)
    game.addVisual(cuadro5)
    game.addVisual(cuadro6)
*/
    game.schedule(1500, { keyboard.e().onPressDo({ musicaMenu.pararSonidoFondo() 
                                                  music.iniciarSonidoFondo()
                                                  nivel1.estructura()})})
    //keyboard.e().onPressDo({ rick.esPortal(game.uniqueCollider(rick))})



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