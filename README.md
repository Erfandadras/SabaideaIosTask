# SabaideaIosTask

# SabaideaTask

## Overview

SabaideaTask is a Swift-based application that displays a list of movies fetched from a remote server. Users can search for movies, view details of individual movies, and enjoy a smooth and intuitive user experience powered by SwiftUI.

## Features

- **Home Screen**: Displays a list of movies with support for pull-to-refresh and lazy loading.
- **Search Functionality**: Search for movies using a keyword and view results dynamically.
- **Navigation**: Navigate to detailed pages for individual movies using `NavigationStack`.
- **Error Handling**: Informative error messages are displayed when data fetching fails.
- **Modular Design**: The application is structured with clear separation of concerns, making it maintainable and extendable.
- **RTL/LTR Support**: The app adapts its layout dynamically based on the user's language preference.

## Technology Stack

- **Min iOS**: 17.o
- **Language**: Swift
- **UI Framework**: SwiftUI
- **Network Layer**: Custom implementation using Combine and async/await.
- **Dependency Injection**: Mock and production clients are injected for easy testing and debugging.
- **State Management**: ObservableObject and @Published properties for reactive UI updates.
- **Third-Party Library**: [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI) is used for asynchronous image loading and caching.

## Project Structure

- **MovieListView**: Displays a list of movies and handles navigation to detailed views.
- **MovieDetailView**: Displays detailed information about a specific movie, including its title, image, and description.
- **MovieViewModel**: Manages business logic and binds the UI to the data layer.
- **MoviesDatasource**: Handles API requests and data processing.
- **Networking**: Custom network client for making API calls with support for dependency injection.
- **UserManager**: Manages user preferences, such as language and authentication tokens.
- **AppState**: Ensures the app adapts to RTL or LTR layouts based on the selected language.

## Assumptions

1. **Backend API**: The application assumes the API adheres to the defined schema for movie lists and search results.
2. **User Preferences**: The user’s language preference is obtained from a shared `UserManager` instance.
3. **Error Handling**: Default fallback messages like "Unknown" are used for missing or malformed data from the API.
4. **Pagination**: Currently, the application fetches the first page of results only. Pagination can be implemented to fetch additional data as users scroll.

## Why Third-Party Libraries?

The project uses **SDWebImageSwiftUI** for handling image loading and caching. This library was chosen for its robust support for asynchronous image handling, efficient caching mechanisms, and seamless integration with SwiftUI. It simplifies image loading tasks that would otherwise require complex manual implementations.

## Enhancements

- **Pagination**: Future improvements can include paginated requests to load more data in the movie list.
- **Enhanced UI**: Advanced animations and improved UI/UX for search and detail views.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Erfandadras/SabaideaIosTask.git
   ```

2. Open the project in Xcode:

   ```bash
   cd SabaideaTask
   open SabaideaTask.xcodeproj
   ```

3. Build and run the project on the iOS Simulator or a physical device.

## Usage

1. Launch the app to see a list of popular movies on the home screen.
2. Use the search bar to find movies by title.
3. Tap on a movie to navigate to its detail page.
4. Pull down to refresh the movie list.

## Development Notes

- **Environment-Specific Setup**: The app uses a mock client (`MockMoviesNetworkClient`) during debugging and a real network client (`MoviesNetworkClient`) in production.
- **Keyboard Dismissal**: Scroll views automatically dismiss the keyboard when scrolling.
- **Error Messages**: Informative error messages are displayed when the network fails or no data is available.
- **Unit Testing**: Mocks can be utilized to test different states of the app without real API dependencies.

## Example Code

### MovieListView

This SwiftUI view displays a list of movies and manages navigation.

```swift
var body: some View {
    NavigationStack {
        ScrollViewReader { reader in
            ScrollView {
                if case .failure(let error) = viewModel.state {
                    Text(error.localizedDescription)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(.red)
                        .padding(.top, 1)
                } else if viewModel.state == .loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                LazyVStack {
                    ForEach(viewModel.uiModels) { item in
                        NavigationLink {
                            MovieDetailView(previewItem: item)
                        } label: {
                            MovieListItemView(data: item)
                                .background(.white)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .id(item.id)
                    }
                }
            }
            .scrollDismissesKeyboard(.automatic)
            .refreshable {
                viewModel.fetchData(refresh: true)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.automatic)
            .background(.white)
        }
    }
    .searchable(text: $viewModel.keyword, placement: .navigationBarDrawer, prompt: Text("Search"))
}
```

### MovieViewModel

Manages data fetching and search functionality.

```swift
func fetchData(refresh: Bool = false) {
    self.updateState(state: refresh ? .refresh : .loading)
    Task {
        do {
            let data = try await dataSource.fetchData()
            self.updateState(state: data.isEmpty ? .noData : .success)
            mainThread {
                self.uiModels = data
            }
        } catch {
            self.updateState(state: .failure(error: error))
        }
    }
}
```

### MovieDetailView

Displays detailed information about a specific movie, including its title, image, and description. Error handling and loading indicators are built-in.

```swift
var body: some View {
    VStack {
        if case .failure(let error) = viewModel.state {
            Text(error.localizedDescription)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(12)
                .background(.red)
                .padding(.top, 1)
        } else if viewModel.state == .loading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        }
        GeometryReader { reader in
            VStack {
                ImageViewBuilder(url: viewModel.uiModel?.imageUrl ?? previewItem.imageUrl)
                    .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    .padding(8)
                
                Text(viewModel.uiModel?.detail ?? previewItem.detail)
                    .font(.footnote)
                    .foregroundStyle(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
        }
    }
    Spacer()
    .background(.white)
    .navigationTitle(viewModel.uiModel?.title ?? previewItem.title)
    .navigationBarTitleDisplayMode(.inline)
}
```

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Contribution

Contributions are welcome! Please open an issue or submit a pull request to suggest changes or report bugs.

