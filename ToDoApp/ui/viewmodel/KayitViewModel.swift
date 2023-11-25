//
//  KayitViewModel.swift
//  ToDoApp
//
//  Created by Sena Toprakcı on 24.11.2023.
//

import Foundation

class KayitViewModel {
    var grepo = GorevlerDaoRepository()
    
    func kaydet(gorev_ad:String){
        grepo.kaydet(gorev_ad: gorev_ad)
    }
}
