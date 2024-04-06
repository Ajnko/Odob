//
//  ViewModel.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import Foundation

struct ViewModel {
    
    //MARK: - Proporties
    let sunnahTypes: [SunnahType]
    let selectedTypeName: String
    
    //Method numberOfRows
    func numberOfRows() -> Int {
        return sunnahTypes.count
    }
    
    //Method titleForRow
    public func titleForRow(atIndex index: Int) -> String? {
        guard index >= 0, index < sunnahTypes.count else {
            return nil
        }
        return sunnahTypes[index].typeName
    }
    
    //Methods countIDsInSelectedTypeName
    func countIDsInSelectedTypeName() -> Int {
        if let selectedSunnahType = sunnahTypes.first(where: { $0.typeName == selectedTypeName }) {
            return selectedSunnahType.sunnahs.count
        }
        return 0
    }
    
    //Method sunnahForIndexPath
    func sunnahForIndexPath(_ indexPath: IndexPath) -> (id: Int, name: String, hadis: String)? {
        if let selectedSunnahType = sunnahTypes.first(where: { $0.typeName == selectedTypeName }) {
            guard indexPath.row >= 0 && indexPath.row < selectedSunnahType.sunnahs.count else {
                return nil
            }
            let sunnah = selectedSunnahType.sunnahs[indexPath.row]
            return (sunnah.id, sunnah.name, sunnah.hadis)
        }
        return nil
    }
    
    //Method definitionAndHadisForID
    func definitionAndHadisForID(_ id: Int) -> (name: String, definition: String, hadis: String, hadisBy: String)? {
        guard let selectedSunnahType = sunnahTypes.first(where: { $0.typeName == selectedTypeName }) else {
            return nil
        }
        
        if let sunnah = selectedSunnahType.sunnahs.first(where: { $0.id == id }) {
            return (sunnah.name, sunnah.definition, sunnah.hadis, sunnah.hadisBy)
        }
        
        return nil
    }
}
