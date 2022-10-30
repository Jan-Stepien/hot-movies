# Hot movies

Showcase the most popular movies according to [themoviedb](https://developers.themoviedb.org/3/search/search-movies) version 3.


<img width="383" alt="Screenshot 2022-10-30 at 22 26 51" src="https://user-images.githubusercontent.com/17708132/198902304-bae8fc25-8145-41e0-8716-dc93b2a6ed57.png">

## Getting Started 

This project requires themoviedb API key being provided at the build time of the app. To read how to get the key visit [themoviedb documentation](https://developers.themoviedb.org/3/getting-started/authentication).

To build the project run 

```sh
$ flutter run --dart-define MOVIES_API_KEY=<put your key here>
```

## Technical implementation

The project was written following the 4 layer structure of: service, repository, bloc and ui layer. Services and repositories were split into separate flutter packages to enable reusability and developer experience. Packages can be found in [packages directory](https://github.com/Jan-Stepien/hot-movies/tree/main/packages).

