import miscelaneos.*
import wollok.game.*
import player.*

class Suelo {
  method image()
  method position() = game.origin()
}
//////////////////////////////////////////////
object suelo inherits Suelo{
  override method image() = "fondo1.jpg"
}
object fondo2 inherits Suelo{
  override method image() = "fondo0.jpg"
}
///////////////////////////////////////////////
//////////COSAS DE STAR WARS//////////
object fondo1 inherits Suelo{
  override method image() = "espacio.png"
}
object gonza {
  method image () = "gonza.png"
  var property position = game.at(3,-15)
  
  method desplazamiento(){
  	const y = (position.y()+1)
		position = game.at(position.x(),y)
		
	}
}
//////////////////////////////////////////////
class Portales {
  var image = "portal0.png"
  var position
  var property mapa = niveles.nivel3()

  method image () = image
  method position() = position
  
  method titila() {
    image = "portal1.png"
    game.schedule(75, {image = "portal2.png"})
    game.schedule(75, {image = "portal3.png"})
    game.schedule(75, {image = "portal0.png"})
  }
  method colision(algo) {
		// Necesito que al chocar te mande a jugarla2.jugar()
    // Pero que sea según el mapa
    self.mapa()
	}
}

const portal = new Portales(position = game.at(0,5) )
const portal2 = new Portales(position = game.at(11,5))

class Armas {
  var position
  var image

  method position () = position

  method image () = image

  method titila () {
    image = "gun1.png"
    game.schedule(400, {image = "gun0.png"})
  }
 
  method agarrado() {
    position = game.at(0,11)
    game.addVisual(arma)
    game.removeTickEvent("titilaArma")
    
  }
}

const arma = new Armas(position = game.at(3,3), image = "gun0.png")

class Placas {
  var position
  var image

  method position () = position

  method image () = image

  method titila () {
    image = "placa1.png"
    game.schedule(400, {image = "placa0.png"})
  }
  
  method agregarPlacasAlInventario(){
    if (rick.cantidadPlacas() == 1){
      game.addVisual(placa1)
      game.removeTickEvent("titilaPlaca")
    }
    if (rick.cantidadPlacas() == 2){
      game.addVisual(placa2)
      game.removeTickEvent("titilaPlacaa")
    }
    if (rick.cantidadPlacas() == 3){
      game.addVisual(placa3)
      game.removeTickEvent("titilaPlacaa")
    }
  }

  method agarrado() {
    self.agregarPlacasAlInventario()
    
  }
}

const placa = new Placas (position = game.at(4,4), image = "placa0.png")
const placaa = new Placas (position = game.at(3,4), image = "placa0.png")
const placaaa = new Placas (position = game.at(2,4), image = "placa0.png")
const placa1 = new Placas (position = game.at(1,11), image = "placa0.png")
const placa2 = new Placas (position = game.at(2,11), image = "placa0.png")
const placa3 = new Placas (position = game.at(3,11), image = "placa0.png")

object niveles {
  const ancho = 12 //se mide en celdas de 50 x 50px
  const alto = 12  //se mide en celdas de 50 x 50px

////////////////////////////////////////////////////
////////////////////////////////////////////////////
  var property habilitado = false
  
  method habilitador(){
    habilitado = true }

  method deshabilitador(){
    habilitado = false }
  
  method nivelSW(){
    config.removerVisuales()

    // Sonido SW
    const sw = game.sound("sw.mp3")
    sw.shouldLoop(true)
    sw.play()

    game.addVisual(fondo1)
    game.title("Star Wars")
    game.height(alto) 
	game.width(ancho)
    game.addVisual(mensajeSW)
    game.addVisual(gonza)
    
    game.onTick(1700, "IntroSW",{ mensajeSW.desplazamiento() })
    game.onTick(1700, "IntroSW",{ gonza.desplazamiento() })

    keyboard.o().onPressDo({ sw.stop();
                            self.corroboro() })
    
  }

  method corroboro(){
    if (habilitado){
      game.removeTickEvent("IntroSW")
      self.deshabilitador()
      //niveles.habilitador()
      self.nivel1()
    }
  }

////////////////////////////////////////////////////
////////////////////////////////////////////////////

  method nivel1() {

      config.removerVisuales()

      game.addVisual(suelo)
      game.title("Pickle Rick")
      //game.height(alto) 
      //game.width(ancho)
      game.addVisual(portal)
      game.addVisual(portal2)
      game.addVisual(arma)
      game.addVisual(placa)
      game.addVisual(placaa)
      game.addVisual(placaaa)
      game.addVisual(rata)
      game.addVisual(rick)

      config.configurarTeclasRick()

      game.onTick(300, "titilaPortal", {portal.titila()})
      game.onTick(300, "titilaPortal2", {portal2.titila()})
      game.onTick(2000, "titilaArma", {arma.titila()})
      game.onTick(2000, "titilaPlaca", {placa.titila()})
      game.onTick(2000, "titilaPlacaa", {placaa.titila()})
      game.onTick(2000, "titilaPlacaaa", {placaaa.titila()})
      
      config.configurarColisiones()

  //////////////////////////////////////////////////
      //EJEMPLO DE CHARLA CUANDO INICIA EL NIVEL

      //config.textoCharlado(4000,7000, inventario)
      //config.textoCharlado(7000,10000,saludo2)
    
  }
////////////////////////////////////////////////////
////////////////////////////////////////////////////
  
  method nivel3() {
      config.removerVisuales()

      game.addVisual(fondo2)
      game.title("Pickle Rick")
      game.addVisual(portal)
      game.addVisual(portal2)
      //game.addVisual(arma)
      //game.addVisual(placa)
      //game.addVisual(rata)
      game.addVisual(rick)

      //config.configurarTeclasRick()

      //game.onTick(300, "titilaPortal", {portal.titila()})
      //game.onTick(300, "titilaPortal2", {portal2.titila()})
      //game.onTick(2000, "titilaArma", {arma.titila()})
      //game.onTick(2000, "titilaPlaca", {placa.titila()})

  }

}

object config{
  var property borrar = 0

  method textoCharlado(inicio, fin, textoAImprimir){
      game.schedule(inicio, { game.addVisual(textoAImprimir) })
      game.schedule(fin, { game.removeVisual(textoAImprimir) })
  }

  method configurarTeclasRick(){
    keyboard.w().onPressDo({ rick.arriba() })
    keyboard.s().onPressDo({ rick.abajo() })
    keyboard.a().onPressDo({ rick.izquierda() })
    keyboard.d().onPressDo({ rick.derecha()})
    keyboard.c().onPressDo({ rick.agarrar(game.uniqueCollider(rick))})
    keyboard.i().onPressDo({ self.textoCharlado(0000, 4000, inventario)})
  }
  method configurarColisiones() {
    game.onCollideDo(rick, { algo => algo.colision(rick)})

	}
  method removerVisuales(){
    game.allVisuals().forEach({ visual => game.removeVisual(visual)})
  }

}

//////////////////////////////////////////////////