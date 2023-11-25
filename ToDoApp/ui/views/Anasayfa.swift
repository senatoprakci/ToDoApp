//
//  ViewController.swift
//  ToDoApp
//
//  Created by Sena Toprakcı on 17.11.2023.
//

import UIKit

class Anasayfa: UIViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var todoTableView: UITableView!
    var yapilacakListesi = [Yapilacaklar]()
    
    var viewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        todoTableView.delegate = self
        todoTableView.dataSource = self
        
        _ = viewModel.yapilacaklarListesi.subscribe(onNext: { liste in
            self.yapilacakListesi = liste //sana bir veri getirdim
            self.todoTableView.reloadData() //arayüzünü güncelle demek oluyor
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.yapilacaklariYukle() //geri geldiğimiz zaman arayüzde verileri görmek için. 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let gorev = sender as? Yapilacaklar {
                let gidilecekVC = segue.destination as! Detay
                gidilecekVC.gorev = gorev
            }
        }
    }
}

extension Anasayfa:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.ara(aramaKelimesi: searchText)
    }
}

extension Anasayfa:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yapilacakListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gorev = yapilacakListesi[indexPath.row]
        
        let hucre = tableView.dequeueReusableCell(withIdentifier: "gorevHucre") as!
        Hucre
        
        hucre.labelGorev.text = gorev.gorev_ad
        
        return hucre
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gorev = yapilacakListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: gorev)
        tableView.deselectRow(at: indexPath, animated: true) //seçili durumdan kurtarır
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil")
        {contextualAction,view,bool in
            let gorev = self.yapilacakListesi[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "'\(gorev.gorev_ad!)' adlı görev silinsin mi ?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.viewModel.sil(gorev_id: gorev.gorev_id!)
            }
            alert.addAction(evetAction)
            
            self.present(alert,animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
