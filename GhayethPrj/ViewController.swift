//
//  ViewController.swift
//  GhayethPrj
//
//  Created by Mac-Mini-2021 on 21/10/2024.
//

import UIKit
import SwiftUI
import CoreData
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    //var
    var data = ["Pullover","Street clothes","Shirt","Longsleeve Violeta"]
    
    
    
    //IBAction

    
    
    
    
    
    
    /*@IBAction func openFavorites(_ sender: Any) {
        let favoritesView = FavoritesViewController()
        let hostingController = UIHostingController(rootView: favoritesView)
        navigationController?.pushViewController(hostingController, animated: true)
        fetchAll()
    }
    
    @IBAction func bookMarkerAction(_ sender: Any) {
        
        //app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //persistContainer
        let persistContainr = appDelegate.persistentContainer
        
        //copy managedContext
        let managedContext = persistContainr.viewContext
        
        //swiftUiView
        let swiftUIView = FavoriteViewController().environment(\.managedObjectContext, managedContext)
        
        //hostcontroller
        let hostController = UIHostingController(rootView: swiftUIView)
        
        //navigate to hostController
        navigationController?.pushViewController(hostController, animated: true)
    }*/
    
    

    
    //func tablew
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        let label = contentView?.viewWithTag(2) as! UILabel
        let imageview = contentView?.viewWithTag(1) as! UIImageView
        label.text = data[ indexPath.row]
        imageview.image = UIImage(named: data[indexPath.row])
        
        return cell!
        
    }
    
    
    //CelluleOnClickListner
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = data[indexPath.row]
        performSegue(withIdentifier: "mSegue", sender: product)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mSegue" {
            if let destination = segue.destination as? DetailsViewController,
               let product = sender as? String{
                destination.prdTitle = product
            }
        }
    }
    
    
    
    
    //viewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

