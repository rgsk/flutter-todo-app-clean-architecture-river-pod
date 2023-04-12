## tutorial followed

[https://www.youtube.com/watch?v=WvGHJef7O-g](https://www.youtube.com/watch?v=WvGHJef7O-g)

this app demonstrates the use of riverpod package to manage global state.

## instructions to run app

there are certain scripts contained in pubspec.yaml file

```yml
scripts:
  build: flutter pub run build_runner build --delete-conflicting-outputs
  watch: flutter pub run build_runner watch
```

these scripts help create compiled files, for that we need to install flutter_scripts globally
`dart pub global activate flutter_scripts`
then run
`export PATH="$PATH":"$HOME/.pub-cache/bin"`
to ensure flutter_scripts is available in the terminal
`flutter_scripts run` will allow us to choose the script to run, currently pubspec.yaml file contains 2, build and watch, build is used for compiling once and watch to keep watching and compiling, (note: watch doesn't works perfectly)

to ignore the compiled files (so that they are not visible in the vscode editor) we provided following config to .vscode/lanch.json

```json
{
  "files.exclude": {
    "**/*.freezed.dart": true,
    "**/*.g.dart": true
  }
}
```
