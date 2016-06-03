//
//  ViewController.swift
//  SwiftAPITests
//
//  Created by Jacob Van Brunt on 3/20/15.
//  Copyright (c) 2015 Jacob Van Brunt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let path:NSString = NSBundle.mainBundle().pathForResource("text", ofType: "plist")!
        let infoPlist =  NSArray(contentsOfFile: path as String)
     
   
        
        jiexi(infoPlist![0] as! NSString, index: 0) { () -> (Void) in
           
            print("第一个写入成功")
        }
        jiexi(infoPlist![1] as! NSString, index: 0) { () -> (Void) in
            print("第二个写入成功")
        }
        jiexi(infoPlist![2] as! NSString, index: 0) { () -> (Void) in
            print("第三个写入成功")
           
        }
        
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func jiexi(str:NSString, index:NSInteger,block:()->(Void)) -> Void {
        
        let manager = AFHTTPRequestOperationManager();
        
        let acceptableTypes = NSMutableSet();
        acceptableTypes.addObject("application/json");
        
        manager.responseSerializer.acceptableContentTypes=acceptableTypes as NSSet as Set<NSObject>;
        manager.GET(str as String, parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            

            let string = (response as! NSDictionary)["result"] as! NSArray
            
            var fm:NSFileManager = NSFileManager.defaultManager()
            let ducumentPath2:String = NSHomeDirectory()+"/Documents"
            
            let plistPath:NSString = ducumentPath2.stringByAppendingString("\(index).text")
            
            fm.createFileAtPath(plistPath as String, contents: nil, attributes: nil)
            
            (string[0] as! NSDictionary).writeToFile(plistPath as String, atomically: true)
            block();
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            return false
            
        };
       
    }
}

