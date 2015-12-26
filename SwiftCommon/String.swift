//
//  String.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 26/12/15.
//  Copyright © 2015 Dewire. All rights reserved.
//

import Foundation

extension String {
  
  // MARK: Searching
  
  /**
  Matches self against a regular expression. The return value is a MatchData instance
  encapsulating the match (and any regular expression group matches), or nil if no
  match was found.
  
  The MatchData struct acts like an Array<String> where the first element is the text
  of the entire match. The MatchData struct may also contain additional elements where
  each additional element corresponds to a regular expression group match.
  
  Example:
  let res = "hello world 123".rmatch("(\\w+) (\\d+)")
  res[0]  // => "world 123"
  res[1]  // => "world"
  res[2]  // => "123"
  **/
  func match(
    regex: String,
    _ options: String? = nil) -> MatchData? {
      
      let opts = try! parseStringOptions(options)
      
      guard let pattern = try? NSRegularExpression(pattern: regex, options: opts),
        match = pattern.firstMatchInString(self,
          options: NSMatchingOptions.init(rawValue: 0),
          range: NSMakeRange(0, (self as NSString).length))
        else {
          return nil
      }
      
      return MatchData(string: self, match: match)
  }
  
  func gmatch(
    regex: String,
    _ options: String? = nil) -> [MatchData]? {
      
      let opts = try! parseStringOptions(options)
      guard let pattern = try? NSRegularExpression(pattern: regex, options: opts) else { return nil }
      
      let matches = pattern.matchesInString(self,
        options: NSMatchingOptions.init(rawValue: 0),
        range: NSMakeRange(0, (self as NSString).length))
      
      return matches.isEmpty ? nil : matches.map() { MatchData(string: self, match: $0) }
  }
  
  struct MatchData {
    private let data: [String]
    
    init(string: String, match: NSTextCheckingResult) {
      
      let ranges = (0..<match.numberOfRanges).map() { match.rangeAtIndex($0) }
      
      data = ranges.map() { range in
        (string as NSString).substringWithRange(range)
      }
    }
    
    subscript(index: Int) -> String {
      return data[index]
    }
    
    subscript(range: Range<Int>) -> [String] {
      return Array(data[range])
    }
    
    func toArray() -> [String] {
      return data
    }
    
    func count() -> Int {
      return data.count
    }
    
    func captures() -> [String] {
      return Array(data.dropFirst(1))
    }
  }
  
  // MARK: Replacing
  
  func sub(regex: String, replacement: String, _ options: String? = nil) -> String {
    return _sub(regex,
      replacement: replacement,
      matchingOptions: NSMatchingOptions.Anchored,
      options: options)
  }
  
  func gsub(regex: String, replacement: String, _ options: String? = nil) -> String {
    return _sub(regex,
      replacement: replacement,
      matchingOptions: NSMatchingOptions.init(rawValue: 0),
      options: options)
  }
  
  private func _sub(
    regex: String,
    replacement: String,
    matchingOptions: NSMatchingOptions,
    options: String?) -> String {
      
      let opts = try! parseStringOptions(options)
      guard let pattern = try? NSRegularExpression(pattern: regex, options: opts) else { return self }
      
      let mut = NSMutableString(string: self)
      pattern.replaceMatchesInString(mut,
        options: matchingOptions,
        range: NSMakeRange(0, mut.length),
        withTemplate: replacement)
      
      return String(mut)
  }
  
  // MARK: Common utilities
  
  private func parseStringOptions(options: String?) throws -> NSRegularExpressionOptions {
    let noOptions = NSRegularExpressionOptions.init(rawValue: 0)
    guard let options = options where !options.isEmpty else { return noOptions }
    
    var enums = [NSRegularExpressionOptions]()
    for char in options.characters {
      switch char {
      case "i": enums.append(.CaseInsensitive)
      case "m": enums.append(.DotMatchesLineSeparators)
      case "a": enums.append(.AnchorsMatchLines)
      default: throw NSError(domain: "unknown regex option - \(char)", code: 0, userInfo: nil)
      }
    }
    
    return enums.reduce(noOptions) { result, option in
      result.union(option)
    }
  }
}



























