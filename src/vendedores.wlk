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
	
	method esInfluyente()
}

class VendedorFijo inherits Vendedores{
	var property ciudad
	
	override method puedeTrabajarEnCiudad(unaCiudad){
		return ciudad == unaCiudad
	}
	
	override method esInfluyente(){
		return false
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
	
	method poblacionTotalEnProvincias(){
		return provincias.sum({provin => provin.poblacion()})
	}
	
	override method esInfluyente(){
		return  self.poblacionTotalEnProvincias() >= 10000000
	}
	
}

class ComercioCorresponsal inherits Vendedores{
	var property ciudades = #{}
	
	method ponerSucursalesEn(conjuntoDeCiudades){
		ciudades.addAll(conjuntoDeCiudades)
	}
	
	method ponerSucursalEn(unaCiudad){
		ciudades.add(unaCiudad)
	}
	
	override method puedeTrabajarEnCiudad(unaCiudad){
		return ciudades.any({ciudad => ciudad == unaCiudad})
	}
	
	method cantidadCiudades(){
		return ciudades.size()
	}
	
	method cantidadProvinciasConSucursal(){
		const provincias = #{}
		provincias.addAll(ciudades.map({ciudad => ciudad.provincia()}))
		return provincias.size()
	}
	
	override method esInfluyente(){
		return self.cantidadCiudades() >= 5 or 
		self.cantidadProvinciasConSucursal() >= 3
	}
}
