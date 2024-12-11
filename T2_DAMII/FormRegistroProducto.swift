//
//  FormRegistroProducto.swift
//  T2_DAMII
//
//  Created by DAMII on 10/12/24.
//

import SwiftUI

struct FormRegistroProducto: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var mostrar: Bool
    @State private var nombre: String = ""
    @State private var categoria: String = ""
    @State private var precio: Double = 0.0
    @State private var stock: Int16 = 0
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
            .navigationTitle("Registro de Producto")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        mostrar = false
                    }
                }
            }
        }
    }
    
    private func guardarProducto() {
        let nuevo = Producto(context: viewContext)
        nuevo.nombre = nombre.trimmingCharacters(in: .whitespacesAndNewlines)
        nuevo.categoria = categoria.trimmingCharacters(in: .whitespacesAndNewlines)
        nuevo.precio = precio
        nuevo.stock = stock
        try? viewContext.save()
    }
}
