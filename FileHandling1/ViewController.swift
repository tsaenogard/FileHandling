//
//  ViewController.swift
//  FileHandling1
//
//  Created by XCODE on 2017/4/14.
//  Copyright © 2017年 Gjun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var functionArray = [
        "將資源檔(Apps.plist)複製於document",
        "刪除檔案(Apps.plist)",
        "讀取檔案(Apps.plist)",
        "修改內容並儲存",
        "使用系統預設的plist"
    ]
    var myPlistData = NSMutableDictionary()
//    var buttonArray: [UIButton]!

    func onButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let url = Utilities.sharedInstance.documentPath
            _ = Utilities.sharedInstance.copyBundleFileToFolder(path: url, name: "Apps", extesionString: "plist")
        case 1:
            let url = Utilities.sharedInstance.documentPath.appendingPathComponent("Apps.plist")
            _ = Utilities.sharedInstance.deleteFile(path: url)
        case 2:
            let url = Utilities.sharedInstance.documentPath.appendingPathComponent("Apps.plist")
            self.myPlistData = NSMutableDictionary(contentsOfFile: url.path) ?? NSMutableDictionary()
            print(self.myPlistData)
        case 3:
            let url = Utilities.sharedInstance.documentPath.appendingPathComponent("Apps.plist")
            let tempPlist = NSMutableDictionary()
            for (key, value) in self.myPlistData {
                let _key = (key as? String) ?? ""
                var _value = (value as? [String]) ?? []
                switch _key {
                case "Entertainment":
                    _value.append("new title")
                case "Utilities":
                    _value.append("new utilities")
                case "Games":
                    _value.append("new game")
                default:
                    break
                }
                tempPlist.setObject(_value, forKey: _key as NSCopying)
            }
            tempPlist.write(toFile: url.path, atomically: true)
            print("finish")
        case 4:
            UserDefaults.standard.set(true, forKey: "isLogin")
            print(UserDefaults.standard.bool(forKey: "isLogin"))
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var _frame = CGRect(x: 10, y: 20, width: UIScreen.main.bounds.width - 20, height: 30)
//        self.buttonArray = [UIButton]()
        for model in self.functionArray.enumerated() {
            let button = UIButton(frame: _frame)
            button.tag = model.offset
            button.setTitle(model.element, for: .normal)
            button.backgroundColor = UIColor.darkGray
            button.layer.cornerRadius = 8.0
            button.addTarget(self, action: #selector(self.onButtonAction(_:)), for: .touchUpInside)
            self.view.addSubview(button)
//            self.buttonArray.append(button)
            _frame.origin.y += 40
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(Utilities.sharedInstance.documentPath.path)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

