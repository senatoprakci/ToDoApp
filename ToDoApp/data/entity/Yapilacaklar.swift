//
//  Yapilacaklar.swift
//  ToDoApp
//
//  Created by Sena Toprakcı on 23.11.2023.
//

import Foundation

//anasayfadaki görevleri listelemek için böyle bir class oluşturduk

class Yapilacaklar {
    
    var gorev_id:Int?
    var gorev_ad:String?
    
    init() {
        
    }
    
    init(gorev_id: Int?, gorev_ad: String?) {
        self.gorev_id = gorev_id
        self.gorev_ad = gorev_ad
    }
    
}
