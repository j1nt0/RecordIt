//
//  Extensions.swift
//  RecordIt
//
//  Created by 이진 on 4/15/24.
//

import Foundation

extension Date
{
    func toString(dateFormat format: String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
