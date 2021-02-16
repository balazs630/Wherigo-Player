<img src="https://i.imgur.com/olBaPWm.png" width="80px" />

# Wherigo-Player

Unofficial iOS client for the popular GPS game Wherigo‪®‬ Geocaching.
I started working on this iOS app when Groundspeak Inc. removed the old unmaintained Wherigo app from the App Store at the end of 2020, and there was a 2-month period where there was no option to play Wherigo games on iPhones and iPads.

Later in 2021 Groundspeak relesed a [shiny new Wherigo app](https://apps.apple.com/us/app/wherigo/id1538051913) that works/looks much better than the old one. It seems like a complete rewrite. Now I don't see an extra benefit of creating a third party app for the same purpose anymore bacause the official app is a very strong competitor.

Since I invested about a hundred hour in this project I'd like to open source this app which is capable to read cartridge files from Lua binary and even start the gameplay low level without UI.
I couldn't find any working open source iOS client to play Wherigo cartridges so it might be interesting to others.


## Dependencies
Uses the following projects:

* [openwig](https://github.com/cgeo/openwig) - Core business logic in Java
* [kahlua](https://github.com/krka/kahlua) - Lua virtual machine with standard library for J2ME
* [j2objc](https://github.com/google/j2objc) - Tool to translate Java source code to Objective-C (version 2.7)
* [WhereYouGo](https://github.com/cgeo/WhereYouGo) - Android app, I'm using a few Java file transcompiled to handle cartridge files


## Contributing
Please contact me if you're interested to work on this project.
If you found a bug, feel free to open an issue or even open a pull request to fix it.

Everyone is welcome to join.


## Done
- [x] Import cartridges from Files app
- [x] List screen to display imported items
- [x] Details screen to show the game's description, with all metadata


## Backlog
- [ ] UI to display nearby zones, player actions, inventory, etc...
- [ ] Saving game state when exiting
- [ ] Loading saved gameplay
- [ ] Onboarding for how to import a cartridge in the app
