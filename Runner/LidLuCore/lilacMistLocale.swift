import Foundation

enum lilacMistLocale {
    static var preferredLanguages: [String] {
        Locale.preferredLanguages
    }

    static var localTimeZoneIdentifier: String {
        TimeZone.current.identifier
    }

    static var currentLanguageCode: String {
        Locale.current.language.languageCode?.identifier ?? "en"
    }
}

