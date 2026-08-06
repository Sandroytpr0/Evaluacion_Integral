
import Foundation
import Combine

@MainActor
class ShopViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var favorites: [Product] = []
    @Published var cart: [Product] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    
    private let repository: ProductRepository
    
    // Se inyecta el repositorio (protocolo de Domain) en vez del servicio de red
    // directamente, para respetar Clean Architecture y poder testear con un mock.
    init(repository: ProductRepository = ProductRepositoryImpl()) {
        self.repository = repository
    }
    
    func fetchProducts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            self.products = try await repository.getProducts()
        } catch {
            self.errorMessage = "No se pudieron cargar los productos: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    // Funciones de Favoritos
    func toggleFavorite(_ product: Product) {
        if let index = favorites.firstIndex(where: { $0.id == product.id }) {
            favorites.remove(at: index)
        } else {
            favorites.append(product)
        }
    }
    
    func isFavorite(_ product: Product) -> Bool {
        return favorites.contains(where: { $0.id == product.id })
    }
    
    // Funciones de Carrito
    func addToCart(_ product: Product) {
        cart.append(product)
    }
    
    func removeFromCart(_ product: Product) {
        cart.removeAll { $0.id == product.id }
    }
    
    var cartTotal: Double {
        cart.reduce(0) { $0 + $1.price }
    }
}
