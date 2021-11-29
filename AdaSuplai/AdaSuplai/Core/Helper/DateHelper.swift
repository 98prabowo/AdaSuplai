//
//  DateHelper.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 26/11/21.
//

import Foundation
// The date components available to be retrieved or modifed
public enum DateComponentType {
    case second, minute, hour, day, weekday, nthWeekday, week, month, year
}

public enum DateFormatType {
    
    /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-07-16
    case isoDate
    
    /// The ISO8601 formatted date with slash "MM/dd/yyyy" i.e. 02/14/1997
    case isoDateWithSlash
    
    /// The ISO8601 formatted date and time "yyyy-MM-dd'T'HH:mmZ" i.e. 1997-07-16T19:20+01:00
    case isoDateTime
    
    /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ssZ" i.e. 1997-07-16T19:20:30+01:00
    case isoDateTimeSec
    
    /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" i.e. 1997-07-16T19:20:30.45Z
    case isoDateTimeMilliSec
    
    /// The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
    case dotNet
    
    /// A generic standard format date i.e. "dd/MM/yyyy HH:mm ZZZ"
    case standard
    
    /// A generic standard format date i.e. "MM/dd/yyyyHH:mm:ss"
    case standardSecSlash
    
    /// A generic standard formate date i.e. "d MMMM yyyy"
    case basic
    
    /// A custom date format string
    case custom(String)
    
    /// for document number
    case docNumber
    public var stringFormat: String {
        switch self {
        case .isoDate:
            return "yyyy-MM-dd"
        case .isoDateWithSlash:
            return "MM/dd/yyyy"
        case .isoDateTime:
            return "yyyy-MM-dd'T'HH:mmZ"
        case .isoDateTimeSec:
            return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .isoDateTimeMilliSec:
            return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        case .dotNet:
            return "/Date(%d%f)/"
        case .standard:
            return "dd/MM/yyyy h:mm a "
        case .standardSecSlash:
            return "MM/dd/yyyy HH:mm:ss"
        case .basic:
            return "d MMMM yyyy"
        case .custom(let customFormat):
            return customFormat
        case .docNumber:
            return "yyMMddHHmm"
        }
    }
}

extension Date {
    // MARK: Static Cached Formatters
    
    /// A cached static array of DateFormatters so that thy are only created once.
    private static var cachedDateFormatters = [String: DateFormatter]()
    private static var cachedOrdinalNumberFormatter = NumberFormatter()
    
    /// Generates a cached formatter based on the specified format, timeZone and locale. Formatters are cached in a singleton array using hashkeys.
    private static func cachedFormatter(_ format: String = DateFormatType.standard.stringFormat) -> DateFormatter {
        let hashKey = "\(format.hashValue)"
        guard let formatter = Date.cachedDateFormatters[hashKey] else {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.isLenient = true
            Date.cachedDateFormatters[hashKey] = formatter
            return formatter
        }
        return formatter
    }
    
    public func toString(format: DateFormatType) -> String {
        switch format {
        case .dotNet:
            let offset = Foundation.NSTimeZone.default.secondsFromGMT() / 3600
            let nowMillis = 1000 * self.timeIntervalSince1970
            return String(format: format.stringFormat, nowMillis, offset)
        default:
            break
        }
        let formatter = Date.cachedFormatter(format.stringFormat)
        return formatter.string(from: self)
    }
    
    public var defaultLogoutTime: Date {
        var components = DateComponents()
        components.day = 0
        let nextDate = Calendar.current.date(byAdding: components, to: Date()) ?? Date()
        var autoLogoutComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: nextDate)
        autoLogoutComponents.hour = 1
        autoLogoutComponents.minute = 0
        autoLogoutComponents.timeZone = TimeZone(abbreviation: "CST")
        let calendar = Calendar.current
        return calendar.date(from: autoLogoutComponents) ?? Date()
    }
    
    public var nextLogoutTime: Date {
        var components = DateComponents()
        components.day = 1
        let nextDate = Calendar.current.date(byAdding: components, to: Date()) ?? Date()
        var autoLogoutComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: nextDate)
        autoLogoutComponents.hour = 1
        autoLogoutComponents.minute = 0
        autoLogoutComponents.timeZone = TimeZone(abbreviation: "CST")
        let calendar = Calendar.current
        return calendar.date(from: autoLogoutComponents) ?? Date()
    }
}
