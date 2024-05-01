//
//  GunlukView.swift
//  kategoriSayfası
//
//  Created by Şule Şengül on 1.05.2024.
//

import SwiftUI

// Günlük veri modeli
struct DiaryEntry: Identifiable {
    let id = UUID()
    var text: String
    var date: Date
}

// Günlük veri modeli için örnek veri
let sampleEntries: [DiaryEntry] = [
    DiaryEntry(text: "Swift çalıştım.", date: Date()),
    ]

struct GunlukView: View {
    @State private var newEntryText = "" // Yeni giriş metni için bir durum
    @State private var diaryEntries = sampleEntries // Günlük girişlerini saklamak için bir durum

    var body: some View {
        ScrollView {
            VStack {
                Text("Günlük Anılar").font(.title).padding()

                // Günlük girişlerini listelemek için ForEach döngüsü
                ForEach(diaryEntries) { entry in
                    VStack(alignment: .leading) {
                        Text(entry.text).padding(.bottom)
                        Divider() // Her giriş arasına bir ayırıcı ekleyelim
                    }.padding()
                }

                // Yeni giriş eklemek için metin alanı ve buton
                VStack {
                    TextField("Günlük girişinizi buraya yazın", text: $newEntryText).padding()
                    Button(action: addEntry) {
                        Text("Kaydet").padding().background(Color.blue).foregroundColor(.white).cornerRadius(8)
                    }
                }.padding()
            }
        }
    }

    // Yeni girişi eklemek için fonksiyon
    func addEntry() {
        if !newEntryText.isEmpty {
            let newEntry = DiaryEntry(text: newEntryText, date: Date())
            diaryEntries.insert(newEntry, at: 0) // Yeni girişi en üstte göstermek için
            newEntryText = "" // Metin alanını temizle
        }
    }
}

struct GunlukView_Previews: PreviewProvider {
    static var previews: some View {
        GunlukView()
    }
}

