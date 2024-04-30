//
//  DailyTasksViewModel.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/04/24.
//

import Foundation

struct DailyTasksViewModel {
    //MARK: - Properties
    let sunnahTypes: [SunnahType]
    let currentDate: Date
    
    func currentSunnah() -> Sunnah? {
        let dayIndex = Calendar.current.ordinality(of: .day, in: .year, for: currentDate) ?? 1
        let totalSunnahCount = sunnahTypes.flatMap { $0.sunnahs }.count
        let index = (dayIndex - 1) % totalSunnahCount
        
        let flatSunnahs = sunnahTypes.flatMap { $0.sunnahs }
        guard index < flatSunnahs.count else { return nil }
        
        return flatSunnahs[index]
    }
    
//    private var currentIndex: Int {
//        let index = Calendar.current.ordinality(of: .day, in: .year, for: currentData) ?? 0
//        return index % sunnahTypes.count
//    }
//    
//    private var currentSunnahType: SunnahType {
//        return sunnahTypes[currentIndex]
//    }
//    
//    var currentSunnah: Sunnah {
//        return currentSunnahType.sunnahs.first!
//    }
//    
//    func numberOfRows() -> Int {
//        return currentSunnahType.sunnahs.count
//    }
//    
//    func sunnahForIndex(_ index: Int) -> Sunnah? {
//        guard index >= 0, index < currentSunnahType.sunnahs.count else {
//            return nil
//        }
//        return currentSunnahType.sunnahs[index]
//    }
}
