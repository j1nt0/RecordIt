//
//  Helper.swift
//  RecordIt
//
//  Created by 이진 on 4/15/24.
//  메롱!!!!

import Foundation


func getFileDate(for file: URL) -> Date {
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
        let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
    } else {
        return Date()
    }
}
