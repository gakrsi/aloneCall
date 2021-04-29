# Flutter Project
A flutter application.

Important Links:

* [Node APIs Documentaion](Insert Link Here)

* [Python APIs Documentation](Insert Link Here)

* [Trello Link](Insert Link Here)

* [UI Link](Insert Link Here)

## Made with

Flutter and Dart. Learn more about flutter from there official [doc](https://flutter.dev/),
for dart from this [link](https://dart.de/).

## Architecture

We have used GetX pattern to make the controllers and view work together. They are placed in the same root folder to reduce the time for searching the business logic file.
To learn more or understand the architecture can go through this [link](https://github.com/kauemurakami/getx_pattern).

To make the development even more faster can use [get_cli](https://pub.dev/packages/get_cli) to create projects and add modules and all.
We are not using that here because there are some changes required and we are using lint rules to make the code development as precise as possible even if multiple developers are working on it at once.

## File Structure

Check this [link](https://github.com/kauemurakami/getx_pattern) to understand the file structure and how to add different files at what position.

```yaml
- /app
    - /data
        - /service
        - /provider
        - /model
        - /repository
    - /modules
    - /global_widgets
    - /routes
    - /theme
    - /utils
- /assets
  - /img
  - /fonts
- main.dart
```

The above shows the structure used in the application.
For maintaining the code structure we have used analyzer which provides different rules
which should to be followed. To know about different lint rules and the ones which are used in
the project can go through this [link](https://dart-lang.github.io/linter/lints/index.html).
We have used lint to maintain the code format thought out the project.

## Cloning

For cloning there are few steps which needs to be followed so that there will be no issue while
running the project. After downloading the project few command needs to be run from the terminal.

NOTE: You can use single line for running all the command at once. Copy
`flutter clean & flutter pub get & flutter packages pub run build_runner build --delete-conflicting-outputs & flutter analyze & flutter pub run flutter_launcher_icons:main`
this and press enter.

1. `flutter clean`
2. `flutter pub get`
3. `flutter packages pub run build_runner build --delete-conflicting-outputs`
4. `flutter analyze`
5. `flutter pub run flutter_launcher_icons:main`

These command will first clean the project. And the flutter pub get will install the packages used
in each module. We need to run the build runner since we have to generate the
files for model classes and for the retrofit for api calls. It might give error sometimes if there
are any conflicts then at that time can use
`flutter packages pub run build_runner build --delete-conflicting-outputs` this command to
delete the conflicting files and generating new one. There are other options also provide by
`build_runner`, can check it [here](https://dart.dev/tools/build_runner).

Things to do after cloning if its a main branch for the project:

1. Need to create JKS file.
2. Add the JKS details in the `key.properties` file.
3. Update the `google_services.json` file.
4. In .github folder create a workflow for the main branch and add the actions for uploading the build on firebase/test flight.
5. In README.md file update the details of the project. Replace the `Flutter Project` with the project name and in the details add the XD link if provided.

Things to do after cloning:

1. Need to add the branch name in .github/workflows/main.yml

After making the changes push the code and wait for the GitHub actions to gets completed to know if all the changes made are correct or not.

## Links

There are other links also a flutter dev can go through to learn few things extra or about some other libraries used in the project.

* https://github.com/Solido/awesome-flutter

* https://stuff.greger.io/2019/07/production-quality-flutter-starter-app.html

* https://medium.com/flutter-community/intl-flutter-starter-kit-18415e739fb6

* https://flutter.dev/docs/deployment/cd

* https://dart.dev/guides/language/effective-dart

* https://github.com/ReactiveX/rxdart

* https://pub.dev/packages/bloc

* https://bloclibrary.dev/#/

* https://pub.dev/packages/bloc

* https://medium.com/agileops/flutter-boilerplate-for-newbie-2dd558f8b524

* https://github.com/acelords/flutter-starter-kit

* https://github.com/Solido/awesome-flutter

* https://pub.dev/packages/retrofit

* https://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b

* https://pub.dev/packages/get

* https://medium.com/flutter-community/mastering-hero-animations-in-flutter-bc07e1bea327

* [Learn about hero animation](https://www.woolha.com/tutorials/flutter-creating-hero-transition-examples)

* https://pub.dev/packages/chewie

* https://pub.dev/packages/flutter_vlc_player

* https://flutterappworld.com/pixel-perfect-svg-unicons-for-flutter/

* https://blog.codemagic.io/getting-started-with-codemagic/

* https://flutterappworld-com.cdn.ampproject.org/c/s/flutterappworld.com/a-flutter-package-to-make-and-use-beautiful-color-scheme-based-themes/amp/

* https://github.com/kauemurakami/getx_pattern

## Code Documenation

A code with good documentaion can help other developers to undestand the code much more faster.
So it would be better to follow the dart official documentaion style provide by them. Can go
thorugh this [link](https://dart.dev/guides/language/effective-dart). For better documentation. Its not necessary to
add comment for each and every line. Since in flutter we divide the code in different files some
times the name doesn't actually clarify what does the file/class/methods/variable does. So if
required the docmentation must be added.
