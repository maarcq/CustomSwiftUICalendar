//
//  ContentView.swift
//  CustomSwiftUICalendar
//
//  Created by Marcelle Ribeiro Queiroz on 02/03/25.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var color: Color = .blue
    @State private var date = Date.now
    
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    @State private var days: [Date] = []
    
    var body: some View {
        VStack {
            LabeledContent("Calendar Color") {
                ColorPicker("", selection: $color, supportsOpacity: false)
            }
            
            LabeledContent("Date/Time") {
                DatePicker("", selection: $date)
            }
            
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(color)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                    } else {
                        Text(day.formatted(.dateTime.day()))
                            .fontWeight(.black)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundStyle(Date.now.startOfDay == day.startOfDay ? color.opacity(0.7) : color.opacity(0.1))
                            )
                    }
                }
            }
        }
        .padding()
        .onAppear {
            days = date.calendarDisplayDays
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
        }
    }
}

#Preview {
    CalendarView()
}
