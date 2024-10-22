//
//  DetailsViewController.swift
//  GhayethPrj
//
//  Created by Mac-Mini-2021 on 21/10/2024.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    //var
     var prdTitle: String?
    
    
    //iboutlets
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!

    
    //ib Actions
    
    
    
    @IBAction func saveFavoritesAction(_ sender: Any) {
        if checkProduct(){
            
            let alert = UIAlertController (title: "Warning", message: "Clothes already exist", preferredStyle: .alert )
            let action = UIAlertAction(title: "Go it!", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
            
        }else{
            
            
            
            insertProduct()
        }
    }
    
    //check product in db
    func checkProduct() -> Bool{
        
        var productExist = false
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext   //[NSMAnagedObject]
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Product")
        let predicate = NSPredicate(format: "title = %@", prdTitle!)
        request.predicate = predicate
        
        do{
            let result = try managedContext.fetch (request)
            if result.count > 0{
                productExist = true
            }
            
        }catch{
            print("FETCHING ERROR")
        }
        
        return productExist
    }
    
    
    //viewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.image = UIImage(named:prdTitle!)
        productTitle.text = prdTitle!
        // Do any additional setup after loading the view.
    }
  
    
    
    
    
    // insert
    func insertProduct(){
        //app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //persistContainer
        let persistContainr = appDelegate.persistentContainer
        
        //copy managedContext
        let managedContext = persistContainr.viewContext
        
        //article vide
        let entityDesc = NSEntityDescription.entity(forEntityName: "Product", in: managedContext)
        
        //obj
        let obj = NSManagedObject(entity: entityDesc!, insertInto: managedContext)
        
        //add value
        obj.setValue(prdTitle, forKey: "title")
        
        //push
        do {
            try managedContext.save()
        } catch  {
            print("Failed: insert error")
        }
        
    }
}
