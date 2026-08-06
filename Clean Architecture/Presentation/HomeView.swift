import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = ShopViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                // Banner (Solo visual)
                ZStack(alignment: .bottomLeading) {
                    Color.blue.opacity(0.8)
                        .frame(height: 160)
                        .cornerRadius(12)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("¡Lo Nuevo!")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Zapatillas exclusivas disponibles")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding()
                }
                .padding()
                
                
                // Grilla de productos
                if viewModel.isLoading {
                    ProgressView("Cargando zapatillas...")
                        .padding()
                    
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                    
                } else {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        
                        ForEach(viewModel.products) { product in
                            NavigationLink(destination: DetailView(product: product, viewModel: viewModel)) {
                                
                                ProductCard(
                                    product: product,
                                    viewModel: viewModel
                                )
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("SneakerStore")
            .task {
                await viewModel.fetchProducts()
            }
        }
    }
}


struct ProductCard: View {
    let product: Product
    @ObservedObject var viewModel: ShopViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 120)
            .cornerRadius(8)
            
            
            Text(product.brand)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(product.name)
                .font(.subheadline)
                .bold()
                .lineLimit(1)
            
            
            HStack {
                Text("$\(product.price, specifier: "%.2f")")
                    .bold()
                    .foregroundColor(.blue)
                
                Spacer()
                
                Label(
                    "\(product.rating, specifier: "%.1f")",
                    systemImage: "star.fill"
                )
                .font(.caption)
                .foregroundColor(.yellow)
            }
            
            
            Button(action: {
                viewModel.toggleFavorite(product)
            }) {
                Image(systemName:
                        viewModel.isFavorite(product)
                      ? "heart.fill"
                      : "heart")
                .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
