//
//  FormEditarProductoView.swift
//  T2_DAMII
//
//  Created by DAMII on 10/12/24.
//

import SwiftUI

struct FormEditarProductoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var producto: Producto
    @State private var nombre: String = ""
    @State private var categoria: String = ""
    @State private var precio: Double = 0.0
    @State private var stock: Int16 = 0
    @Binding var mostrar: Bool
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre", text: $nombre)
                TextField("Categoría", text: $categoria)
                TextField("Precio", value: $precio, formatter: formatter)
                TextField("Stock", value: $stock, formatter: NumberFormatter())
                Button("Guardar") {
                    guardarProducto()
                    mostrar = false
                }
                .disabled(
                    nombre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                    categoria.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                    precio <= 0 || stock <= 0
                )
            }
            .navigationTitle("Editar Producto")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        mostrar = false
                    }
                }
            }
            .onAppear {
                nombre = producto.nombre ?? ""
                categoria = producto.categoria ?? ""
                precio = producto.precio
                stock = producto.stock
            }
        }
    }
    
    private func guardarProducto() {
        producto.nombre = nombre
        producto.categoria = categoria
        producto.precio = precio
        producto.stock = stock
        try? viewContext.save()
    }
}
