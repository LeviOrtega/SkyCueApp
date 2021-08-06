//
//  SkyCueWidget.swift
//  SkyCueWidget
//
//  Created by Levi Ortega on 8/6/21.
//

import WidgetKit
import SwiftUI


struct LocationEntry: TimelineEntry {
    
    let weatherVM: WeatherViewModel = WeatherViewModel()
    //let imageName: ImageName
    //let isNight: IsNight
    let date: Date = Date()
    let location: Location
    
    
    
}


struct Provider: TimelineProvider {
    
    
    
    @AppStorage("location", store: UserDefaults(suiteName: "group.com.leviortega.SkyCue"))
    var locationData: Data = Data()
    
    
    
    
    
    func getSnapshot(in context: Context, completion: @escaping (LocationEntry) -> Void) {
        
        // give a random value
        //let entry = LocationEntry(location: Location(name: randomCity()))
        guard let location = try? JSONDecoder().decode(Location.self, from: locationData) else {return}
        
        let entry = LocationEntry(location: location)
        completion(entry)
        
        
    }
    
    func placeholder(in context: Context) -> LocationEntry {
        return LocationEntry(location: Location(name: randomCity()))
    
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<LocationEntry>) -> Void) {
        guard let location = try? JSONDecoder().decode(Location.self, from: locationData) else {return}
        
        let entry = LocationEntry(location: location)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
        
    }

    
    
}




struct PlaceholderView: View {
    let weatherVM: WeatherViewModel
    var body: some View {
        LocationView(weatherVM: weatherVM, location: Location(name: randomCity()))
    }
}

struct WidgetEntryView: View {
    let entry: Provider.Entry
    
    var body: some View{
        LocationView(weatherVM: entry.weatherVM, location: entry.location)
    }
    
}

@main
struct SkyCueWidget: Widget {
    private let kind = "SkyCueWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()){ entry in
            WidgetEntryView(entry: entry)
        }
        
            
        }
    }

