import SwiftUI

public struct MovieDetailsPosterView: View {
    public var width: CGFloat
    public var height: CGFloat
    public var url: String

    public var body: some View {
        ImageView(withURL: url)
        .frame(minWidth: width, minHeight: height)
    }
}

// swiftlint:disable:next redundant_type_annotation unnecessary_type
//private struct MovieDetailsPosterView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailsPosterView()
//    }
//}

//                                    self.moviePoster(geo, self.isLandscape(), "https://image.tmdb.org/t/p/w500\(self.networkManager.movieDetails.posterPath)")


private func moviePoster(_ proxy: GeometryProxy, _ isLandscape: Bool, _ url: String ) -> some View {
    ImageView(withURL: url)
        .frame(minWidth: isLandscape ? proxy.size.width / 2 : proxy.size.width, minHeight: proxy.size.height / 3)
        .aspectRatio(contentMode: .fit)
        .padding(.bottom)
}

