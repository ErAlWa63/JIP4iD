import Foundation

extension String {

    var dottedDate: String { // swiftlint:disable:this explicit_acl

        let dateFormatter: DateFormatter

        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date: Date = dateFormatter.date(from: self) else {
            return "unknown date"
        }
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}
