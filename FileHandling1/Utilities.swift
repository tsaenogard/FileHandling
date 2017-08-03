//
//  Utilities.swift
//  Toast
//
//  Created by smallHappy on 2017/4/6.
//  Copyright © 2017年 SmallHappy. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    private static let instance = Utilities()
    static var sharedInstance: Utilities {
        return self.instance
    }
    
    var timer: Timer?
    var target: UIViewController?
}

extension Utilities {
    
    func showAlertView(title: String? = nil, message: String? = nil, target: UIViewController, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmButton = UIAlertAction(title: "確認", style: .default, handler: handler)
        alert.addAction(confirmButton)
        DispatchQueue.main.async { target.present(alert, animated: true, completion: nil) }
    }
    
    func showAlertView(title: String? = nil, message: String? = nil, target: UIViewController, cancelHandler: ((UIAlertAction) -> Void)? = nil, confirmHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "取消", style: .default, handler: cancelHandler)
        alert.addAction(cancelButton)
        let confirmButton = UIAlertAction(title: "確認", style: .default, handler: confirmHandler)
        alert.addAction(confirmButton)
        DispatchQueue.main.async { target.present(alert, animated: true, completion: nil) }
    }
    
}

extension Utilities {
    
    enum ToastLength: Double {
        case long = 3.5, short = 2.0
    }
    
    enum ToastStyle {
        case label, view
    }
    
    func toast(taget: UIViewController, style: ToastStyle = .label, message: String, length: ToastLength = .short) {
        let frameW = taget.view.frame.width
        let frameH = taget.view.frame.height
        let gap: CGFloat = 10
        let labelH: CGFloat = 21
        switch style {
        case .label:
            let label = UILabel(frame: CGRect(x: 0, y: frameH - labelH - gap, width: frameW, height: labelH))
            label.text = message
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            label.transform = CGAffineTransform(translationX: 0, y: labelH + gap)
            taget.view.addSubview(label)
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                label.transform = CGAffineTransform.identity
            }, completion: { (isFinish) in
                UIView.animate(withDuration: length.rawValue, animations: {
                    label.alpha = 0.0
                }, completion: { (isFinish) in
                    label.removeFromSuperview()
                })
            })
        case .view:
            let viewH: CGFloat = labelH + gap * 2
            let _view = UIView(frame: CGRect(x: gap, y: frameH - viewH - gap, width: frameW - gap * 2, height: viewH))
            _view.backgroundColor = UIColor.black
            _view.alpha = 0.85
            _view.transform = CGAffineTransform(translationX: 0, y: viewH + gap)
            _view.layer.cornerRadius = 8.0
            taget.view.addSubview(_view)
            let label = UILabel(frame: CGRect(x: gap * 2, y: frameH - labelH - gap * 2, width: frameW - gap * 4, height: labelH))
            label.text = message
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.transform = CGAffineTransform(translationX: 0, y: labelH + gap * 2)
            taget.view.addSubview(label)
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { 
                _view.transform = CGAffineTransform.identity
                label.transform = CGAffineTransform.identity
            }, completion: { (isFinish) in
                UIView.animate(withDuration: length.rawValue, animations: {
                    _view.alpha = 0.0
                    label.alpha = 0.0
                }, completion: { (isFinish) in
                    _view.removeFromSuperview()
                    label.removeFromSuperview()
                })
            })
        }
    }
    
}

//extension Utilities {
//    
//    func showSnow(target: UIViewController) {
//        self.target = target
//        self.timer = Timer.scheduledTimer(timeInterval: 1.75, target: self, selector: #selector(self.onTimerTick), userInfo: nil, repeats: true)
//    }
//    
//    func stopSnow() {
//        self.target = nil
//        self.timer?.invalidate()
//    }
//    
//    func onTimerTick() {
//        if self.target == nil { return }
//        let frameW = self.target!.view.frame.width
//        let frameH = self.target!.view.frame.height
//        let flakeStartX = CGFloat(Int(arc4random()) % Int(frameW)) // 0.0~frameW
//        let flakeEndX = CGFloat(Int(arc4random()) % Int(frameH)) // 0.0~frameW
//        var flakeS = CGFloat(Int(arc4random()) % 100) / 100.0 // 0.0~1.0
//        flakeS += 0.5 // 0.5~1.5
//        flakeS *= 25.0 // 12.5~27.5
//        
//        let flakeImageView = UIImageView(image: UIImage(named: "flake"))
//        flakeImageView.frame = CGRect(x: flakeStartX, y: -50.0, width: flakeS, height: flakeS)
//        flakeImageView.alpha = 0.4
//        self.target!.view.addSubview(flakeImageView)
//        
//        var speed = Double(Int(arc4random()) % 100) / 100.0 // 0.0~1.0
//        speed += 1.0 // 1.0~2.0
//        speed *= 15.0 // 5.0~10.0
//        
//        UIView.animate(withDuration: speed, animations: {
//            UIView.setAnimationCurve(.easeOut)
//            flakeImageView.frame.origin = CGPoint(x: flakeEndX, y: frameH - 20)
//        }) { (isFinish) in
//            UIView.animate(withDuration: 2.5, animations: {
//                flakeImageView.alpha = 0.0
//            }, completion: { (isFinish) in
//                flakeImageView.removeFromSuperview()
//            })
//        }
//    }
//    
//}

