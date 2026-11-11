
 iOS Shopping App — SwiftUI

Aplicación de tienda virtual para iOS desarrollada con Swift y SwiftUI, utilizando gestión de estado reactiva y una estructura orientada a Clean Architecture.

Descripción

Proyecto académico desarrollado durante mi formación en Ingeniería de Software en ISIL.

La aplicación permite consultar un catálogo de productos, administrar favoritos y gestionar un carrito de compras mediante una interfaz nativa para iOS.

 Funcionalidades

- Visualización de productos.
- Consulta asíncrona del catálogo.
- Agregar y quitar productos favoritos.
- Agregar productos al carrito.
- Eliminar productos del carrito.
- Cálculo automático del total.
- Indicadores de carga.
- Manejo de errores al consultar productos.
- Navegación mediante pestañas.

Tecnologías

- Swift
- SwiftUI
- Combine
- Xcode
- Async/Await
- ObservableObject
- @Published
- @StateObject

 Arquitectura

El proyecto utiliza un enfoque orientado a Clean Architecture.

El ViewModel depende del protocolo ProductRepository,
en lugar de comunicarse directamente con un servicio de red.

Esto permite separar responsabilidades y facilita
el uso de implementaciones simuladas (mocks) en pruebas.

Componentes identificados:

- ContentView: navegación principal.
- HomeView: pantalla de inicio.
- FavoritesView: sección de favoritos.
- CartView: carrito de compras.
- ShopViewModel: estado y lógica de presentación.
- ProductRepository: abstracción de acceso a productos.
- ProductRepositoryImpl: implementación predeterminada.

Gestión del estado

Se utiliza @StateObject para compartir una instancia
de ShopViewModel entre las pantallas principales.

Las propiedades @Published permiten observar cambios
en productos, favoritos, carrito y estados de carga.

Cálculo del carrito

El total se calcula mediante reduce, sumando los precios
de los productos agregados.

Contexto académico

Proyecto desarrollado como parte de mi formación
en desarrollo de aplicaciones móviles para iOS.

 Autor

Sandro Callañaupa Portal

Estudiante de Ingeniería de Software — ISIL

GitHub: https://github.com/Sandroytpr0
