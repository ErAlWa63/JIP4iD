import SwiftUI

public struct LineListMovieCatalogView: View {

    public var url: String
    public var title: String

    public var body: some View {
        GeometryReader { geo in
            ItemsLineListMovieCatalogView(geo: geo, url: self.url, title: self.title)
        }
    }
}

private struct LineListMovieCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        LineListMovieCatalogView(url: "", title: "title")
    }
}
