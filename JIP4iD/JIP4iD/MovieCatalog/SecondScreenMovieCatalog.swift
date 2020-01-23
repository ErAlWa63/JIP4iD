import SwiftUI

public struct SecondScreenMovieCatalog: View {

    public var body: some View {
        WarningView(text: "No movie selected")
    }
}

private struct SecondScreenMovieCatalog_Previews: PreviewProvider {

    static var previews: some View {
        SecondScreenMovieCatalog()
    }
}
