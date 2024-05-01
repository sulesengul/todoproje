//
//  ContentView.swift
//  kategoriSayfası
//
//  Created by Şule Şengül on 30.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var isEditing = false
    @State private var isDailyViewActive = false // Günlük kategorisi tıklanıldığında sayfanın aktif olup olmadığını kontrol etmek için bir durum ekledik
    @State private var isShoppingActive = false // Alışveriş kategorisi tıklanıldığında sayfanın aktif olup olmadığını kontrol etmek için bir durum ekledik
    @State private var isImportantActive = false // Önemli kategorisi tıklanıldığında sayfanın aktif olup olmadığını kontrol etmek için bir durum ekledik
    
    var body: some View {
        NavigationView { // NavigationView ekliyoruz
            TabView {
                VStack {
                    SearchBar(text: $searchText, isEditing: $isEditing)
                        .padding()
                        .frame(maxWidth: .infinity)
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isDailyViewActive = true // Günlük kategorisi tıklanıldığında isDailyViewActive'yi true yaparak DailyView'i aktif ediyoruz
                        }) {
                            CategoryView(imageName: "pencil", categoryName: "Günlük", backgroundColor: Color.yellow)
                        }
                        .foregroundColor(.black)
                        Spacer()
                        Button(action: {
                            // Anımsatıcı kategorisine tıklandığında yapılacak işlemler
                        }) {
                            CategoryView(imageName: "calendar", categoryName: "Anımsatıcı", backgroundColor: Color.blue)
                        }
                        .foregroundColor(.black)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isShoppingActive = true // Alışveriş kategorisi tıklanıldığında isShoppingActive'yi true yaparak AlisverisView'i aktif ediyoruz
                        }) {
                            CategoryView(imageName: "cart", categoryName: "Alışveriş", backgroundColor: Color(hex: "6666FF"))
                        }
                        .foregroundColor(.black)
                        Spacer()
                        Button(action: {
                            isImportantActive = true // Önemli kategorisi tıklanıldığında isImportantActive'yi true yaparak OnemliView'i aktif ediyoruz
                        }) {
                            CategoryView(imageName: "star", categoryName: "Önemli", backgroundColor: Color.red)
                        }
                        .foregroundColor(.black)
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Anasayfa")
                }
                
                Text("Profil İçeriği")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profil")
                    }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .fullScreenCover(isPresented: $isDailyViewActive) { // Günlük kategorisi tıklanıldığında DailyView'i açıyoruz
                NavigationView {
                    GunlukView()
                        .navigationBarTitle("", displayMode: .inline) // Geri yazısını gösteriyoruz
                        .navigationBarBackButtonHidden(true) // Geri tuşunu gizliyoruz
                        .navigationBarItems(leading: Button(action: {
                            isDailyViewActive = false // Geri butonuna basıldığında GunlukView'i kapatıyoruz
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                        })
                }
            }
            .fullScreenCover(isPresented: $isShoppingActive) { // Alışveriş kategorisi tıklanıldığında AlisverisView'i açıyoruz
                NavigationView {
                    AlisverisView()
                        .navigationBarTitle("", displayMode: .inline) // Geri yazısını gösteriyoruz
                        .navigationBarBackButtonHidden(true) // Geri tuşunu gizliyoruz
                        .navigationBarItems(leading: Button(action: {
                            isShoppingActive = false // Geri butonuna basıldığında AlisverisView'i kapatıyoruz
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                        })
                }
            }
            .fullScreenCover(isPresented: $isImportantActive) { // Önemli kategorisi tıklanıldığında OnemliView'i açıyoruz
                NavigationView {
                    OnemliView()
                        .navigationBarTitle("", displayMode: .inline) // Geri yazısını gösteriyoruz
                        .navigationBarBackButtonHidden(true) // Geri tuşunu gizliyoruz
                        .navigationBarItems(leading: Button(action: {
                            isImportantActive = false // Geri butonuna basıldığında OnemliView'i kapatıyoruz
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                        })
                }
            }
        }
        .navigationBarHidden(true) // Navigation bar'ı gizliyoruz
    }
}

struct CategoryView: View {
    var imageName: String
    var categoryName: String
    var backgroundColor: Color
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding()
                .background(backgroundColor)
                .cornerRadius(10)
            Text(categoryName)
                .font(.caption)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 8)
                .foregroundColor(.gray)
            
            TextField("Ara...", text: $text, onEditingChanged: { editing in
                self.isEditing = editing
            })
            .padding(7)
            .padding(.horizontal, 8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 4)
            .onTapGesture {
                // TextField tıklandığında işlem yapılabilir.
            }
            
            Button(action: {
                // Mikrofon simgesine tıklama işlemi
            }) {
                Image(systemName: "mic.fill")
                    .padding(.trailing, 8)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0

        scanner.scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
