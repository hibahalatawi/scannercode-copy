//
//  ContentView.swift
//  scannercode
//
//  Created by Hibah Abdullah Alatawi on 21/07/1444 AH.
//

import SwiftUI
import AuthenticationServices
struct ContentView: View {
    
    @State private var showScannerSheet = false
    @State private var enterAlertPresent = false
    @State private var nameDoucment = ""
    @State private var search = ""
    @State private var images:[ScanData] = []
    @State private var doucment: ScanData?
    
    var body: some View {
        
        NavigationView{
            VStack{
                
                Text("  \(search)")
                   // .navigationTitle("Searchable Example")
            
                if images.count > 0 {
                    List(images) { image in
                        NavigationLink {
                            ScrollView {
                                VStack {
                                    Text(image.name)
                                        .onTapGesture {
                                            self.enterAlertPresent = true
                                        }
                                    Image(uiImage: image.content)
                                        .resizable()
                                        .frame(width: 400, height: 400)
                                        .scaledToFit()
                                       // .frame(maxWidth:50,maxHeight: 80)
                                    
                                }.alert("Enter name Doucment", isPresented: $enterAlertPresent, actions: {
                                    TextField("Name Doucment",text: $nameDoucment)
                                    Button("Save", role: .cancel) {
                                        image.name = nameDoucment
                                    }
                                }, message: {
                                    Text("")
                                })
                            }
                        } label: {
                            Text(image.name.debugDescription)
                        }

                    }
                } else {
                    Text("No Scan")
                }
            }
            
            .navigationTitle("Last Bill ")
            .searchable(text: $search, prompt: "Look for Your Bill")
            
           .navigationBarItems(trailing:Button(action: {
           self.showScannerSheet = true
                
            },
            label:{Text("")
                Image(systemName:"doc.text.viewfinder").font(.title)
                
            })
                .sheet(isPresented: $showScannerSheet , content: {
                    makeScannerView()
                    
                })
            )
        }
    }
    var searchResults: [ScanData] {
            if search.isEmpty {
                return images
            } else {
                return images.filter { $0.name.contains(search) }
            }
        }

    private func makeScannerView()-> ScannerView {
        ScannerView { image in
            if let image = image {
                let newScanData = ScanData(content: image,name: UUID().uuidString)
//                doucment = newScanData
                self.images.append(newScanData)
            }
            self.showScannerSheet = false
            
        }
    }
    }
                                


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
       
      
    }
}
