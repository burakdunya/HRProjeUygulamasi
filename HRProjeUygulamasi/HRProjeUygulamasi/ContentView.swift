//
//  ContentView.swift
//  HRProjeUygulamasi
//
//  Created by Burak DÜNYA on 28.12.2024.
//

import SwiftUI
import CoreData

struct SignupView: View {
    @State var adnameText: String = ""
    @State var soyadnameText: String = ""
    @State var mailnameText: String = ""
    @State var passwordText: String = ""
    @State var isNavigation : Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
       
    //private var users : FetchedResults<Kullanicilar>



  
    
    var body: some View {
        NavigationStack{
            VStack {
                Text ("YSOFT Signup")
                Spacer()
                TextField("Ad", text: $adnameText).padding()
                TextField("Soyad", text: $soyadnameText).padding()
                TextField("Mail", text: $mailnameText).padding()
                TextField("Password", text: $passwordText).padding()
               
                
                Button {
                    if adnameText.isEmpty || soyadnameText.isEmpty || mailnameText.isEmpty || passwordText.isEmpty {
                        isNavigation = false
                    }
                    else{
                        let kullaniciObject = Kullanicilar(context: viewContext)
                        kullaniciObject.adnameText = adnameText
                        kullaniciObject.soyadnameText = soyadnameText
                        kullaniciObject.passwordText = passwordText
                        kullaniciObject.mailnameText = mailnameText
                        do {
                            
                          try viewContext.save()
                        }
                        catch{
                            print(error.localizedDescription)
                        
                            print("error while saving kullanicilar ")
                        }
                        isNavigation = true
                    }
                } label: {
                    Text("Signup")
                }.navigationDestination(isPresented: $isNavigation) {
                    HomeView().environment(\.managedObjectContext, viewContext)
                }
                NavigationLink {
                    LoginView()
                } label: {
                    Text("Alredy have an account? Login")
                }

                Spacer()
            
            }
        }
    }
    
}