extension Utilities {
    
    /*
     參考資料： http://www.jianshu.com/p/de591f5389e1
     */
    
    enum Folder: String {
        case image = "image"
        case video = "video"
        case text = "text"
    }
    
    var documentPath: URL {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return URL(string: path)!
    }
    
    func path(folder: Folder) -> URL {
        return self.documentPath.appendingPathComponent(folder.rawValue)
    }
    
    func createFolder(path: URL) -> Bool {
        // 資料夾若已存在，重複建立資料夾並不會刪除裡面原有之的檔案。
        do {
            try FileManager.default.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil)
            print("資料夾" + path.lastPathComponent + "建立成功")
            return true
        } catch {
            print("資料夾" + path.lastPathComponent + "建立失敗")
            return false
        }
    }
    
    func createFileByString(content: String, path: URL) -> Bool {
        _ = self.createFolder(path: path.deletingLastPathComponent())
        // 若資料夾不存在，檔案建立失敗。
        // 若檔案已經存在，將複寫其內容。
        do {
            try content.write(toFile: path.path, atomically: true, encoding: .utf8)
            print("檔案" + path.lastPathComponent + "建立成功")
            return true
        } catch {
            print("檔案" + path.lastPathComponent + "建立失敗")
            return false
        }
    }
    
    func readTxtFile(path: URL) -> Bool {
        do {
            let content = try String(contentsOfFile: path.path)
            print("content:\n" + content)
            return true
        } catch {
            print("檔案" + path.lastPathComponent + "讀取失敗")
            return false
        }
    }
    
    func contentsOfDirectory(path: URL) -> (dirArray: [String], fileArray: [String])? {
        do {
            let contentArray = try FileManager.default.contentsOfDirectory(atPath: path.path)
            var dirArray = [String]()
            var fileArray = [String]()
            var isDir: ObjCBool = false
            print("======")
            print("路徑資料夾內的檔案：\(contentArray)")
            for file in contentArray {
                let subPath = path.appendingPathComponent(file)
                if FileManager.default.fileExists(atPath: subPath.path, isDirectory: &isDir) {
                    if isDir.boolValue {
                        print(file + "是資料夾")
                        dirArray.append(file)
                    } else {
                        print(file + "是檔案")
                        fileArray.append(file)
                    }
                }
            }
            print("資料夾數量：\(dirArray.count)")
            print("檔案數量：\(fileArray.count)")
            print("======")
            return (dirArray, fileArray)
        } catch {
            print("無法解析路徑資料夾")
            return nil
        }
    }
    
    func copyBundleFileToFolder(path: URL, name: String, extesionString: String) -> Bool {
        let file = path.appendingPathComponent(name + "." + extesionString)
        if FileManager.default.fileExists(atPath: file.path) {
            print("資源檔(" + file.lastPathComponent + ")已存在，不需複製。")
            return false
        }
        guard let bundle = Bundle.main.path(forResource: name, ofType: extesionString) else {
            print("資源檔(" + file.lastPathComponent + ")不存在，複製失敗。")
            return false
        }
        _ = self.createFolder(path: path.deletingLastPathComponent())
        do {
            try FileManager.default.copyItem(atPath: bundle, toPath: file.path)//  ~/document/Apps.plist
            print("資源檔(" + file.lastPathComponent + ")複製成功。")
            return true
        } catch {
            print("資源檔(" + file.lastPathComponent + ")複製失敗。")
            return false
        }
    }
    
    func deleteFile(path: URL) -> Bool {
        do {
            try FileManager.default.removeItem(atPath: path.path)
            print("刪除檔案" + path.lastPathComponent + "成功")
            return true
        } catch {
            print("刪除檔案" + path.lastPathComponent + "失敗")
            return false
        }
    }
    
}
