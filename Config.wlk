import wollok.game.*
import PickleRick.*
import Niveles.*
import Enemigos.*
import Objetos.*
import intro.*
import Mapas.*

//------------------------- Configuraciones -----------------------------------

object config{
  //var property idRatas = 0
  //var property idLaser = 0
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

    //keyboard.i().onPressDo({ self.textoCharlado(0000, 4000, inventario)})

    keyboard.f().onPressDo({ rick.disparar()}) //Si no tiene arma no dispara
    
  }

  method configurarTeclasRickPosta(){
    keyboard.w().onPressDo({rickPosta.arriba()})
    keyboard.s().onPressDo({rickPosta.abajo()})
    keyboard.a().onPressDo({rickPosta.izquierda()})
    keyboard.d().onPressDo({rickPosta.derecha()})
    
    keyboard.e().onPressDo({ rickPosta.seleccionador(game.uniqueCollider(rickPosta))})

    //keyboard.e().onPressDo({ self.opcionesMenu(game.uniqueCollider(rickPosta))})
  }

  /*// Accion ni bien se colisiona - Por ahora lo usamos distinto
  method configurarColisiones() {
    game.onCollideDo(rick, { algo => algo.colision(rick)})

	}*/

/* AL FINAL CON EL CLEAR() LO SOLUCIONAMOS EL TEMA DE LOS VISUALES*/
  // Remover TODOS los visuales
  //method removerVisuales(){
  //  game.allVisuals().forEach({ visual => game.removeVisual(visual)})
  //}

  // Creador de portales
  method crearPortal(x,y){
    const portal = new Portales(position = game.at(x,y))
    game.addVisual(portal)
    //game.onTick(4000, "titilaPortal", {portal.titila()}) MUTEADO PORQUE SLOWEA EL SISTEMA
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
    //idRatas += 1
    const rata = new Ratas()
    game.addVisual(rata)
    rata.crearEnemigo()
  }
  
  method crearPepita(){
    const pepita = new Pepitas()
    game.addVisual(pepita)
    pepita.crearEnemigo()
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
  method tenemosPistolaYnoLlena(_entidad){
    return (_entidad.objetos().any({n => n.className() == "Objetos.Armas"}) && (_entidad.lasers().size() < cantBalas))
  }

  // Verificamos que ya tenemos X balas, por lo que las utilizamos según el "cargador" de Rick
    method tenemosPistolaCompleta(_entidad){
  
      if (not self.tenemosPistolaYnoLlena(_entidad)){
        _entidad.lasers().find({ laser => laser.position() == game.at(13,13) }).disparar(self)
      } 
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


/////////Textos game.say/////////

//////////PRUEBAS
object prueba{  
  method text() = "¡Prueba!"
}

object saludo2 { 
  method text() = "eeeeeeeehh, como que
  le falta un poco de 
  explosiones a esto!!"
}

object pichium { 
  method text() = "Ahora siiii!
  Pichium!
  PIchium!"
}
//////////

////////////MENSAJES MENU PRINCIPAL

///////COMENZAR
object mensajeJugar {
  var property color = "#ffffffff"
  method position() = game.at(5,6) 
  method text() = "COMENZAR"
  method textColor() = color
  
  method cambiaColor() {
    color = "008000"
    game.schedule(500, {color = "#ffffffff"})
  }

  method siguiente(){
  nivel1.estructura() 
}
}

///////CREDITOS
object mensajeCreditos {
  var property color = "#ffffffff"
  method position() = game.at(5,4) 
  method text() = "CRÉDITOS"
  method textColor() = color
  
  method cambiaColor() {
    color = "9B9B9B"
    game.schedule(500, {color = "#ffffffff"})
  }
  
  method siguiente(){
    game.stop()//CAMBIAR POR NIVEL CREDITOS
  }
}

///////QUIT
object mensajeSalir {
  var property color = "#ffffffff"
  method position() = game.at(5,2)
  method text() = "SALIR"
  method textColor() = color
  
  method cambiaColor() {
    color = "8B0000"
    game.schedule(500, {color = "#ffffffff"})
  }
  
  method siguiente(){
    game.stop()
  }
}

////////TESTIGOS

///////////
object puntosGanados {
  var property position = game.at(7,11) 
  method text() = "Puntaje: " + rick.puntos().toString()
  method textColor() = paleta.blanco()
}

//////////
object vidaDanyTrejo {
  method position() = game.at(rick.position().x(),rick.position().y()+1)
  method text() = "HP: " + rick.vida().toString()//cambiar a rick por danyTrejo
  method textColor() = paleta.rojo()
}
///////////
object vidaRick {
  var property position = game.at(10,11) 
  method text() = "HP: " + rick.vida().toString()
  method textColor() = paleta.verde()
}


object textoQueSeDesplaza {
  var property position = game.at(5,-6) //se mide en celdas de 50 x 50px
  
  method text() = "En una galazia muy muy lejana"
  method textColor() = paleta.amarillo()

	method desplazamiento(){
  	const y = (position.y()+1)
		position = game.at(position.x(),y)
		
	}
}

////////DE TODO UN POCO QUE PUEDE SERVIR

/* TEXTO PARA IMPRIMIR COSAS CON STRING
object inventario sRick{
  method text() = "Partes de ArmaPortal:" + rick.objetos().toString() + "
  Lasers:" + rick.lasers().get(0).id().toString() + rick.lasers().get(1).id().toString() + rick.lasers().get(2).id().toString()
  //placa.contarPlacas().toString() 
  /*+ "perro:" + 3.toString() + "
  gilada:" + paleta.amarillo().toString()
  const lista = [paleta, saludo2]
}
*/
