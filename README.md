# StarWars App
The Star Wars Repository is a meticulously crafted application, developed using the Flutter framework, designed to serve as a comprehensive repository of information pertaining to the renowned Star Wars franchise. This meticulously curated repository offers users a detailed exploration of key elements within the Star Wars universe, including individuals, vehicles, starships, and cinematic productions. The data comes from https://swapi.py4e.com/
## Features
- **Read Data from API**
- **Store Films to Local Storage**
- **Read Films from Local Storage**
- **Update Films Rank from Local Storage**
# Screenshots
![home_vehicles](https://github.com/jwspdev/starwars/assets/63495554/66ea4195-3019-4bfd-898a-6fe4c83b5e30)
![home_starship](https://github.com/jwspdev/starwars/assets/63495554/4fabb478-522b-4d32-9738-02737fa82f02)
![home_people](https://github.com/jwspdev/starwars/assets/63495554/1f5e3041-2545-467e-958a-6a01786681d2)
..MORE IMAGES WILL COME...
## Architecture
- **Presentation**: Contains the user interface and presentation logic. Uses >flutter_bloc for managing state and >go_router for navigation.
- **Domain**: Contains the core business logic (repository and entities) and use cases. It is independent of any external frameworks or libraries.
- **Data**: Contains the implementation of data sources and repositories. Uses >retrofit and >dio for HTTP networking solutions, and >floor as the local database solution.
## Major Libraries Used
* [get_it](https://pub.dev/packages/get_it): Utilized for dependency injection, allowing for the efficient management and retrieval of app dependencies throughout the codebase.
* [bloc](https://pub.dev/packages/bloc): Employed for state management, facilitating the separation of business logic from UI components and enabling a scalable and maintanable architecture.
* [flutter_bloc](https://pub.dev/packages/flutter_bloc): Used as an extension for the Bloc library specifically for Flutter, providing additional functionalities and streamlining the implementation of Bloc-based architecture.
* [go_router](https://pub.dev/packages/go_router): Implemented for navigation management within the app, offering a declarative and type-safe routing solution for efficient navigation between screens
* [floor](https://pub.dev/packages/floor): Object-relation mapping (ORM) library for Flutter and Dart.
* [retrofit](https://pub.dev/packages/retrofit): Type conversion dio client generator.
* [dio](https://pub.dev/packages/dio): Http Networking package.

## Getting Started
To get started with the starwars, you'll need to have Flutter installed on your machine. If you haven't already, you can follow the instructions on the [official Flutter website](https://docs.flutter.dev/get-started/install) to install Flutter.
Once Flutter is installed, follow these steps to run the Magic App:

1. **Clone the repository:**
```bash
git clone starwars
```
2. **Install Dependencies:**
```bash
flutter pub get
```
3. **Run the App:**
```bash
flutter run
```
## ISSUES:
- The images uploaded comes from my personal cloud storage because the data from https://swapi.py4e.com/ doesn't contain images.
  It is very unoptimal as what I did is to add image urls to each model, validate if the imageurl doesn't produce any error, then saves the image url for the models.
  THIS IS FOR SHOWING WHAT THE APP WILL LOOK LIKE IF IMAGES ARE PRESENT.
  MODIFICATIONS WILL BE MADE. HEHE 
