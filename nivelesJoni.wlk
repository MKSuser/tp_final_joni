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

  //method mapa() = mapa2

  method image () = image
  
  method position() = position
  
  method titila() {
    image = "portal1.png"
    game.schedule(75, {image = "portal2.png"})
    game.schedule(75, {image = "portal3.png"})
    game.schedule(75, {image = "portal0.png"})
  }
  method agarrado(objeto) {
      self.mapa()
  }
}

/*
object p inherits Portales(position = game.at(0,5)){
  var property mapa2 = niveles.nivel3()

  override method agarrado(objeto){
    self.mapa2()
  }
}*/

//var portal = new Portales(position = game.at(0,5) ,mapa = niveles.nivel1())

class Armas {
  var position
  var image = "gun0.png" // En el de Rodra no hay imagen, se declara al crearlo

  method position () = position

  method image () = image

  method mover(objeto){
    //const armaInv = new Armas(position = game.at(0,11))
    //game.addVisual(armaInv)
    position = game.at(0,11)
  }

  method titila () {
    image = "gun1.png"
    game.schedule(400, {image = "gun0.png"})
  }
 
  method agarrado(objeto) {
    //config.textoCharlado(0000,4000,pichium)
    //game.removeVisual(objeto)
    self.mover(objeto)
    game.removeTickEvent("titilaArma") 
  }
}


class Placas {
  var property position
  var property image = "placa0.png"

  method titila () {
    image = "placa1.png"
    game.schedule(400, {image = "placa0.png"})
  }

  method mover(objeto){
    //const placaInv = new Placas(position = game.at(self.contarPlacas(objeto),11))
    //game.addVisual(placaInv)
    position = game.at(config.listarPlacas().size(),11)
  }
  
  //method contarPlacas(){
  //  return rick.objetos().filter({n => n.className() == "nivelesJoni.Placas"}).size()}
  
  method agarrado(objeto) {
    //game.removeVisual(objeto)
    //objeto.mover(objeto)
    game.removeTickEvent("titilaPlaca")
    self.mover(objeto)
  }
}

object niveles {
  const ancho = 12 //se mide en celdas de 50 x 50px
  const alto = 12  //se mide en celdas de 50 x 50px

////////////////////////////////////////////////////
////////////STAR WARS/////////////////////
  /*var property habilitado = false
  
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

*////////////////////////////////////////////////////
////////////////////////////////////////////////////

  method nivel1() {

      config.removerVisuales()

      game.addVisual(suelo)
      game.title("Pickle Rick")
      game.height(alto) 
      game.width(ancho)

      config.crearPortal(0,5)
      config.crearPortal(11,5)

      config.crearPlaca(4,4)
      config.crearPlaca(3,4)
      config.crearPlaca(2,4)

      config.crearArma(3,3)

      game.addVisual(rata)
      game.addVisual(rick)

      config.configurarTeclasRick()

      //config.configurarColisiones()

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

      config.crearPortal(0,5)
      config.crearPortal(11,5)

      config.printearLoQueTenemos()
      
      game.addVisual(rata)
      game.addVisual(rick)

  }

}

object config{

  // El ".say" casero
  method textoCharlado(inicio, fin, textoAImprimir){
      game.schedule(inicio, { game.addVisual(textoAImprimir) })
      game.schedule(fin, { game.removeVisual(textoAImprimir) })
  }

  // Teclas de Rick
  method configurarTeclasRick(){
    keyboard.w().onPressDo({ rick.arriba() })
    keyboard.s().onPressDo({ rick.abajo() })
    keyboard.a().onPressDo({ rick.izquierda() })
    keyboard.d().onPressDo({ rick.derecha()})

    keyboard.e().onPressDo({ rick.esPortal(game.uniqueCollider(rick))})

    keyboard.i().onPressDo({ self.textoCharlado(0000, 4000, inventario)})

  }

  // Accion ni bien se colisiona
  method configurarColisiones() {
    game.onCollideDo(rick, { algo => algo.colision(rick)})

	}

  // Remover TODOS los visuales
  method removerVisuales(){
    game.allVisuals().forEach({ visual => game.removeVisual(visual)})
  }

  method crearPortal(x,y){
    const portal = new Portales(position = game.at(x,y))
    game.addVisual(portal)
    game.onTick(300, "titilaPortal", {portal.titila()})
  }

  method crearPlaca(x,y){
    const placa = new Placas(position = game.at(x,y))
    game.addVisual(placa)
    game.onTick(2000, "titilaPlaca", {placa.titila()})
  }

  method crearArma(x,y){
    const arma = new Armas(position = game.at(x,y))
    game.addVisual(arma)
    game.onTick(2000, "titilaArma", {arma.titila()})
  }
  
  // Lista para printearLoQueTenemos()
  method listarArmas(){
    return rick.objetos().filter({n => n.className() == "nivelesJoni.Armas"})
  }

  // Lista para printearLoQueTenemos()
  method listarPlacas(){
    return rick.objetos().filter({n => n.className() == "nivelesJoni.Placas"})
  }

  // Metodo para poder arrastar lo que agarramos
  method printearLoQueTenemos(){
        
    self.listarArmas().forEach({ objeto => game.addVisual(objeto)})

    self.listarPlacas().forEach({ objeto => game.addVisual(objeto)})

  }

}

//////////////////////////////////////////////////