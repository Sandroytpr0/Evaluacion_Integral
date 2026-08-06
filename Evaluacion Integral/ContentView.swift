//
//  ContentView.swift
//  Evaluacion Integral
//
//  Created by user293938 on 7/25/26.
//

import SwiftUI

struct ContentView: View {
    // Creamos la ÚNICA fuente de verdad para toda la app
    @StateObject private var viewModel = ShopViewModel()
    
    var body: some View {
        TabView {
            HomeView(viewModel: viewModel)
                .tabItem {
                    Label("Inicio", systemImage: "house.fill")
                }
            
            FavoritesView(viewModel: viewModel)
                .tabItem {
                    Label("Favoritos", systemImage: "heart.fill")
                }
            
            CartView(viewModel: viewModel)
                .tabItem {
                    Label("Carrito", systemImage: "cart.fill")
                }
        }
        // Evita que los íconos se vean grises en algunas versiones de iOS
        .tint(.blue)
    }
}
