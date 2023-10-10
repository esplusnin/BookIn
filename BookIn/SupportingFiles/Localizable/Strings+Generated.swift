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
    /// от 
    internal static let priceFrom = L10n.tr("Localizable", "hotelScreen.priceFrom", fallback: "от ")
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
  internal enum Numbers {
    /// Первый 
    internal static let _1 = L10n.tr("Localizable", "numbers.1", fallback: "Первый ")
    /// Десятый 
    internal static let _10 = L10n.tr("Localizable", "numbers.10", fallback: "Десятый ")
    /// Второй 
    internal static let _2 = L10n.tr("Localizable", "numbers.2", fallback: "Второй ")
    /// Третий 
    internal static let _3 = L10n.tr("Localizable", "numbers.3", fallback: "Третий ")
    /// Четвертый 
    internal static let _4 = L10n.tr("Localizable", "numbers.4", fallback: "Четвертый ")
    /// Пятый 
    internal static let _5 = L10n.tr("Localizable", "numbers.5", fallback: "Пятый ")
    /// Шестой 
    internal static let _6 = L10n.tr("Localizable", "numbers.6", fallback: "Шестой ")
    /// Седьмой 
    internal static let _7 = L10n.tr("Localizable", "numbers.7", fallback: "Седьмой ")
    /// Восьмой 
    internal static let _8 = L10n.tr("Localizable", "numbers.8", fallback: "Восьмой ")
    /// Девятый 
    internal static let _9 = L10n.tr("Localizable", "numbers.9", fallback: "Девятый ")
    /// Лишний 
    internal static let x = L10n.tr("Localizable", "numbers.x", fallback: "Лишний ")
  }
  internal enum PaymentSuccesScreen {
    /// Супер!
    internal static let completeButton = L10n.tr("Localizable", "paymentSuccesScreen.completeButton", fallback: "Супер!")
    /// Заказ принят в работу
    internal static let orderApprove = L10n.tr("Localizable", "paymentSuccesScreen.orderApprove", fallback: "Заказ принят в работу")
    /// Подтверждение заказа 
    internal static let orderConfirm = L10n.tr("Localizable", "paymentSuccesScreen.orderConfirm", fallback: "Подтверждение заказа ")
    ///  может занять некоторое время (от 1 часа до суток).
    /// Как только мы получим ответ от туроперетора, вам на почту придет уведомление
    internal static let orderText = L10n.tr("Localizable", "paymentSuccesScreen.orderText", fallback: " может занять некоторое время (от 1 часа до суток).\nКак только мы получим ответ от туроперетора, вам на почту придет уведомление")
    /// Заказ оплачен
    internal static let title = L10n.tr("Localizable", "paymentSuccesScreen.title", fallback: "Заказ оплачен")
  }
  internal enum ReservationScreen {
    /// Страна, город
    internal static let countryCity = L10n.tr("Localizable", "reservationScreen.countryCity", fallback: "Страна, город")
    /// Информация о покупателе
    internal static let customerInfo = L10n.tr("Localizable", "reservationScreen.customerInfo", fallback: "Информация о покупателе")
    /// Даты
    internal static let dates = L10n.tr("Localizable", "reservationScreen.dates", fallback: "Даты")
    /// Вылет из
    internal static let departureFrom = L10n.tr("Localizable", "reservationScreen.departureFrom", fallback: "Вылет из")
    /// Кол-во ночей
    internal static let numberOfNights = L10n.tr("Localizable", "reservationScreen.numberOfNights", fallback: "Кол-во ночей")
    ///  ночей
    internal static let numberOfNightsForm = L10n.tr("Localizable", "reservationScreen.numberOfNightsForm", fallback: " ночей")
    /// Питание
    internal static let nutrition = L10n.tr("Localizable", "reservationScreen.nutrition", fallback: "Питание")
    /// Бронирование
    internal static let reservation = L10n.tr("Localizable", "reservationScreen.reservation", fallback: "Бронирование")
    /// Номер
    internal static let roomName = L10n.tr("Localizable", "reservationScreen.roomName", fallback: "Номер")
    /// Отель
    internal static let stackHotelName = L10n.tr("Localizable", "reservationScreen.stackHotelName", fallback: "Отель")
    internal enum Customer {
      /// Добавить туриста
      internal static let addTourist = L10n.tr("Localizable", "reservationScreen.customer.addTourist", fallback: "Добавить туриста")
      /// Граждансво
      internal static let citizenship = L10n.tr("Localizable", "reservationScreen.customer.citizenship", fallback: "Граждансво")
      /// Дата рождения
      internal static let dateOfBirhtday = L10n.tr("Localizable", "reservationScreen.customer.dateOfBirhtday", fallback: "Дата рождения")
      /// Почта
      internal static let email = L10n.tr("Localizable", "reservationScreen.customer.email", fallback: "Почта")
      /// Имя
      internal static let name = L10n.tr("Localizable", "reservationScreen.customer.name", fallback: "Имя")
      /// Срок действия загранпаспорта
      internal static let passportDuration = L10n.tr("Localizable", "reservationScreen.customer.passportDuration", fallback: "Срок действия загранпаспорта")
      /// Номер загранпаспорта
      internal static let passportNumber = L10n.tr("Localizable", "reservationScreen.customer.passportNumber", fallback: "Номер загранпаспорта")
      /// Номер телефона
      internal static let phoneNumber = L10n.tr("Localizable", "reservationScreen.customer.phoneNumber", fallback: "Номер телефона")
      /// Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту
      internal static let privacy = L10n.tr("Localizable", "reservationScreen.customer.privacy", fallback: "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
      /// Фамилия
      internal static let surname = L10n.tr("Localizable", "reservationScreen.customer.surname", fallback: "Фамилия")
      /// турист
      internal static let tourist = L10n.tr("Localizable", "reservationScreen.customer.tourist", fallback: "турист")
    }
    internal enum TotalSum {
      /// Топливный сбор
      internal static let fuelFee = L10n.tr("Localizable", "reservationScreen.totalSum.fuelFee", fallback: "Топливный сбор")
      /// Оплатить
      internal static let pay = L10n.tr("Localizable", "reservationScreen.totalSum.pay", fallback: "Оплатить")
      /// Сервисный сбор
      internal static let serviceFee = L10n.tr("Localizable", "reservationScreen.totalSum.serviceFee", fallback: "Сервисный сбор")
      /// К оплате
      internal static let sum = L10n.tr("Localizable", "reservationScreen.totalSum.sum", fallback: "К оплате")
      /// Тур
      internal static let tourPrice = L10n.tr("Localizable", "reservationScreen.totalSum.tourPrice", fallback: "Тур")
    }
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
