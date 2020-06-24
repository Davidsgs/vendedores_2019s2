class Centros {
	var property ciudad
	const property vendedores = []
	
	method agregarVendedor(unVendedor){
		if(not vendedores.contains(unVendedor)){
			vendedores.add(unVendedor)
		}else{
			self.error("El Vendedor ya se encuentra trabajando con este centro.")
		}
	}
	
}
