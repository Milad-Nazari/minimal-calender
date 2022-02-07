//
//  CalendarHeaderView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import CVCalendar
import SwiftUI

struct CalendarHeaderView: UIViewRepresentable {
    func makeCoordinator() -> CalendarViewCoordinator {
        CalendarViewCoordinator(
            calendar: CalendarManager.shared.calendar,
            calendarViewMode: SettingsManager.calendarViewModePerSettings
        )
    }

    func makeUIView(context: Context) -> CVCalendarMenuView {
        let view = CVCalendarMenuView(
            frame: CGRect(
                x: 0, y: 0,
                width: Constants.CalendarView.calendarWidth,
                height: Constants.CalendarView.calendarHeaderHeight
            )
        )
        view.delegate = context.coordinator
        view.commitMenuViewUpdate()
        return view
    }

    func updateUIView(_ view: CVCalendarMenuView, context: Context) {
        view.commitMenuViewUpdate()
    }
}

struct CalendarHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarHeaderView()
    }
}
