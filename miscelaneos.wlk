import nivel1.*
import player.*
import nivelesJoni.*
/*
EJEMPLO DE SONIDO
object sw {
  
  // Se llama el metodo con "sw.play"
  // tener en cuenta que esto es para que suene
  // hasta que termine.
  method play(){
    game.sound("zez.mp3").play()
  }

  // Si uno quiere que se detenga, se usa
  // -const "nombre" = game.sound("zaraza.mp3")-
  // Se lo llama 
  // -nombre.shouldLoop(true)-
  // Se le pone play con
  // -nombre.play()-
  // Y se lo detiene con 
  // nombre.stop()

}*/
object paleta {
  const property verde = "00FF00"
  const property rojo = "FF0000"
  const property blanco = "FFFFFF"
  const property amarillo = "FFFF00"
  const property negro = "000000"
}
/////////Textos de Rick sin game.say/////////1
class TextosRick{
  method position() = game.at(rick.position().x(),rick.position().y()+1)
  method textColor() = paleta.amarillo()
  method textbackground() = paleta.verde  ()
}
object prueba inherits TextosRick{  
  method text() = "¡Pepita te caga todo el auto!"
}
object inventario inherits TextosRick{
  method text() = "Partes de ArmaPortal:" + rick.objetos().toString() 
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
  
  method text() = "En una galazia muy muy lejana
  tu hermana, la nalgona
  nalgonea nalgas nalgunas en
  Nalgalandia"
  method textColor() = paleta.amarillo()

	method desplazamiento(){
  	const y = (position.y()+1)
		position = game.at(position.x(),y)
		
	}
}
