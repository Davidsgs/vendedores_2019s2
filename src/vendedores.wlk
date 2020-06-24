class Certificado {
	var property cantidadPuntos
	var property esSobreProductos
}

class Vendedores {
	const property certificaciones = []
	
	method darCertificado(unCertificado){
		certificaciones.add(unCertificado)
	}
	
	method puedeTrabajarEnCiudad(unaCiudad)
	
	method tieneCertificadoQueNoEsSobreProductos(){
		return certificaciones.any({certificado => not certificado.esSobreProductos()})
	}
	
	method tieneCertificadoSobreProductos(){
		return certificaciones.any({certificado => certificado.esSobreProductos()})
	}
	
	method esVersatil(){
		return certificaciones.size() >= 3 and
		self.tieneCertificadoSobreProductos() and
		self.tieneCertificadoQueNoEsSobreProductos()
	}
	
	method puntosDeCertificados(){
		return certificaciones.sum({certificacion => certificacion.cantidadPuntos()})
	}
	
	method esFirme(){
		return self.puntosDeCertificados() >= 30
	}
}

class VendedorFijo inherits Vendedores{
	var property ciudad
	
	override method puedeTrabajarEnCiudad(unaCiudad){
		return ciudad == unaCiudad
	}
}

class VendedorViajante inherits Vendedores{
	const property provincias = #{}
	
	method habilitarEnProvincia(unaProvincia){
		provincias.add(unaProvincia)
	}
	
	method deshabilitarEnProvincia(unaProvincia){
		provincias.remove(unaProvincia)
	}
	
	override method puedeTrabajarEnCiudad(unaCiudad){
		return provincias.any({prov => prov == unaCiudad.provincia()})
	}
}

class ComercioCorresponsal inherits Vendedores{
	var property ciudades = #{}
	
	method ponerSucursalEn(unaCiudad){
		ciudades.add(unaCiudad)
	}
	
	override method puedeTrabajarEnCiudad(unaCiudad){
		return ciudades.any({ciudad => ciudad == unaCiudad})
	}
}
