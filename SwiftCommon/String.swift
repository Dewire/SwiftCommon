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
  Matches self against a regular expression. The return value is an array with the match followed
  by any group matches, or nil if no match was found.
  
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
  let res = "hello world 123".match("(\\w+) (\\d+)")!
  res[0]  // => "world 123"
  res[1]  // => "world"
  res[2]  // => "123"
  ```
  */
  public func match(
    _ regex: String,
    _ options: String? = nil) -> [String]? {
      
      let opts = parseStringOptions(options)
      
      guard let pattern = try? NSRegularExpression(pattern: regex, options: opts),
        let match = pattern.firstMatch(in: self,
          options: NSRegularExpression.MatchingOptions(rawValue: 0),
          range: NSMakeRange(0, (self as NSString).length))
      else {
        return nil
      }
      
      return makeMatchArray(string: self, match: match)
  }
  
  /**
  Matches self against a regular expression. The return value is an array of
  string arrays, one for each match.
   
  See match for possible regex options.
  
  Example:
  ```
  let res = "hello world hello HELLO".gmatch("hello", "i")!
  res.count  // => 3
  res[2][0]  // => HELLO
  ```
  */
  public func gmatch(
    _ regex: String,
    _ options: String? = nil) -> [[String]]? {
      
      let opts = parseStringOptions(options)
      guard let pattern = try? NSRegularExpression(pattern: regex, options: opts) else { return nil }
      
      let matches = pattern.matches(in: self,
        options: NSRegularExpression.MatchingOptions(rawValue: 0),
        range: NSMakeRange(0, (self as NSString).length))
      
      return matches.isEmpty ? nil : matches.map() { makeMatchArray(string: self, match: $0) }
  }
  
  private func makeMatchArray(string: String, match: NSTextCheckingResult) -> [String] {
    let ranges = (0..<match.numberOfRanges).map() { match.rangeAt($0) }
    
    return ranges.map() { range in
      (string as NSString).substring(with: range)
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
  public func sub(_ regex: String, replacement: String, _ options: String? = nil) -> String {
    return substitue(regex,
      replacement: replacement,
      matchingOptions: NSRegularExpression.MatchingOptions.anchored,
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
  public func gsub(_ regex: String, replacement: String, _ options: String? = nil) -> String {
    return substitue(regex,
      replacement: replacement,
      matchingOptions: NSRegularExpression.MatchingOptions(rawValue: 0),
      options: options)
  }
  
  private func substitue(
    _ regex: String,
    replacement: String,
    matchingOptions: NSRegularExpression.MatchingOptions,
    options: String?) -> String {
      
      let opts = parseStringOptions(options)
      guard let pattern = try? NSRegularExpression(pattern: regex, options: opts) else { return self }
      
      let mut = NSMutableString(string: self)
      pattern.replaceMatches(in: mut,
        options: matchingOptions,
        range: NSMakeRange(0, mut.length),
        withTemplate: replacement)
      
      return String(mut)
  }
  
  private func parseStringOptions(_ options: String?) -> NSRegularExpression.Options {
    let noOptions = NSRegularExpression.Options(rawValue: 0)
    guard let options = options else { return noOptions }
    
    return options.characters.reduce(noOptions) { result, char in
      switch char {
      case "i": return result.union(.caseInsensitive)
      case "m": return result.union(.dotMatchesLineSeparators)
      case "a": return result.union(.anchorsMatchLines)
      case "x": return result.union(.allowCommentsAndWhitespace)
      default: fatalError("unknown regex option - \(char)")
      }
    }
  }
}

// MARK: reverse

public extension String {
  
  /// Returns a copy of self that is reversed.
  public func reversed() -> String {
    return String(characters.reversed())
  }
}
