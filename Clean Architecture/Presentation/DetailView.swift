import SwiftUI

struct DetailView: View {
    let product: Product
    @ObservedObject var viewModel: ShopViewModel
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 16) {
                
                AsyncImage(url: URL(string: product.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 250)
                .frame(maxWidth: .infinity)
                
                
                Text(product.brand)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                
                Text(product.name)
                    .font(.title)
                    .bold()
                
                
                HStack {
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Label(
                        "\(product.rating, specifier: "%.1f")",
                        systemImage: "star.fill"
                    )
                    .foregroundColor(.yellow)
                }
                
                
                if let description = product.description {
                    Text("Descripción")
                        .font(.headline)
                    
                    Text(description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                
                HStack(spacing: 16) {
                    
                    Button(action: {
                        viewModel.toggleFavorite(product)
                    }) {
                        Label(
                            viewModel.isFavorite(product)
                            ? "Quitar de Favoritos"
                            : "Agregar a Favoritos",
                            
                            systemImage:
                                viewModel.isFavorite(product)
                            ? "heart.fill"
                            : "heart"
                        )
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                    
                    
                    Button(action: {
                        viewModel.addToCart(product)
                    }) {
                        Label(
                            "Agregar al Carrito",
                            systemImage: "cart.badge.plus"
                        )
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Detalle")
    }
}
