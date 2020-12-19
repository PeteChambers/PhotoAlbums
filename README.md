# PhotoAlbums

PhotoAlbums is a simple album list, photo list and photo detail application, using data from https://jsonplaceholder.typicode.com

### Prerequisites

##### CocoaPods

-  Make sure CocoaPods is installed.

- [CocoaPods](https://github.com/CocoaPods/CocoaPods) - The application level dependency manager used.  Update your Podfile to include the following:

`pod 'Alamofire'`

`pod 'AlamofireImage'`

- Run pod install.

### Running the app

Open PhotoAlbums.xcodeproj with xcode. you can either install in an iOS device or running the project in the simulator.

### User Interface

The user interface is made up of 3 viewcontrollers:

- AlbumsCollectionViewController
- PhotosCollectionViewController
- PhotoDetailViewController

#### AlbumsCollectionViewController

- Album titles from JSONPlaceholder are loaded into the collection view and are displayed in cells with randomly generated colour gradients

- The search bar at the top of the view can be used to filter the list of albums by title.

- A successful search will return an album with an exact matching title.

- An unsuccessful search will return an error message.

- Tapping on the x button on the search bar will clear the filter.

- There is a UISwitch at the top right of this view which toggles the app appearence from Light Mode to Dark Mode.

- Tapping on any of the albums takes you to the PhotosCollectionViewController.

#### PhotosCollectionViewController

- Here you can view the collection of thumbnail images from JSONPlaceholder according the album that was selected on the previous screen.

- Tapping on the button at the top left takes you back to the AlbumsCollectionViewController

- Tapping on any of the images sets off a transtion animation that results in the display of the PhotoDetailViewController.

#### PhotoDetailViewController

- The image that was tapped on in the previous screen is now displayed in full screen and uses the higher resolution image from JSONPlaceholder.

- Tapping on the button at the top left takes you back to the PhotosCollectionViewController.
