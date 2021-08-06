//
//  SkyCueWidget.swift
//  SkyCueWidget
//
//  Created by Levi Ortega on 8/6/21.
//

import WidgetKit
import SwiftUI


struct LocationEntry: TimelineEntry {
    
    let date: Date = Date()
    let location: Location
    
}


struct Provider: IntentTimelineProvider {
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<LocationEntry>) -> Void) {
        guard let location = try? JSONDecoder().decode(Location.self, from: locationData) else {return}
        
        let entry = LocationEntry(location: location)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
    
    
    @AppStorage("location", store: UserDefaults(suiteName: "group.com.leviortega.SkyCue"))
    var locationData: Data = Data()
    
    func placeholder(in context: Context) -> LocationEntry {
        LocationEntry(location: Location(name: randomCity()))
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (LocationEntry) -> ()) {
        let entry =    LocationEntry(location: Location(name: randomCity()))
        completion(entry)
    }
    
    
    
}







struct TestEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        LocationView(location: entry.location)
    }
}




@main
struct SkyCueWidget: Widget {
    let kind: String = "SkyCueWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            TestEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

