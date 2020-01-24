import SwiftUI

public struct ItemsLineListMovieCatalogView: View {

    public var geo: GeometryProxy
    public var url: String
    public var title: String

    public var body: some View {
        HStack(alignment: .center) {
            MoviePosterView(geo: geo, url: url)
            MovieTitleView(title: title)
            Spacer()
        }
    }
}

// swiftlint:disable comments_space comments_capitalized_find_possible_code
//struct ItemsLineListMovieCatalogView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemsLineListMovieCatalogView(geo: GeometryProxy(), url: "", title: "title")
//    }
//}
