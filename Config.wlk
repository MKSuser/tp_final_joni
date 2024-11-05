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

  }

  // Creador de portales
  method crearPortal(x,y){
    const portal = new Portales(position = game.at(x,y))
    game.addVisual(portal)
    //game.onTick(4000, "titilaPortal", {portal.titila()}) MUTEADO PORQUE SLOWEA EL SISTEMA
  }
  
  // Creador de placas
  method crearPlaca(x,y, _nivel){
    const placa = new Placas(position = game.at(x,y))
    game.addVisual(placa)
    game.onTick(2000, "titilaPlaca", {placa.titila()})
    if(_nivel.listaPlaca().size() == 0) {
      _nivel.agregarALista(self)
    }
  }

  // Creador de armas
  method crearArma(x,y, _nivel){
    const arma = new Armas(position = game.at(x,y))
    game.addVisual(arma)
    game.onTick(2000, "titilaArma", {arma.titila()})
    _nivel.agregarALista(self)
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
  
    _entidad.lasers().find({ laser => laser.position() == game.at(13,13) }).disparar(_entidad)

    }
  
  method resetearPosicionesCreditos(){
    rodri.mover(3,-6)
    nahue.mover(3,-11)
    joni.mover(3,-16)
    gonza.mover(3,-20)
    textoQueSeDesplaza.mover(5,-11)

  }
}
//////////////// PALETA PARA USO DE COLORES
object paleta {
  const property verde = "00FF00"
  const property rojo = "FF0000"
  const property blanco = "FFFFFF"
  const property amarillo = "FFFF00"
  const property negro = "000000"
  const property gris = "9B9B9B"
}

class Textos{
  var property posicion = game.at(2,0) 
  var property texto
  var property color = paleta.blanco()

  method position() = posicion
  method text() = texto
  method textColor() = color

}

object cuadro1 inherits Textos(
  posicion = game.at(4,10),
  texto = "...y muchos 
  colores!",
  color = paleta.amarillo()
){}

object cuadro2 inherits Textos(
  posicion = game.at(8,10),
  texto = "Re QUe TE
  BOOOM!",
  color = paleta.negro()
){}

object cuadro3 inherits Textos(
  posicion = game.at(4,7),
  texto = "Ohhhh seeeeee,
  la buena vida!!!",
  color = paleta.blanco()
){}

object cuadro4 inherits Textos(
  posicion = game.at(9,6),
  texto = "Y así, nuestro buen amigo
  Rick, se embarca en una nueva
  aventura de ciencia y...",
  color = paleta.negro()
){}

object cuadro5 inherits Textos(
  posicion = game.at(3,3),
  texto = "MUERE MALDITA 
  RATA!!!",
  color = paleta.amarillo()
){}

object cuadro6 inherits Textos(
  posicion = game.at(7,2),
  texto = "JAAA!!! Esta vez
  recuperare mi arma y las
  placas de mi.. eeehh bueno..
  mis placas! Malditas ratas 
  del infiernoooo!!!!
      

  (E para masacrar!!!)",
  color = paleta.negro()
){}


object nombreNivel1 inherits Textos(
  texto = "---Tierra Rocosa---"
  
){}

object nombreNivel2 inherits Textos(
  texto = "---Mariolandia---"
){}

object nombreNivel3 inherits Textos(
  texto = "---Verdelandia--- (ahre daltonico)",
  color = paleta.amarillo()
){}

object nombreNivel4 inherits Textos(
  texto = "--PepitaSalvajeLandia---"
){}

object nombreNivel5 inherits Textos(
  texto = "---Boss Final!!!!---"
){}

//////////PRUEBAS

class TextosRick{
  var property poder = 0
  var property color = paleta.amarillo()
  var property texto

  method position() = game.at(rick.position().x(),rick.position().y()+1)
  method text() = texto
  method textColor() = color
}


object pichium inherits TextosRick(
  texto = "Ahora siiii!
  Pichium!
  Pichium!"
){}

object holaPepita inherits TextosRick(
  texto = "A boeee,
  otra vez vos?
  Te llegó tu Silvestre pajaro!"
){}

object holaRatas inherits TextosRick(
  texto = "Me extrañarooooon!?!?"
){}

