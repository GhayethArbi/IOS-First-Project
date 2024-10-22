//
//  FavoritesViewController.swift
//  GhayethPrj
//
//  Created by Mac-Mini-2021 on 21/10/2024.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UITableViewDataSource {
    
    
    //var
    var favorites = [String]()
    
    
    
    //widgets
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        let label = contentView?.viewWithTag(2) as! UILabel
        let imageview = contentView?.viewWithTag(1) as! UIImageView
        label.text = favorites[ indexPath.row]
        imageview.image = UIImage(named: favorites[indexPath.row])
        
        return cell!
        
    }
    
    //scroll
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteItem(index: indexPath.row)
            
            //remove from this table
            favorites.remove(at: indexPath.row)
            
            //update table
            tableView.reloadData()
        }
    }

    //fetch all
    func fetchAll(){
        //app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //persistContainer
        let persistContainr = appDelegate.persistentContainer
        
        //copy managedContext
        let managedContext = persistContainr.viewContext
        
        //req
        let req = NSFetchRequest<NSManagedObject>(entityName: "Product")
        
        //exec
        do {
            let articles = try managedContext.fetch(req)
            for item in articles{
                favorites.append(item.value(forKey: "title")as! String)
                print(item.value(forKey: "title") as! String)
            }
            
        } catch  {
            print("Failed: fetch error")
        }
        
        
    }
    
    //delete product
    func deleteItem(index: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Product")
        let predicate = NSPredicate(format: "title = %@", favorites[index])
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request)
            if let obj = result.first {
                managedContext.delete(obj)
                try managedContext.save() // Save the context after deletion
                print("DELETING SUCCESSFULLY!")
            }
        } catch {
            print("Error deleting item: \(error.localizedDescription)")
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAll()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
