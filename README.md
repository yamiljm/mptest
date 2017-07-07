# Algunas consideraciones:
- La versión entregada está en el branch _master_ (o el tag 1.0.0)
- Desarrollado en Xcode 8.3.3
- Fue probado en iOS 10.3
- Para el manejo de librerías se usa Cocoa pods. La librerías utilizadas son dos: 
  * Gloss: resuelve el mapeo de json a objetos del modelo. En el futuro, cuando salgo Swift 4, podrá ser reemplazado Codeable. 
  * Nuke: Para cargar las imágenes de las tarjetas asincrónicamente. 

# Cosas que quedaron pendientes: 
- Manejo de errores: para mostrar mensajes claros al usuario, para resolver alguna situación y manejos de errores http para conocer el estado de los request. 
- Internacionalización. Los textos deberían ser internacionalizados para mostrarlos en el lenguaje del usuario. 
- Cancelar que se muestre una pantalla  que se está cargando si el usuario vuelve para atrás en el navigation controller. 
- El formato de la moneda se toma del locale definido por el usuario en el device / simulador. En este último se puede cambiar en las propiedades del Scheme.
- Se consideró como regla de negocio que si la lista de issuers para un payment method seleccionado es vacía, se muestra directamente la pantalla para seleccionar la cuotas.
- Tests unitarios
