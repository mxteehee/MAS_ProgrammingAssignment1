//
//  WeatherView.swift
//  MAS_P1_MeenaAjith
//
//  Created by Meena Ajith on 9/11/23.
//

import SwiftUI
import Firebase

struct WeatherView: View {
    @Binding var userLoggedIn: Bool
    
    var body: some View {
        if userLoggedIn {
            homepage
        } else {
            ContentView()
        }
    }
    
    var homepage : some View {
        VStack {
            Text("Hello World")
            Button(action: {
                do {
                    try Auth.auth().signOut()
                    self.userLoggedIn = false
                } catch let soError as NSError {
                    print(soError)
                }
            }, label: {
                Text("Log Out")
            })
        }
    }
}

//struct WeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherView()
//    }
//}
