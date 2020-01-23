import SwiftUI

public struct WarningView: View {

    public var text: String = "WarningView"

    public var body: some View {
        Text(text)
            .font(.title)
    }
}

private struct WarningView_Previews: PreviewProvider {

    static var previews: some View {
        WarningView(text: "WarningView")
    }
}
