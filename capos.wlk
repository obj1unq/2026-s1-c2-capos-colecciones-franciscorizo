object rolando {
    var estaEnCastillo = true
    const artefactosEnMochila = #{}

 method encontrarArtefacto(artefacto) //guardar en la mochila si puede
  {
   
 }
 method artefactos()// getter
  {
   return
 }
 method capacidadMaxima() // setter
  {
   
 }
 method verificarMochila() // devuelve true si tamaño de artefactos es menor a capMax
 {
   return 
 }
 method estaEnCastillo() {
    return estaEnCastillo
 } 
 method llegoACastillo() {
    // Verificar que rolando está en el castillo.
    if(self.estaEnCastillo()){
        // Dejo los artefactos en el castillo.
        castillo.agregar(artefactosEnMochila)
    }
 } 
}







object castillo {
    const artefactos = #{}

    method agregar(artefactosNuevos) {
        var artefactosLista = artefactosNuevos.asList()
        artefactos nuevos los paso a una lista 
        recorro la lista agregando cada artefacto al conjunto del castillo 

    }
}


