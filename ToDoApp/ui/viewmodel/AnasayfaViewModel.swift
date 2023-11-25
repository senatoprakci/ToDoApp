//
//  AnasayfaViewModel.swift
//  ToDoApp
//
//  Created by Sena Toprakcı on 24.11.2023.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var grepo = GorevlerDaoRepository()
    var yapilacaklarListesi = BehaviorSubject<[Yapilacaklar]>(value: [Yapilacaklar]())
    
    init(){
        veritabaniKopyala()
        yapilacaklarListesi = grepo.yapilacaklarListesi
        yapilacaklariYukle()
    }
    
    func sil(gorev_id:Int){
        grepo.sil(gorev_id: gorev_id)
    }
    
    func ara(aramaKelimesi:String){
        grepo.ara(aramaKelimesi: aramaKelimesi)
    }
    
    func yapilacaklariYukle(){
        grepo.yapilacaklariYukle()
    }
    
    func veritabaniKopyala(){
            let bundleYolu = Bundle.main.path(forResource: "todo", ofType: ".sqlite")
            let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("todo.sqlite")
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: kopyalanacakYer.path){
                print("Veritabanı zaten var")
            }else{
                do{
                    try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                }catch{}
            }
    }
}
