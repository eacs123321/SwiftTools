//
//  fileChunk.swift
//  SwiftTools
//
//  Created by 何安竺 on 2022/9/23.
//

import Foundation
import UIKit

///檔案切割
func fileChunk(size: Int, url: URL) -> [Data]{
    let data = try? Data(contentsOf: url, options: .alwaysMapped)
    var chunks:[Data] = [Data]()
    if data != nil{
        let dataLen = data!.count
        let chunkSize = size // MB
        let fullChunks = Int(dataLen / chunkSize)
        //let totalChunks = fullChunks + (dataLen % 1024 != 0 ? 1 : 0)
        let totalChunks = fullChunks + (dataLen % chunkSize != 0 ? 1 : 0)
        
        for chunkCounter in 0..<totalChunks {
            var chunk : Data
            let chunkBase = chunkCounter * chunkSize
            var diff = chunkSize
            if(chunkCounter == totalChunks - 1) {
                diff = dataLen - chunkBase
            }
            let range:Range<Data.Index> = chunkBase..<(chunkBase + diff)
            chunk = data!.subdata(in: range)
            print("The size is \(chunk.count)")
            chunks.append(chunk)
        }
    }
    return chunks
}

