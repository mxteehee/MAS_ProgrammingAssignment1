//
//  WeatherView.swift
//  MAS_P1_MeenaAjith
//
//

import SwiftUI
import Firebase
import CoreLocation

struct WeatherView: View {
    @State var tempType: String = "Celsius"
    @Binding var userLoggedIn: Bool
    @ObservedObject var weatherModel: WeatherModel
    
    var body: some View {
        if userLoggedIn {
            homepage
        } else {
            ContentView()
        }
    }
    
    var homepage : some View {
        ZStack{
            BackgroundView(top:.blue, bottom:.white)
            VStack {
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
                CityTextView(cityName: weatherModel.cityName)
                MainWeather(image:weatherModel.iconName, temp:weatherModel.temperature, tempType: $tempType)
                Spacer()
                
                HStack(spacing:20) {
                    WeatherDayView(dayofWeek: "MON", imageName: "cloud.sun.fill")
                    WeatherDayView(dayofWeek: "TUE", imageName: "sun.max.fill")
                    WeatherDayView(dayofWeek: "WED", imageName:"cloud.sun.fill")
                    WeatherDayView(dayofWeek: "THURS", imageName: "cloud.heavyrain.fill")
                    WeatherDayView(dayofWeek: "FRI", imageName:"cloud.sun.fill")
                }
                Spacer()
                
                let temps = ["Fahrenheit", "Celsius"]
                Picker("Temperature", selection:$tempType, content:{
                    ForEach(temps, id: \.self, content: { temp in
                        Text(temp)
                    })
                })
                Spacer()
            }
            .onAppear(perform: weatherModel.refresh)
        }
    }

    struct BackgroundView: View{
        var top:Color
        var bottom:Color
        var body:some View{
            LinearGradient(colors: [top, bottom], startPoint: .topLeading,
                           endPoint:.bottomTrailing)
            .edgesIgnoringSafeArea(.all)
        }
    }
    struct WeatherDayView: View {
        var dayofWeek:String
        var imageName:String
            
        var body: some View{
            VStack{
                Text(dayofWeek)
                    .font(.system(size:16, weight:.medium,design:.default))
                    .foregroundColor(.white)
                    
                Image(systemName:imageName).renderingMode(.original).resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:40,height:40)
            }
        }
    }
    struct CityTextView: View {
        var cityName : String
        var body: some View {
            Text(cityName)
                .font(.system(size:32,weight:.medium,design:.default))
                .foregroundColor(.white)
                .padding()
        }
    }
    struct MainWeather: View {
        var image:String
        var temp:String
        @Binding var tempType:String
        
        var body: some View{
            VStack (spacing: 8){
                Image(image).renderingMode(.original).resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:180, height:180)
                if tempType == "Celsius" {
                    Text("\(temp)°C")
                        .font(.system(size:70,weight:.medium))
                        .foregroundColor(.white)
                } else {
                    let fahrenTemp = ((Int(temp) ?? 0)*9/5)+32
                    Text("\(fahrenTemp)°F")
                        .font(.system(size:70,weight:.medium))
                        .foregroundColor(.white)
                }
            }
        }
    }
}
