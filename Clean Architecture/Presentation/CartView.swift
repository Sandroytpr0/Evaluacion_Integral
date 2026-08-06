//
//  CartView.swift
//  Evaluacion Integral
//
//  Created by user293938 on 7/25/26.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: ShopViewModel
    @State private var showDeleteAlert = false
    @State private var productToDelete: Product? = nil

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.cart) { product in
                        HStack {
                            AsyncImage(url: URL(string: product.image)) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            .cornerRadius(6)

                            VStack(alignment: .leading) {
                                Text(product.name).bold()
                                Text("$\(product.price, specifier: "%.2f")").foregroundColor(.blue)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                productToDelete = product
                                showDeleteAlert = true
                            } label: {
                                Label("Eliminar", systemImage: "trash")
                            }
                        }
                    }
                }

                VStack(spacing: 12) {
                    HStack {
                        Text("Total:").font(.title2).bold()
                        Spacer()
                        Text("$\(viewModel.cartTotal, specifier: "%.2f")").font(.title2).bold().foregroundColor(.blue)
                    }

                    Button(action: {}) {
                        Text("Pagar ahora")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle("Carrito de Compras")
            .alert("Confirmar Eliminación", isPresented: $showDeleteAlert, presenting: productToDelete) { product in
                Button("Sí, eliminar", role: .destructive) {
                    viewModel.removeFromCart(product)
                }
                Button("Cancelar", role: .cancel) {}
            } message: { product in
                Text("¿Deseas eliminar \(product.name) del carrito?")
            }
        }
    }
}
