//
//  String+Extension.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//
import Foundation

extension String {
    func transformDateString() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM.yyyy"
        
        if let date = inputFormatter.date(from: self) {
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
