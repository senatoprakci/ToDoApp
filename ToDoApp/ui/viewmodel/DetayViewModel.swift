//
//  DetayViewModel.swift
//  ToDoApp
//
//  Created by Sena Toprakcı on 24.11.2023.
//

import Foundation

class DetayViewModel {
    //view model sayfasından repoya erişmemiz gerektiği için aşağıdaki kodları oluşturduk
    var grepo = GorevlerDaoRepository() //grepo - görevler repository
    
    func guncelle(gorev_id:Int,gorev_ad:String){
        grepo.guncelle(gorev_id: gorev_id, gorev_ad: gorev_ad)
    }
}
