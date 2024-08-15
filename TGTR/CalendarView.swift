//
//  CalendarView.swift
//  TGTR
//
//  Created by Elin.Andersson on 2024-08-15.
//

import Foundation
import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date()
    @State private var vitaminDays: Set<Date> = loadVitaminDays()
    
    private let calendar = Calendar.current
    private let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    private let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate)!
                    loadVitaminDaysForCurrentMonth()
                }) {
                    Image(systemName: "chevron.left")
                        .padding()
                }
                
                Text(monthFormatter.string(from: currentDate))
                    .font(.title)
                    .frame(maxWidth: .infinity)
                
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
                    loadVitaminDaysForCurrentMonth()
                }) {
                    Image(systemName: "chevron.right")
                        .padding()
                }
            }
            
            let days = generateDaysInMonth(for: currentDate)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(days, id: \.self) { date in
                    VStack {
                        Text(dayFormatter.string(from: date))
                            .font(.caption)
                        
                        Button(action: {
                            toggleVitaminDay(date: date)
                        }) {
                            if vitaminDays.contains(date) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .frame(width: 40, height: 40)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }
                    .padding(5)
                    .background(calendar.isDateInToday(date) ? Color.yellow.opacity(0.3) : Color.clear)
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .onAppear {
            loadVitaminDaysForCurrentMonth()
        }
    }
    
    private func generateDaysInMonth(for date: Date) -> [Date] {
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!
        
        var days: [Date] = []
        for day in 0..<calendar.range(of: .day, in: .month, for: startOfMonth)!.count {
            if let date = calendar.date(byAdding: .day, value: day, to: startOfMonth) {
                days.append(date)
            }
        }
        return days
    }
    
    private func toggleVitaminDay(date: Date) {
        if vitaminDays.contains(date) {
            vitaminDays.remove(date)
        } else {
            vitaminDays.insert(date)
        }
        saveVitaminDays()
    }
    
    private func saveVitaminDays() {
        let datesArray = vitaminDays.map { ISO8601DateFormatter().string(from: $0) }
        UserDefaults.standard.set(datesArray, forKey: "vitaminDays")
    }
    
    private func loadVitaminDaysForCurrentMonth() {
        vitaminDays = CalendarView.loadVitaminDays().filter {
            calendar.isDate($0, equalTo: currentDate, toGranularity: .month)
        }
    }
    
    static private func loadVitaminDays() -> Set<Date> {
        guard let datesArray = UserDefaults.standard.array(forKey: "vitaminDays") as? [String] else {
            return []
        }
        let dates = datesArray.compactMap { ISO8601DateFormatter().date(from: $0) }
        return Set(dates)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}


