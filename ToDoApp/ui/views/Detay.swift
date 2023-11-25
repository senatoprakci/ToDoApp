//
//  Detay.swift
//  ToDoApp
//
//  Created by Sena Toprakcı on 18.11.2023.
//

import UIKit

class Detay: UIViewController {

    var viewModel = DetayViewModel()
    
    @IBOutlet weak var tfYazi: UITextField!
    
    var gorev:Yapilacaklar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let g = gorev {
            tfYazi.text = g.gorev_ad
        }
    }
    
    @IBAction func buttonGuncelle(_ sender: Any) {
        
        if let ga = tfYazi.text, let g = gorev  { // ga : görev adı
            viewModel.guncelle(gorev_id: g.gorev_id!, gorev_ad: ga)
        }
    }
    
}
