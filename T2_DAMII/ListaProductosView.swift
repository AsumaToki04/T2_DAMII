//
//  ListaProductosView.swift
//  T2_DAMII
//
//  Created by DAMII on 10/12/24.
//

import SwiftUI

struct ListaProductosView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Producto.nombre, ascending: true)],
        animation: .default
    ) private var productos: FetchedResults<Producto>
    @State private var mostrarFormulario = false
    @State private var productoDelete: Producto?
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(productos) { item in
                        NavigationLink(destination: DetalleProductoView(producto: item)) {
                            VStack(alignment: .leading) {
                                Text(item.nombre ?? "Sin nombre")
                                    .font(.headline)
                                Text("Categoría: \(item.categoria ?? "Sin categoría")")
                                    .font(.subheadline)
                                Text("Precio: $\(item.precio, specifier: "%.2f")")
                                    .font(.subheadline)
                                Text("Stock: \(item.stock)")
                                    .font(.subheadline)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    productoDelete = item
                                } label: {
                                    Label("", systemImage: "trash")
                                }
                            }
                            .alert(item: $productoDelete) { producto in
                                Alert(
                                    title: Text("Eliminar \(producto.nombre ?? "Sin nombre")?"),
                                    message: Text("Esta acción no se puede deshacer"),
                                    primaryButton: .destructive(Text("Eliminar")) {
                                        viewContext.delete(producto)
                                        try? viewContext.save()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                        }
                    }
                }
            }
            .navigationTitle("Productos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        mostrarFormulario = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $mostrarFormulario) {
                FormRegistroProducto(mostrar: $mostrarFormulario)
            }
        }
    }
}
