import wollok.game.*
import PickleRick.*
import Config.*
import Enemigos.*
import Objetos.*
import intro.*
import Niveles.*


//----------------------------- Mapas --------------------------
class Mapas {
  var imagen
  method image () = imagen
  method position() = game.origin()

  method transicion () {
    transicion.titila()
  }
}

//////////////////////////////////////////////
const mapa0 = new Mapas (imagen = "fondoTierra.jpg")

const mapa1 = new Mapas (imagen = "fondoPasto.jpg")

const mapa2 = new Mapas (imagen = "fondoRojo.jpg")

const mapa3 = new Mapas (imagen = "fondoMadera.jpg")

const mapa4 = new Mapas (imagen = "fondoPiedra.jpg") //LA FINAL

//Selecciona un mapa random a menos que tenga los 4 objetos y va a la final
object mapaRandom {
  const listaNiveles = [2,3,4]
  
  method elegirMapa (){

    if (listaNiveles.size() == 0) {
      game.addVisual(transicion)
      transicion.titila()
      game.schedule(300, {niveles.nivel5()})
    }

    var nivelElegido = listaNiveles.anyOne()

    if (nivelElegido == 2) {
      game.addVisual(transicion)
      listaNiveles.remove(nivelElegido)
      transicion.titila()
      game.schedule(300,{niveles.nivel2()})
    }
    else if (nivelElegido == 3) {
      game.addVisual(transicion)
      listaNiveles.remove(nivelElegido)
      transicion.titila()
      game.schedule(300,{niveles.nivel3()})
    }
    else if (nivelElegido == 4) {
      game.addVisual(transicion)
      listaNiveles.remove(nivelElegido)
      transicion.titila()
      game.schedule(300,{niveles.nivel4()})
    }
  }
  
}




/*
class Suelo {
  method image()
  method position() = game.origin()
}
//////////////////////////////////////////////
object suelo inherits Suelo{
  override method image() = "fondoInicio.jpg"
}
object fondoRojo inherits Suelo{
  override method image() = "fondoRojo.jpg"
}


///////////////////////////////////////////////
//////////COSAS DE STAR WARS//////////
object fondoEspacio inherits Suelo{
  override method image() = "fondoEspacio.png"
}
object fondo3 inherits Suelo{
  override method image() = "fondoMadera.png"
}
object gonza {
  method image () = "gonza.png"
  var property position = game.at(3,-15)
  
  method desplazamiento(){
  	const y = (position.y()+1)
		position = game.at(position.x(),y)
		
	}
}*/