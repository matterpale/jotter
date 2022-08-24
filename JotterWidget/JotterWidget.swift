//
//  JotterWidget.swift
//  JotterWidget
//
//  Created by matterpale on 24.08.2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), jot: "Example notes.")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), jot: "Example notes.")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        entries.append(SimpleEntry(date: Date(), jot: "Example notes."))
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let jot: String
}

struct jotterWidgetEntryView : View {
    var entry: Provider.Entry
    
    @AppStorage("jot", store: UserDefaults(suiteName: "group.jotterapp")) var jotter: String = ""
    var body: some View {
        Text(jotter)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .topLeading)
            .font(.custom("AmericanTypewriter", fixedSize: 10))
            .padding(7)
    }
}

@main
struct jotterWidget: Widget {
    let kind: String = "jotterWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            jotterWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Jotter")
        .description("Jotter widget for quick notes preview.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct jotterWidget_Previews: PreviewProvider {
    static var previews: some View {
        jotterWidgetEntryView(entry: SimpleEntry(date: Date(), jot: "Some notes..."))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
