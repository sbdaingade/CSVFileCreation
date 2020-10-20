//
//  ViewController.swift
//  CSVFileCreation
//
//  Created by Sachin Daingade on 20/10/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnGenerateJSON: UIButton!
    @IBOutlet weak var btnWriteJsonNShare: UIButton!
    @IBOutlet weak var lblFileStatus: UILabel!
    
    @IBOutlet weak var txtView: UITextView!
    
    var globalArray = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnGenerateJSONAction(_ sender: Any) {
        
       
        var Rows = [String:Any]()
        Rows["First"] = "Sachin"
        Rows["Second"] = "Rahul"
        Rows["Third"] = "Sourabh"
        Rows["Fourth"] = "Yuvraj"
        Rows["Sixth"] = "Zahir"
        Rows["Seven"] = "Robin"
        Rows["Eight"] = "Anil"
        Rows["Nine"] = "Harbhajan"
        
        var Sections = [String:Any]()
        Sections["Cricket"] = "Team India"
        Sections["Team Member"] = [Rows]
        globalArray.append(Sections)
        
        Rows = [String:Any]()
        Rows["First"] = "A"
        Rows["Second"] = "B"
        Rows["Third"] = "C"
        Rows["Fourth"] = "D"
        Rows["Sixth"] = "E"
        Rows["Seven"] = "F"
        Rows["Eight"] = "G"
        Rows["Nine"] = "H"
        
        Sections = [String:Any]()
        Sections["Cricket"] = "Team Alpha"
        Sections["Team Member"] = [Rows]
        globalArray.append(Sections)
        
        self.txtView.text = json(from: self.globalArray)
    }
    
    private func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    @IBAction func btnWriteFileAndShareAction(_ sender: Any) {
        
        let shareFileData = GenerateCSVData(withArrayOfJson: globalArray)
        self.createFile(csvData: shareFileData.rawData)
        let url = self.getFilePath()
        let text = "Share CSV "
        let shareAll = [text , url ] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender as? UIView
        if #available(iOS 13, *) {
        activityViewController.isModalInPresentation = true
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func createFile(csvData: Data) {
        let filename = getDocumentsDirectory().appendingPathComponent("CSVData.csv")
        do {
            try csvData.write(to: filename, options: .atomic)
            print("file writen successfully")
        } catch {
         //   print("failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding")
            print(error.localizedDescription)
        }
    }
    
   private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    private func getFilePath()-> URL  {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("CSVData").appendingPathExtension("csv")
    }
    
}

