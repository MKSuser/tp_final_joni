import wollok.game.*
import PickleRick.*
import Config.*
import Enemigos.*
import Objetos.*
import intro.*
import Mapas.*


//--------------------- Nivel 1 --------------------
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

      game.addVisual(rick)

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
  }



}