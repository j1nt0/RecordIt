//
//  CalenderView.swift
//  RecordIt
//
//  Created by 이진 on 4/13/24.
//  10:33 https://www.youtube.com/watch?v=UZI2dvLoPr8&t=376s

import SwiftUI

struct CalendarView: View {
    
    @Binding var currentDate: Date
    @ObservedObject var audioRecorder: AudioRecorder
    @State var currentMonth: Int = 0
    
    var body: some View {
        
        VStack(spacing: 35) {
            
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            HStack(spacing: 20) {
                HStack(alignment: .bottom, spacing: 15) {
                    Text(extraDate()[1])
                        .foregroundStyle(Color("RecordRed"))
                        .font(.title.bold())
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                }
                Spacer(minLength: 0)
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundStyle(Color("RecordRed"))
                }
                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundStyle(Color("RecordRed"))
                }
            }
            .padding(.horizontal)
            
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(extractDate()) { value in
                    CardView(value: value, audio: audioRecorder.recordings)
                }
            }
        }
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue, audio: [Recording]) -> some View {
        VStack {
            let dateList: [String] = {
                var tempData: [String] = []
                audioRecorder.recordings.forEach{
                    let stringDate = $0.createdAt.toString(dateFormat: "YY-MM-dd")
                    tempData.append(stringDate)
                }
                return tempData
            }()
            
            if value.day != -1 {
                NavigationLink {
//                    List {
//                        let dateToUrllistDic: [String: [URL]] = {
//                            var tempData: [String: [URL]] = [:]
//                            audioRecorder.recordings.forEach{
//                                let stringDate = $0.createdAt.toString(dateFormat: "YY-MM-dd")
//                                // tempData[stringDate, default: []].append(recording.fileURL)
//                                tempData[stringDate] = tempData[stringDate, default: []] + [$0.fileURL]
//                            }
//                            return tempData
//                        }()
//                        
//                        ForEach(dateToUrllistDic.keys.map{ $0 }, id: \.self) { date in
//                            if date == String(value.date.description.prefix(10).suffix(8)) {
//                                Section(date) {
//                                    ForEach(dateToUrllistDic[date] ?? [], id: \.self) { url in
//                                        
//                                        MyRecordingRow(audioURL: url)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    MyRecordingsList(audioRecorder: audioRecorder, tempDate: value.date, version: true)
                    MyRecordingsList(audioRecorder: audioRecorder, version: true, tempDate: value.date)
                } label: {
                    ZStack {
//                        VStack {
//                            Text(value.date.description.prefix(10).suffix(8))
//                            Text(dateList[0])
//                        }
                        if dateList.contains(String(value.date.description.prefix(10).suffix(8))) {
                            Circle()
                                .foregroundStyle(Color("RecordRed"))
                                .frame(height: 5)
                                .offset(y:15)
                        }
                        Text("\(value.day)")
                            .foregroundStyle(.black)
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
            }
        }
    }
    
    func extraDate()-> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth()-> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate()-> [DateValue] {
        
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
            
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

#Preview {
    CalendarView(currentDate: .constant(Date()), audioRecorder: AudioRecorder())
}

extension Date {
    func getAllDates()-> [Date] {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
