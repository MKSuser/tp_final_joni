import wollok.game.*
import PickleRick.*
import Niveles.*
import Enemigos.*
import Objetos.*
import intro.*
import Mapas.*

//------------------------- Configuraciones -----------------------------------

object config{
  var property idRatas = 0
  var property idLaser = 0
  var property disparo = 0
  var property cantBalas = 3


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

    keyboard.f().onPressDo({ self.disparar()}) //Si no tiene arma no dispara
    
  }

  /*// Accion ni bien se colisiona - Por ahora lo usamos distinto
  method configurarColisiones() {
    game.onCollideDo(rick, { algo => algo.colision(rick)})

	}*/

/* AL FINAL CON EL CLEAR() LO SOLUCIONAMOS EL TEMA DE LOS VISUALES*/
  // Remover TODOS los visuales
  method removerVisuales(){
    game.allVisuals().forEach({ visual => game.removeVisual(visual)})
  }

  // Creador de portales
  method crearPortal(x,y){
    const portal = new Portales(position = game.at(x,y))
    game.addVisual(portal)
    game.onTick(300, "titilaPortal", {portal.titila()})
  }
  
  // Creador de placas
  method crearPlaca(x,y){
    const placa = new Placas(position = game.at(x,y))
    game.addVisual(placa)
    game.onTick(2000, "titilaPlaca", {placa.titila()})
  }

  // Creador de armas
  method crearArma(x,y){
    const arma = new Armas(position = game.at(x,y))
    game.addVisual(arma)
    game.onTick(2000, "titilaArma", {arma.titila()})
  }
  
  // Creador de ratas
  method crearRata(){
    idRatas += 1
    const rata = new Ratas()
    game.addVisual(rata)
    rata.crearRata()
  }

  // Lista de Armas para printearLoQueTenemos()
  method listarArmas(){
    return rick.objetos().filter({n => n.className() == "Objetos.Armas"})
  }

  // Lista de Placas para printearLoQueTenemos()
  method listarPlacas(){
    return rick.objetos().filter({n => n.className() == "Objetos.Placas"})
  }

  // Metodo para...
  method printearLoQueTenemos(){
        
    self.listarArmas().forEach({ objeto => game.addVisual(objeto)})

    self.listarPlacas().forEach({ objeto => game.addVisual(objeto)})

  }

  // Verificar que tenemos la pistolota y que tiene menos de X balas
  method tenemosPistolaYnoLlena(){
    return (rick.objetos().any({n => n.className() == "Objetos.Armas"}) && (rick.lasers().size() < cantBalas))
  }

  // Verificamos que ya tenemos X balas, por lo que las utilizamos según el "cargador" de Rick
    method tenemosPistolaCompleta(){
  
      if (not self.tenemosPistolaYnoLlena()){
        rick.lasers().find({ laser => laser.position() == game.at(-1,-1) }).disparar()
      } 
    }

  // Llamada de los metodos anteriores
  // Si se cumple la primer condi generamos un nuevo laser
  // e incrementamos en 1 el ID para poder llevar los OnTick independientemente.
  // Si ya completamos el arma solo usa las mismas balas siempre
  method disparar(){
   
    if (self.tenemosPistolaYnoLlena()){
      new Lasers().disparar()
      idLaser += 1
    }else {
      self.tenemosPistolaCompleta()}
  }
}

// Paleta para uso de colores
object paleta {
  const property verde = "00FF00"
  const property rojo = "FF0000"
  const property blanco = "FFFFFF"
  const property amarillo = "FFFF00"
  const property negro = "000000"
}

/////////Textos de Rick sin game.say/////////
class TextosRick{
  method position() = game.at(rick.position().x(),rick.position().y()+1)
  method textColor() = paleta.amarillo()
}

object prueba inherits TextosRick{  
  method text() = "¡Prueba!"
}

object inventario inherits TextosRick{
  method text() = "Partes de ArmaPortal:" + rick.objetos().toString() + "
  Lasers:" + rick.lasers().get(0).id().toString() + rick.lasers().get(1).id().toString() + rick.lasers().get(2).id().toString()
  //placa.contarPlacas().toString() 
  /*+ "perro:" + 3.toString() + "
  gilada:" + paleta.amarillo().toString()*/
  const lista = [paleta, saludo2]
}

object saludo2 inherits TextosRick{ 
  method text() = "qué mirás gato? 
  nunca viste un pickle?"
}

object pichium inherits TextosRick{ 
  method text() = "Ahora siiii!
  Pichium!
  PIchium!"
}

object mensajeSW {
  var property position = game.at(5,-6) //se mide en celdas de 50 x 50px
  
  method text() = "En una galazia muy muy lejana"
  method textColor() = paleta.amarillo()

	method desplazamiento(){
  	const y = (position.y()+1)
		position = game.at(position.x(),y)
		
	}
}