object holaDany inherits TextosRick(
  texto = "Dany, ahora vas 
  a sentir la furia 
  de mi pichium pichium!!!"
){}

////////////MENSAJES MENU PRINCIPAL//////////

///////Comenzar
class MensajesMenuPrincipal {
  var property color = paleta.blanco()
  var property position 
  var property text 
  method textColor() = color 
  var property _color 

  method cambiaColor() {
    color = _color
    game.schedule(500, {color = paleta.blanco()})
  }

  method siguiente(){}
}

///////COMENZAR
object mensajeJugar inherits MensajesMenuPrincipal(
  position = game.at(5,6),
  text = "COMENZAR",
  _color=paleta.verde()) {

  override method siguiente() {
  comic.estructura()
  }
}

  ///////CREDITOS
object mensajeCreditos inherits MensajesMenuPrincipal(
    position = game.at(5,4),
    text = "CRÉDITOS",
    _color = paleta.gris()) 
  {

  override method siguiente() {
  musicaMenu.pararSonidoFondo()
  creditos.estructura()
  }
}

///////QUIT
object mensajeSalir inherits MensajesMenuPrincipal(
  position = game.at(5,2),
  text = "SALIR",
  _color=paleta.rojo()) {

  override method siguiente() {
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
  var property poder = 0

  method position() = game.at(danyTrejo.position().x(),danyTrejo.position().y()+2)
  method text() = "HP: " + danyTrejo.vida().toString() + danyTrejo.lasers().toString()//cambiar a danyTrejo por danyTrejo
  method textColor() = paleta.rojo()

}
///////////
object vidaRick {
  var property position = game.at(10,11) 
  method text() = "HP: " + rick.vida().toString()
  method textColor() = paleta.verde()
}

object puntosTotales {
  var property position = game.at(10,0) 
  method text() = "Puntaje Total: " + rick.puntos().toString()
  method textColor() = paleta.negro()  
}

object ganaste {
  var property position = game.at(10,1) 
  method text() = "¡GANASTE!"
  method textColor() = paleta.negro()  
}

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

  method mover(x,y){
    position = game.at(x,y)
  }
}
/////////////////////// MUSICA Y SONIDOS

//Sonidos tipo Fondo (como la musica del Menu o Juego)
class Music{
  var property sonidofondo 

  method sonidoFondo() {
    sonidofondo.shouldLoop(true)
    keyboard.down().onPressDo({ sonidofondo.volume(0) }) 
    keyboard.up().onPressDo({sonidofondo.volume(1)})
  }

  method iniciarSonidoFondo(){
    sonidofondo.play()
  }
  method pararSonidoFondo() {
    sonidofondo.stop()
  }
}

object musicaCreditos inherits Music(
  sonidofondo = game.sound("sw.mp3")

){}

object music inherits Music(
  
  sonidofondo = game.sound("fondo.mp3")

){}

object musicaMenu inherits Music(
  sonidofondo = game.sound("Menu.mp3")

){}

//Sonidos simples
object sonido{

  method play(sonido){
    game.sound(sonido).play()
  }

}

///////////////////// IMAGENES VARIAS

//Imagen de la Intro
object imagenPlap{
  method position() = game.origin()
  method image() = "plap.jpeg"
}

//Imagen del Menu
object fondoSelect {
  method image () = "menuSeleccion.jpg"
  method position() = game.at(0,0) 
}

//Imagen al perder
object gameOverImagen {
    method position() = game.origin()
    method image() = "gameOver.jpeg"
  
}

//Imagen al ganar
object winnerImagen {
    method position() = game.origin()
    method image() = "winner.jpeg"
}

//Imagen fondo creditos
object estrellas {
    method position() = game.origin()
    method image() = "estrellas.png"

}

object comicImagen {
    method position() = game.origin()
    method image() = "historieta2.jpg"

}

////////////////CLASE DE IMAGENES QUE SE MUEVEN
class ImagenMovible{
  var property posicion
  var property imagen
  
  method position() = posicion
  
  method image() = imagen
  
  method desplazamiento(){
    const y = (posicion.y()+1)
    posicion = game.at(posicion.x(),y)
		
	}

  method mover(x,y){
    posicion = game.at(x,y)
  }
    
}

//Imagenes movibles
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
