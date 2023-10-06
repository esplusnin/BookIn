// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum HotelScreen {
    /// Об отеле
    internal static let aboutHotel = L10n.tr("Localizable", "hotelScreen.aboutHotel", fallback: "Об отеле")
    /// К выбору номера
    internal static let chooseRoomButton = L10n.tr("Localizable", "hotelScreen.chooseRoomButton", fallback: "К выбору номера")
    /// Отель
    internal static let title = L10n.tr("Localizable", "hotelScreen.title", fallback: "Отель")
    internal enum TableView {
      /// Удобства
      internal static let facilities = L10n.tr("Localizable", "hotelScreen.tableView.facilities", fallback: "Удобства")
      /// Что включено
      internal static let includes = L10n.tr("Localizable", "hotelScreen.tableView.includes", fallback: "Что включено")
      /// Самое необходимое
      internal static let mostRequires = L10n.tr("Localizable", "hotelScreen.tableView.mostRequires", fallback: "Самое необходимое")
      /// Что не включено
      internal static let notIncludes = L10n.tr("Localizable", "hotelScreen.tableView.notIncludes", fallback: "Что не включено")
    }
  }
  internal enum ReservationScreen {
    /// Страна, город
    internal static let countryCity = L10n.tr("Localizable", "reservationScreen.countryCity", fallback: "Страна, город")
    /// Даты
    internal static let dates = L10n.tr("Localizable", "reservationScreen.dates", fallback: "Даты")
    /// Вылет из
    internal static let departureFrom = L10n.tr("Localizable", "reservationScreen.departureFrom", fallback: "Вылет из")
    /// Кол-во ночей
    internal static let numberOfNights = L10n.tr("Localizable", "reservationScreen.numberOfNights", fallback: "Кол-во ночей")
    /// Питание
    internal static let nutrition = L10n.tr("Localizable", "reservationScreen.nutrition", fallback: "Питание")
    /// Бронирование
    internal static let reservation = L10n.tr("Localizable", "reservationScreen.reservation", fallback: "Бронирование")
    /// Номер
    internal static let roomName = L10n.tr("Localizable", "reservationScreen.roomName", fallback: "Номер")
    /// Отель
    internal static let stackHotelName = L10n.tr("Localizable", "reservationScreen.stackHotelName", fallback: "Отель")
  }
  internal enum RoomScreen {
    /// Подробнее о номере
    internal static let aboutTheRoom = L10n.tr("Localizable", "roomScreen.aboutTheRoom", fallback: "Подробнее о номере")
    /// Выбрать номер
    internal static let chooseTheRoom = L10n.tr("Localizable", "roomScreen.chooseTheRoom", fallback: "Выбрать номер")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
