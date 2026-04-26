object rolando {
    var powerBase = 5
    var capacidadMaxima = 2
    var artefactosEnMochila = #{}
    var historialEncuentros = []
    
    method encontrarArtefacto(artefacto) {
        historialEncuentros.add(artefacto)
        if (self.puedeCargar()) {
            artefactosEnMochila.add(artefacto)
        }
    }
    
    method artefactos() {
        return artefactosEnMochila
    }
    
    method configurarCapacidad(nuevaCapacidad) {
        capacidadMaxima = nuevaCapacidad
    }
    
    method puedeCargar() {
        return artefactosEnMochila.size() < capacidadMaxima
    }
    
    method llegoAlCastillo() {
        castillo.recibirArtefactos(artefactosEnMochila)
        artefactosEnMochila = #{}
    }
    
    method posesiones() {
        var todasLasPosesiones = artefactosEnMochila.copy()
        todasLasPosesiones.addAll(castillo.artefactos())
        return todasLasPosesiones
    }
    
    method posee(artefacto) {
        return self.posesiones().contains(artefacto)
    }
    
    method historialDeEncuentros() {
        return historialEncuentros
    }
    
    method configurarPowerBase(nuevoPower) {
        powerBase = nuevoPower
    }
    
    method powerDePelea() {
        var powerTotal = powerBase
        artefactosEnMochila.forEach { artefacto =>
            powerTotal += artefacto.powerPara(self)
        }
        return powerTotal
    }
    
    method lucharBatalla() {
        artefactosEnMochila.forEach { artefacto =>
            artefacto.usarEnBatalla()
        }
        powerBase += 1
    }
    
    method enemigosAVencer() {
        return #{ caterina, archibaldo, astra }.filter { enemigo =>
            self.powerDePelea() > enemigo.powerDePelea()
        }
    }
    
    method moradasConquistables() {
        return self.enemigosAVencer().map { enemigo =>
            enemigo.morada()
        }
    }
    
    method esPoderoso() {
        return #{ caterina, archibaldo, astra }.all { enemigo =>
            self.powerDePelea() > enemigo.powerDePelia()
        }
    }
    
    method tieneArtefactoFatal(enemigo) {
        return artefactosEnMochila.any { artefacto =>
            artefacto.esArtefactoFatalPara(self, enemigo)
        }
    }
    
    method obtenerArtefactoFatal(enemigo) {
        return artefactosEnMochila.find { artefacto =>
            artefacto.esArtefactoFatalPara(self, enemigo)
        }
    }
}

object castillo {
    var artefactosGuardados = #{}
    
    method recibirArtefactos(artefactos) {
        artefactosGuardados.addAll(artefactos)
    }
    
    method artefactos() {
        return artefactosGuardados
    }
}

object espadaDelDestino {
    var vecesUsada = 0
    
    method powerPara(personaje) {
        if (vecesUsada == 0) {
            return personaje.powerBase()
        } else {
            return personaje.powerBase() / 2
        }
    }
    
    method usarEnBatalla() {
        vecesUsada += 1
    }
    
    method esArtefactoFatalPara(rolando, enemigo) {
        return rolando.powerDePelea() - this.powerPara(rolando) + this.powerPara(rolando) > enemigo.powerDePelea()
    }
}

object collarDivino {
    var usosEnBatalla = 0
    
    method powerPara(personaje) {
        var power = 3
        if (personaje.powerBase() > 6) {
            power += usosEnBatalla
        }
        return power
    }
    
    method usarEnBatalla() {
        usosEnBatalla += 1
    }
    
    method esArtefactoFatalPara(rolando, enemigo) {
        return rolando.powerDePelea() - this.powerPara(rolando) + this.powerPara(rolando) > enemigo.powerDePelea()
    }
}

object armaduraDeAceroValyrio {
    method powerPara(personaje) {
        return 6
    }
    
    method usarEnBatalla() {
    }
    
    method esArtefactoFatalPara(rolando, enemigo) {
        return rolando.powerDePelea() - this.powerPara(rolando) + this.powerPara(rolando) > enemigo.powerDePelea()
    }
}

object libroDeHechizos {
    var hechizos = []
    var hechizosUsados = []
    
    method configurarHechizos(nuevosHechizos) {
        hechizos = nuevosHechizos
    }
    
    method powerPara(personaje) {
        if (hechizos.isEmpty()) {
            return 0
        }
        return hechizos.first().powerPara(personaje)
    }
    
    method usarEnBatalla() {
        if (!hechizos.isEmpty()) {
            hechizosUsados.add(hechizos.first())
            hechizos.remove(hechizos.first())
        }
    }
    
    method esArtefactoFatalPara(rolando, enemigo) {
        return rolando.powerDePelea() > enemigo.powerDePelea()
    }
}

object bendicion {
    method powerPara(personaje) {
        return 4
    }
}

object invisibilidad {
    method powerPara(personaje) {
        return personaje.powerBase()
    }
}

object invocacion {
    method powerPara(personaje) {
        if (castillo.artefactos().isEmpty()) {
            return 0
        }
        return castillo.artefactos().max { artefacto =>
            artefacto.powerPara(personaje)
        }.powerPara(personaje)
    }
}

object caterina {
    method powerDePelea() {
        return 28
    }
    
    method morada() {
        return "Fortaleza de acero"
    }
}

object archibaldo {
    method powerDePelea() {
        return 16
    }
    
    method morada() {
        return "Palacio de mármol"
    }
}

object astra {
    method powerDePelea() {
        return 14
    }
    
    method morada() {
        return "Torre de marfil"
    }
}
