import SwiftUI

public struct MovieTitleView: View {

    public var title: String = ""
    public var body: some View {
        Text(title)
            .font(.headline)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
}

private struct MovieTitleView_Previews: PreviewProvider {
    static var previews: some View {
        MovieTitleView(title: "title")
    }
}