struct HomeView : View {
     @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: []
        ) private var users : FetchedResults<Kullanicilar>
    var body: some View {
            VStack {
                NavigationLink {
                    AddEmployeeView()
                } label: {
                    Text("Çalışan Ekle")
                }

                NavigationLink {
                    ShowEmployeeView()
                } label: {
                    Text("Çalışan listele")
                }

            }
            .padding()
        }
}
struct ShowEmployeeView : View {
     @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: []
        ) private var users : FetchedResults<Calisanlar>
   
    @State private var searchText = ""
    var filteredUsers: [Calisanlar] {
           if searchText.isEmpty {
               return Array(users) // Arama metni boşsa, tüm verileri döndür
           } else {
               // Arama metnine göre filtrele
               return users.filter { user in
                   let departman = user.departman ?? ""
                   return departman.lowercased().contains(searchText.lowercased())
                       
               }
           }
       }
    
    var body: some View {
        List {
                    // Eğer veri yoksa gösterilecek metin
                    if users.isEmpty {
                        Text("Henüz kullanıcı bulunmuyor.")
                            .padding()
                    } else {
                        // Kullanıcı bilgilerini ForEach ile listele
                        TextField("Arama", text: $searchText)
                                        .padding()
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.horizontal)
                        
                        ForEach(filteredUsers, id: \.self) { user in
                            
                            let adname = user.ad ?? "Bilgi Yok"
                            let soyadname = user.soyad ?? "Bilgi Yok"
                            let mailname = user.mail ?? "Bilgi Yok"
                            let telefon = user.telefon ?? "Bilgi Yok"
                            let isebaslamatarihi = user.isebaslama ?? "Bilgi Yok"
                            let dogumutarihi = user.dogumtarihi ?? "Bilgi Yok"
                            let departman = user.departman ?? "Bilgi Yok"
                            let askerlikdurum = user.askerlikdurum ?? "Bilgi Yok"
                            let projebilgisi = user.projebilgisi ?? "Bilgi Yok"
                            
                        
                                                
                                                VStack(alignment: .leading) {
                                                    Divider()
                                                    Text("Ad: \(adname)")
                                                        .padding(.bottom, 5)
                                                    Text("Soyad: \(soyadname)")
                                                        .padding(.bottom, 5)
                                                    Text("Mail: \(mailname)")
                                                        .padding(.bottom, 5)
                                                    Text("Telefon: \(telefon)")
                                                        .padding(.bottom, 5)
                                                    Text("İşe Başlama Tarihi: \(isebaslamatarihi)")
                                                        .padding(.bottom, 5)
                                                    Text("Doğum Tarihi: \(dogumutarihi)")
                                                        .padding(.bottom, 5)
                                                    Text("Departman: \(departman)")
                                                        .padding(.bottom, 5)
                                                    Text("Proje bilgisi: \(projebilgisi)")
                                                        .padding(.bottom, 5)
                                                    Text("Askerlik Durumu: \(askerlikdurum)")
                                                        .padding(.bottom, 5)
                                                    Divider()
                          
                                                }.padding()
                    }
                    Spacer()
                }
        }
    }
}
struct AddEmployeeView : View {
     @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: []
        ) private var users : FetchedResults<Calisanlar>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var adnameText: String = ""
    @State var soyadnameText: String = ""
    @State var mailnameText: String = ""
    @State var telefon: String = ""
    @State var isebaslamatarihi: String = ""
    @State var dogumutarihi: String = ""
    @State var departman: String = "Yönetici"
    @State var askerlikdurum: String = ""
    @State var projebilgisi: String = ""
    
    var departmanlar = ["Yönetici", "Analist", "Tasarımcı", "Programcı"]
    var body: some View {
            VStack {
                TextField("Ad", text: $adnameText)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            // Soyad TextField
                            TextField("Soyad", text: $soyadnameText)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            // Mail TextField
                            TextField("Mail", text: $mailnameText)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            // Telefon TextField
                            TextField("Telefon", text: $telefon)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.phonePad)

                            // İşe Başlama Tarihi TextField
                            TextField("İşe Başlama Tarihi", text: $isebaslamatarihi)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Sayısal giriş için
                TextField("Proje bilgisi", text: $projebilgisi)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)

                            // Doğum Tarihi TextField
                            TextField("Doğum Tarihi", text: $dogumutarihi)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Sayısal giriş için

                            // Departman TextField
                HStack{
                    Text("Departman seçiniz")
                    Picker("departman seçiniz", selection: $departman) {
                        ForEach(departmanlar, id: \.self) {
                                        Text($0)
                                    }
                                }
                }

                            // Askerlik Durumu TextField
                            TextField("Askerlik Durumu", text: $askerlikdurum)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button {
                    
                    let calisanlarObject = Calisanlar(context: viewContext)
                    calisanlarObject.ad = adnameText
                    calisanlarObject.soyad = soyadnameText
                    calisanlarObject.askerlikdurum = askerlikdurum
                    calisanlarObject.departman = departman
                    calisanlarObject.isebaslama = isebaslamatarihi
                    calisanlarObject.mail = mailnameText
                    calisanlarObject.telefon = telefon
                    calisanlarObject.dogumtarihi = dogumutarihi
                    calisanlarObject.projebilgisi = projebilgisi
                    
                    do {
                        try viewContext.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }catch{
                        print("Error")
                    }
                    
                    
                    
                } label: {
                    Text("Çalışan Kaydet")
                }


            }
            .padding()
        }
}
struct LoginView : View {
    @State var mailnameText: String = ""
    @State var passwordText: String = ""
    @State var isNavigation : Bool = false
    
    
    @FetchRequest(
        sortDescriptors: []
    ) private var users : FetchedResults<Kullanicilar>
    
    @Environment(\.managedObjectContext) private var viewContext
       
    //private var users : FetchedResults<Kullanicilar>



    
    var body: some View {
        NavigationStack{
            VStack {
                Text ("YSOFT Login")
                Spacer()
           
                TextField("Mail", text: $mailnameText).padding()
                TextField("Password", text: $passwordText).padding()
                Button {
                    if  mailnameText.isEmpty || passwordText.isEmpty {
                        isNavigation = false
                    }
                    else{
                        let filteredUsers = users.filter { user in
                            if user.mailnameText == mailnameText && user.passwordText == passwordText {
                                isNavigation = true
                            }
                            
                            
                            return true
                        }
                        

                        if filteredUsers.isEmpty {
                            isNavigation = false
                        } else {
                            // Eğer kullanıcı doğrulandıysa, yeni sayfaya geçiş yap
                          
                        }
                        
                       
                    }
                } label: {
                    Text("Signup")
                }.navigationDestination(isPresented: $isNavigation) {
                    HomeView().environment(\.managedObjectContext, viewContext)
                }
                Spacer()
            
            }
        }
    }
    
}




#Preview {
    SignupView()
}
