//
//  AppDelegate.swift
//  ChordMaster
//
//  Created by KatsuhikoTamura on 2018/07/03.
//  Copyright © 2018年 9bit.co. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let dbAccess = DBAccess()
        let chordCount:Int? = dbAccess.db_countChords() //TODO コードのカウントでいいか？
        
        if let count = chordCount {
            if(count == 0){
             print("Start generating db data")
             self.initBasicNote()
             self.initChordBase()
             self.generateChordTable()
            }else{
              print("db data already exists.Skip generating data")
            }
 
        }else{
           print("db error..get chord count")
        }

        base12NoteArray = dbAccess.db_getBase12Notes()
        
        self.initAllNotes()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    //12音生成
    func initBasicNote(){
     let dbAccess = DBAccess()
        for i in 0..<12 {
            dbAccess.db_insertBaseNote(eNameF:eNameSharpArray[i],
                                       eNameS:eNameFlatArray[i],
                                       iNameF:iNameSharpArray[i],
                                       iNameS:iNameFlatArray[i],
                                       jNameF:jNameSharpArray[i],
                                       jNameS:jNameFlatArray[i],
                                       noteNumber:i)
        }
    }
 
    func initChordBase(){
        let dbAccess = DBAccess()
        for chordType:ChordType in chordTypes {
            dbAccess.db_insertChordBase(name:chordType.name,
                                       jName:chordType.jName,
                                       kName:chordType.kName,
                                       symbol:chordType.symbol,
                                       symbol2:chordType.symbol2,
                                       intvls:chordType.intvls)

        }
    }
    
    
    func generateChordTable(){
        let dbAccess = DBAccess()
        var chordNum:Int = 0
        for i in 0..<12 {
            for chordType in chordTypes {
                dbAccess.db_insertChord(chordNum:chordNum, noteNumber:i, chordSymbol:chordType.symbol)
                chordNum += 1
            }
        }
    }
    
    //全noteテーブル(鍵盤)生成
    func initAllNotes() {
        for i in 0...96 {
            allNoteArray.append(allNote(noteNum: i) )
        }
    }


    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ChordMaster")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("save error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

