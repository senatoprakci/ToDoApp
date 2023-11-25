//
//  GorevlerDaoRepository.swift
//  ToDoApp
//
//  Created by Sena Toprakcı on 24.11.2023.
//

import Foundation
import RxSwift

class GorevlerDaoRepository {
    
    var yapilacaklarListesi = BehaviorSubject<[Yapilacaklar]>(value: [Yapilacaklar]())
    
    let db:FMDatabase? //veritabanı erişim nesnesi
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("todo.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func kaydet(gorev_ad:String){
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT INTO yapilacaklar(gorev_ad) VALUES (?)", values: [gorev_ad])
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func guncelle(gorev_id:Int,gorev_ad:String){
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE yapilacaklar SET gorev_ad = ? WHERE gorev_id = ?", values: [gorev_ad,gorev_id])
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func sil(gorev_id:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM yapilacaklar WHERE gorev_id = ?", values: [gorev_id])
            yapilacaklariYukle() //veriyi sildikten sonra kalanları görmek için
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func ara(aramaKelimesi:String){
        db?.open()
        var liste = [Yapilacaklar]()
        
        do{
            
            let rs = try db!.executeQuery("SELECT * FROM yapilacaklar WHERE gorev_ad like '%\(aramaKelimesi)%'", values: nil)
            
            while rs.next() {
                let gorev = Yapilacaklar(gorev_id: Int(rs.string(forColumn: "gorev_id"))!,
                                         gorev_ad: rs.string(forColumn: "gorev_ad")!)
                
                    liste.append(gorev)
                
            }
            yapilacaklarListesi.onNext(liste) //tetikleme
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func yapilacaklariYukle(){
        
        db?.open()
        var liste = [Yapilacaklar]()
        
        do{
            
            let rs = try db!.executeQuery("SELECT * FROM yapilacaklar", values: nil)
            
            while rs.next() {
                let gorev = Yapilacaklar(gorev_id: Int(rs.string(forColumn: "gorev_id"))!,
                                         gorev_ad: rs.string(forColumn: "gorev_ad")!)
                
                    liste.append(gorev)
                
            }
            yapilacaklarListesi.onNext(liste) //tetikleme
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
}
