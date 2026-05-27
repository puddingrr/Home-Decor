//
//  String.swift
//  InfoWebiOS
//
//  Created by Chhan Sophearith on 30/11/23. lglg
//

import Foundation
import SwiftUI

extension String {
//    var localizable: String {
//        let defaultKey = self.replacingOccurrences(of: "mobile_", with: "").replacingOccurrences(of: "_", with: " ").capitalizedSentence
//        if let text = langKey?.local?[self] {
//            return text ?? defaultKey
//        }
//        return defaultKey
//    }
//    
//    var apiLocalizable: String {
//        if let text = langKey?.api?[self] {
//            return text ?? self
//        }
//        return self
//    }
    
    var camelCaseToWords: String {
        return unicodeScalars.dropFirst().reduce(String(prefix(1))) {
            return CharacterSet.uppercaseLetters.contains($1)
            ? $0 + " " + String($1)
            : $0 + String($1)
        }
    }
    
    func removeWhitespace() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    func convertToDictionary() -> [String: Any]? {
        if let data = data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }
        return nil
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func toArray() -> [String] {
        var arr: [String] = []
        for char in self {
            arr.append(String(char))
        }
        return arr
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isContainsLettersAndNumbers() -> Bool {
        let letters = CharacterSet.letters
        let digits = CharacterSet.decimalDigits
        
        let hasLetter = self.rangeOfCharacter(from: letters) != nil
        let hasNumber = self.rangeOfCharacter(from: digits) != nil
        
        return hasLetter && hasNumber
    }

    func removeComma() -> String {
        self.replacingOccurrences(of: ",", with: "")
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var validateURL: Bool {
        let regex = "http[s]?://(([^/:.[:space:]]+(.[^/:.[:space:]]+)*)|([0-9](.[0-9]{3})))(:[0-9]+)?((/[^?#[:space:]]+)([^#[:space:]]+)?(#.+)?)?"
        let format = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = format.evaluate(with: self.trimUrl)
        return result
     }
    
    var trimUrl: String {
        let result = self.trimFirstAndLastSpace
        let url = self.trimFirstAndLastSpace
        if url.count > 0 && url.last == "/" {
            return String(url.dropLast())
        }
        return result
    }
    
    var trimFirstAndLastSpace: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var twoDegit: String {
        let number = Double(self) ?? 0.00
        return String(format: "%.2f", number)
    }
    
    var specialText: String {
        return self.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    }
    
//    func checkInput(_ type: InputAllow) -> Bool {
//        let regex = "^[\(type.rawValue)]+$"
//        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
//        return predicate.evaluate(with: self)
//    }
//    
//    func onlyAllowCharacter(type: InputAllow) -> String {
//        let set = CharacterSet(charactersIn: type.rawValue)
//        return self.trimmingCharacters(in: set.inverted)
//    }
    
    var capitalizedSentence: String {
        // 1
        let firstLetter = self.prefix(1).capitalized
        // 2
        let remainingLetters = self.dropFirst().lowercased()
        // 3
        return firstLetter + remainingLetters
    }
    
    func getTwoChars() -> String { /// Extracts the first two characters of the given name.
        let components = self.split(separator: " ")
        
        if components.count == 1 { /// Single word: first letter uppercase, second letter lowercase
            let word = components[0]
            let firstChar = word.prefix(1).uppercased()
//            let secondChar = word.dropFirst().prefix(1).lowercased()
//            return firstChar + secondChar
            return firstChar
        } else if components.count > 1 { /// Multiple words: first letters of first two words, both uppercase
            let firstChar = components[0].prefix(1).uppercased()
            let secondChar = components[1].prefix(1).uppercased()
            return firstChar + secondChar
        } else {
            return ""
        }
    }
    
    func calculateWorkDuration() -> String {
        
        let dateFormatter = DateFormatter() // date format
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        guard let joiningDate = dateFormatter.date(from: self) else { // string to data
            return "Invalid Date"
        }
        
        let calendar = Calendar.current
        let today = Date()
        
        let components = calendar.dateComponents([.year, .month, .day], from: joiningDate, to: today)
        
        let years = components.year ?? 0
        let months = components.month ?? 0
        let days = components.day ?? 0
        
        return "\(years) Years \(months) Months \(days) Days"
    }
}
