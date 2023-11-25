//
//  Kayit.swift
//  ToDoApp
//
//  Created by Sena Toprakcı on 18.11.2023.
//

import UIKit

class Kayit: UIViewController {

    var viewModel = KayitViewModel()
    
    @IBOutlet weak var tfYazi: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonKaydet(_ sender: Any) {
        if let ga = tfYazi.text { // ga : görev adı
            viewModel.kaydet(gorev_ad: ga)
        }
    }
}
