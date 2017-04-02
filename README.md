# IPTV FOR TVOS

Quick little project to play live tv on my Apple TV. The existing apps on the app store were all lacking and paid.

The project makes use of [TVVLCKit](https://github.com/PopcornTimeTV/TVVLCKit) for a higher support rate.

## Configuration
This project uses  [CocoaPods](http://cocoapods.org/). Build instructions:
``` bash
$ git clone https://github.com/PopcornTimeTV/PopcornTimeTV.git
$ cd PopcornTimeTV/
$ pod repo update; pod install
$ open PopcornTime.xcworkspace
```
All what is left to do is specify the IPTV playlist url. Create a constants.swift which is git ignored (because the url is secret) and compile.

In a later stage the playlist URL can be saved within the app itself.

## Screenshots
