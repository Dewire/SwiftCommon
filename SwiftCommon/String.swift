//
//  String.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 26/12/15.
//  Copyright © 2015 Dewire. All rights reserved.
//

import Foundation

// MARK: match, gmatch, sub, gsub

public extension String {
  
  /**
  Matches self against a regular expression. The return value is a String.MatchData
  instance for the first match in the string or nil if no match was found.
  
  The second parameter are the regex options to use.
  The string option format supports the following options (can be combined, eg "imx"):
  ```
  "i"  .CaseInsensitive
  "m"  .DotMatchesLineSeparators
  "a"  .AnchorsMatchLines
  "x"  .AllowCommentsAndWhitespace
  ```
  
  Example:
  ```
  let res = "hello world 123".match("(\\w+) (\\d+)")
  res[0]  // => "world 123"
  res[1]  // => "world"
  res[2]  // => "123"
  ```
  */
  public func match(
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
  
  /**
  Matches self against a regular expression. The return value is an array of
  @link String.MatchData @/link instances, one for each match.
   
  See match for possible regex options.
  
  Example:
  ```
  let res = "hello world hello HELLO".gmatch("hello", "i")!
  res.count  // => 3
  res[2][0]  // => HELLO
  ```
  */
  public func gmatch(
    regex: String,
    _ options: String? = nil) -> [MatchData]? {
      
      let opts = try! parseStringOptions(options)
      guard let pattern = try? NSRegularExpression(pattern: regex, options: opts) else { return nil }
      
      let matches = pattern.matchesInString(self,
        options: NSMatchingOptions.init(rawValue: 0),
        range: NSMakeRange(0, (self as NSString).length))
      
      return matches.isEmpty ? nil : matches.map() { MatchData(string: self, match: $0) }
  }
  
  /**
   The MatchData struct acts like an Array<String> where the first element is the text
   of the entire match. The MatchData struct may also contain additional elements where
   each additional element corresponds to a regular expression group match.
   */
  public struct MatchData {
    private let data: [String]
    
    /// 1 + the number of groups in the match.
    public var count: Int {
      return data.count
    }
    
    private init(string: String, match: NSTextCheckingResult) {
      
      let ranges = (0..<match.numberOfRanges).map() { match.rangeAtIndex($0) }
      
      data = ranges.map() { range in
        (string as NSString).substringWithRange(range)
      }
    }
    
    public subscript(index: Int) -> String {
      return data[index]
    }
    
    public subscript(range: Range<Int>) -> [String] {
      return Array(data[range])
    }
    
    public func toArray() -> [String] {
      return data
    }
    
    /// Returns an array of the group captures in the match.
    public func captures() -> [String] {
      return Array(data.dropFirst(1))
    }
  }
  
  /**
   Substitues the first match of regex in the string
   
   See match for possible regex options.
   
   Example:
   ```
   "SPeling is hard speling".sub("speling", replacement: "Spelling", "i")) 
   // => Spelling is hard speling
   ```
	*/
  public func sub(regex: String, replacement: String, _ options: String? = nil) -> String {
    return _sub(regex,
      replacement: replacement,
      matchingOptions: NSMatchingOptions.Anchored,
      options: options)
  }
  
  /**
   Substitues all matches of regex in the string
   
   See match for possible regex options.
   
   Example:
   ```
   let l = "1337 1337 1337!!!"
   l.gsub("3+", replacement: "4")  // => 147 147 147!!!
   ```
   */
  public func gsub(regex: String, replacement: String, _ options: String? = nil) -> String {
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
  
  private func parseStringOptions(options: String?) throws -> NSRegularExpressionOptions {
    let noOptions = NSRegularExpressionOptions.init(rawValue: 0)
    guard let options = options where !options.isEmpty else { return noOptions }
    
    var enums = [NSRegularExpressionOptions]()
    for char in options.characters {
      switch char {
      case "i": enums.append(.CaseInsensitive)
      case "m": enums.append(.DotMatchesLineSeparators)
      case "a": enums.append(.AnchorsMatchLines)
      case "x": enums.append(.AllowCommentsAndWhitespace)
      default: throw NSError(domain: "unknown regex option - \(char)", code: 0, userInfo: nil)
      }
    }
    
    return enums.reduce(noOptions) { result, option in
      result.union(option)
    }
  }
}
