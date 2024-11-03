import Enemigos.*
import wollok.game.*
import Config.*
import Objetos.*
import intro.*
import Mapas.*
import Niveles.*
//-------------------   PICKLE RICK -------------------

class Personajes {
  
  var posicion
  var property imageRick = imagenFrente1 // Imagen0 de Rick

  method image () = imageRick 
  method position() = posicion

  var property imagenFrente1
  var property imagenFrente2 
  var property imagenDerecha1 
  var property imagenDerecha2 
  var property imagenIzquierda1 
  var property imagenIzquierda2
  var property imagenEspalda1
  var property imagenEspalda2
  var property paso

  method derecha() {
    if(self.position().x() < (game.width() - 1)){
      sonido.play(paso)
      imageRick = imagenDerecha2
      posicion = posicion.right(0.5)
      game.schedule(200, {imageRick = imagenDerecha1})
      posicion = posicion.right(0.5)
    }  
  }

  method izquierda() {
    if(self.position().x() > 0){
      sonido.play(paso)
      imageRick = imagenIzquierda2
      posicion = posicion.left(0.5)
      game.schedule(200, {imageRick = imagenIzquierda1})
      posicion = posicion.left(0.5)
    }  
  }

  method arriba() {
    if(self.position().y() < (game.height() - 2)){
      sonido.play(paso)
      imageRick = imagenEspalda2
      posicion = posicion.up(0.5)
      game.schedule(200, {imageRick = imagenEspalda1})
      posicion = posicion.up(0.5)
    }  
  }

  method abajo() {
    if(self.position().y() > 0){
      sonido.play(paso)
      imageRick = imagenFrente2
      posicion = posicion.down(0.5)
      game.schedule(200, {imageRick = imagenFrente1})
      posicion = posicion.down(0.5)
    }  
  }
}

object rickPosta inherits Personajes(

  posicion = game.at(1,2), // posicion inicial de Rick

  imagenFrente1 = "rickPostafrente1.png",
  imagenFrente2 = "rickPostafrente2.png",
  imagenDerecha1 = "rickPostaderecha1.png",
  imagenDerecha2 = "rickPostaderecha2.png",
  imagenIzquierda1 = "rickPostaizquierda1.png",
  imagenIzquierda2 = "rickPostaizquierda2.png",
  imagenEspalda1 = "rickPostaespalda1.png",
  imagenEspalda2 = "rickPostaespalda2.png",
  paso = "vacio")
  {

method seleccionador(objeto){//CAMBIAR NOMBRE A QUE AGARRAMOS
    if (selectMenu.mensajes().contains(objeto)){
      objeto.siguiente()
    }
  }
}

object rick inherits Personajes(
  
  posicion = game.at(5,5), // posicion inicial de Rick

  imagenFrente1 = "rickfrente1.png",
  imagenFrente2 = "rickfrente2.png",
  imagenDerecha1 = "rickderecha1.png",
  imagenDerecha2 = "rickderecha2.png",
  imagenIzquierda1 = "rickizquierda1.png",
  imagenIzquierda2 = "rickizquierda2.png",
  imagenEspalda1 = "rickespalda1.png",
  imagenEspalda2 = "rickespalda2.png",
  paso = "pasos3.mp3") 
  {

  const property objetos = [] // Lista de objetos agarrados
  const property lasers = []
  
  var property vida = 100 // vida inicial de rick

/////////Cosas de Nahue
  method reiniciarVida(){
    vida = 50
  }

  method reiniciarPosicion(){
    posicion = game.at(5,5)
    imageRick = "rickfrente1.png"
  }
  
  method soltarObjetos(){
    objetos.clear()
    lasers.clear()
  }
////////////
  method vidaRestar(x) {
    self.vida()-x.poder()
  }//Se le resta a la vida el poder del personaje que lo ataque
    //agregar transicion de colores en vida y barra pero en config

  method esPortal(objeto){//CAMBIAR NOMBRE A QUE AGARRAMOS
    if (objeto.className() == "Objetos.Portales"){
      //objeto.mapa()
      mapaRandom.elegirMapa()
    } else {self.agarrar(objeto)}
  }
  
  method agarrar(objeto) {
    objetos.add(objeto)
		objeto.agarrado(objeto)
    
  }

/////////Cosas de Gonza  
  var property puntos = 0
  
  method puntos(matasteA) {
    puntos = puntos + matasteA
  }
  var _enemigo = 0
  
  var atacadoTick = new Tick (interval = 500, action = {self.restarVida()})
 
  method runAtacadoTick(enemigo) {atacadoTick.start() _enemigo = enemigo}
  method endAtacadoTick() {atacadoTick.stop()}
 
  method restarVida() {
    vida -= _enemigo.poder()   
    self.endAtacadoTick()

    if (vida<=0){vida=100}// cambiar por el metodo gameOver(nahue)
  }
//////////////

  // Llamada de los metodos anteriores para consulta de balas en pistola.
  // Si se cumple la primer condi generamos un nuevo laser
  // Si ya completamos el arma solo usa las mismas balas siempre (3)

  method disparar(){
    
      if (config.tenemosPistolaYnoLlena(self)){
        new Lasers(
          posicion = self.position(),
          imagenFrente1 = "rickfrente1.png",
          imagenFrente2 = "rickfrente2.png",
          imagenDerecha1 = "rickderecha1.png",
          imagenDerecha2 = "rickderecha2.png",
          imagenIzquierda1 = "rickizquierda1.png",
          imagenIzquierda2 = "rickizquierda2.png",
          imagenEspalda1 = "rickespalda1.png",
          imagenEspalda2 = "rickespalda2.png"
        ).disparar(self)
        //idLaser += 1
      }else {
        config.tenemosPistolaCompleta(self)}
    }



}
