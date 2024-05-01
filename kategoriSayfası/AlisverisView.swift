//
//  AlisverisView.swift
//  kategoriSayfası
//
//  Created by Şule Şengül on 1.05.2024.
//

import SwiftUI

struct AlisverisView: View {
    @State private var alisverisListesi: [String] = [""]
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    let tarih = Date()

    var body: some View {
        NavigationView {
            VStack (spacing: 0){
                Text("\(tarih, formatter: dateFormatter)")
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .font(.headline)
                
                ForEach(alisverisListesi.indices, id: \.self) { index in
                    TextField("Alışveriş Listesi", text: $alisverisListesi[index])
                        .padding(.horizontal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .navigationBarTitle("Alışveriş Listesi", displayMode: .inline)
                }
                
                Spacer()
            }
            .navigationBarTitle("Alışveriş Listesi")
            .navigationBarItems(trailing:
                Button(action: {
                    alisverisListesi.append("")
                }) {
                    Image(systemName: "plus")
                        .padding()
                }
            )
        }
    }
}

struct AlisverisView_Previews: PreviewProvider {
    static var previews: some View {
        AlisverisView()
    }
}
