import SwiftUI

public struct MovieCatalogView: View {

    public var body: some View {
        NavigationView {
            FirstScreenMovieCatalogView()
            .navigationBarTitle("Movie Catalog", displayMode: .inline)

            SecondScreenMovieCatalog()
        }
    }
}

private struct MovieCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCatalogView()
    }
}
