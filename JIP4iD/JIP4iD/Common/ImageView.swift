import SwiftUI

public struct ImageView: View {

    @ObservedObject private var imageLoader: ImageLoader

    public init(withURL url: String) {

        imageLoader = ImageLoader(urlString: url)
    }

    private var uiImage: UIImage {
        guard let data = imageLoader.data else {
            return UIImage()
        }

        guard let uiImage = UIImage(data: data) else {
            return UIImage()
        }

        return uiImage
    }

    public var body: some View {
        Image(uiImage: uiImage)
            .resizable()
    }
}

private struct ImageView_Previews: PreviewProvider {

    static var previews: some View {
        ImageView(withURL: "")
    }
}
