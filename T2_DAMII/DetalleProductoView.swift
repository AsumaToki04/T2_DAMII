//
//  DetalleProductoView.swift
//  T2_DAMII
//
//  Created by DAMII on 10/12/24.
//

import SwiftUI

struct DetalleProductoView: View {
    @ObservedObject var producto: Producto
    @State private var mostrarFormulario = false
    
    var body: some View {
        VStack {
            List {
                Text("INFORMACIÓN DEL PRODUCTO")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .listRowBackground(Color.clear)
                Text("Nombre: \(producto.nombre ?? "Sin nombre")")
                    .font(.headline)
                Text("Categoría: \(producto.categoria ?? "Sin categoría")")
                    .font(.headline)
                Text("Precio: $\(producto.precio, specifier: "%.2f")")
                    .font(.headline)
                Text("Stock: \(producto.stock)")
                    .font(.headline)
            }
        }
        .navigationTitle(producto.nombre ?? "Sin nombre")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    mostrarFormulario = true
                }) {
                    Image(systemName: "pencil")
                }
            }
        }
        .sheet(isPresented: $mostrarFormulario) {
            FormEditarProductoView(producto: producto, mostrar: $mostrarFormulario)
        }
    }
}
