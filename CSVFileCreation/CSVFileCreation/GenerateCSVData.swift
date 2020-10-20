//
//  GenerateCSVData.swift
//  CSVFileCreation
//
//  Created by Sachin Daingade on 20/10/20.
//

import Foundation
import CSV

public struct GenerateCSVData{
    
    public var rawData = Data()
    
    init(withArrayOfJson dataArray: [[String:Any]]) {
        self.rawData = generateCSVData(dataArray: dataArray)
    }
    
    private func generateCSVData(dataArray: [[String:Any]])-> Data {
        
        let stream = OutputStream(toMemory: ())
        let csv = try! CSVWriter(stream: stream)
        
        dataArray.forEach { sections in
            try! csv.write(row: [sections["Cricket"] as! String])
            if let teamMember = sections["Team Member"] as? [[String:Any]]
            {
                let rowKeys = teamMember.first!.keys.sorted().map{$0}
                try! csv.write(row: rowKeys)
                teamMember.forEach({ member in
                    let sortedKeys = member.map{$0.key}.sorted()
                    let rowValues = sortedKeys.map{"\(member[$0] ?? "N/A")"}
                    try! csv.write(row: rowValues)
                })
            }
        }
        csv.stream.close()
        return stream.property(forKey: .dataWrittenToMemoryStreamKey) as! Data
        
    }
}
