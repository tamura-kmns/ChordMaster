//
//  ViewController.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/03.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var managedContext:NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appdelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName:"BasicNote", in: managedObjectContext)
        // データ追加
        var chordBase = ChordBase(entity:entity!,insertInto:managedObjectContext)
        chordBase.intvls = [0,3,6]
        chordBase.kName = "メジャー"
        chordBase.cName = "major"
        chordBase.symbol = ""
        chordBase.symbol2 = "maj"
        do{
            try managedObjectContext.save()
        }catch{
            
        }
        chordBase = ChordBase(entity:entity!,insertInto:managedObjectContext)
        chordBase.intvls = [0,3,6]
        chordBase.kName = "マイナー"
        chordBase.cName = "minor"
        chordBase.symbol = "m"
        chordBase.symbol2 = "min"
        do{
            try managedObjectContext.save()
        }catch{
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

