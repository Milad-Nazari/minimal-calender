//
//  WidgetTimelineProvider.swift
//  WidgetTimelineProvider
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

// Reference: https://wwdcbysundell.com/2020/getting-started-with-widgetkit/

struct WidgetTimelineProvider: TimelineProvider {
	typealias Entry = WidgetEntry

	func getSnapshot(in _: Context, completion: @escaping (WidgetEntry) -> Void) {
		let entry = WidgetEntry(date: Date())
		completion(entry)
	}

	func getTimeline(in _: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
		var entries = [WidgetEntry]()

		let date = Date()
		EventKitWrapper.shared.fetchEvents(for: date) { events in
			let clendarEvents = events.compactMap(Event.init)

			let entry = WidgetEntry(date: date, events: clendarEvents)
			entries.append(entry)

			let timeline = Timeline(entries: entries, policy: .atEnd)
			completion(timeline)
		}
	}

	func placeholder(in _: Context) -> WidgetEntry {
		WidgetEntry(date: Date())
	}
}
