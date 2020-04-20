import SwiftUI

public struct MovieCatalogPosterView: View {

    public var geo: GeometryProxy
    public var url: String

    public var body: some View {
        ImageView(withURL: url)
            .frame(width: geo.size.width * 0.48, height: geo.size.height)
    }
}

// swiftlint:disable comments_space comments_capitalized_find_possible_code
//struct MoviePosterView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoviePosterView()
//    }
//}
