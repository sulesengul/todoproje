//
//  OnemliView.swift
//  kategoriSayfası
//
//  Created by Şule Şengül on 1.05.2024.
//

import SwiftUI

struct OnemliView: View {
    @State private var onemli: [String] = [""]
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
                
                ForEach(onemli.indices, id: \.self) { index in
                    TextField("Önemli", text: $onemli[index])
                        .padding(.horizontal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                
                Spacer()
            }
            .navigationBarTitle("Önemli", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    onemli.append("")
                }) {
                    Image(systemName: "plus")
                        .padding()
                }
            )
        }
    }
}

struct OnemliView_Previews: PreviewProvider {
    static var previews: some View {
        OnemliView()
    }
}
