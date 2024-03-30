//
//  ViewModel.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import Foundation

class ViewModel {
    var sunnahViewModel: [SunnahType] = []
        
    
    init(){
        self.sunnahViewModel = sunnahs.map({ sunnahType in
            let sunnahItem = sunnahType.sunnahs.map { sunnah in
                return Sunnah(id: sunnah.id, name: sunnah.name, definition: sunnah.definition, hadis: sunnah.hadis, hadisBy: sunnah.hadisBy)
            }
            return SunnahType(typeName: sunnahType.typeName, sunnahs: sunnahItem)
        })
    }
    

        
}
