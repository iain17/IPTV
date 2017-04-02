# IPTV FOR TVOS

Quick little project to play tv on my Apple TV. Using VLC as a player because of the stupid AVPlayerViewController uses DHCP and doesn't play in all cases.

## Configuration

This project uses  [CocoaPods](http://cocoapods.org/). Build instructions:

``` bash
$ git clone https://github.com/PopcornTimeTV/PopcornTimeTV.git
$ cd PopcornTimeTV/
$ pod repo update; pod install
$ open PopcornTime.xcworkspace
```

All what is left to do is specify the IPTV playlist url. Create a constants.swift which is git ignored (because the url is secret) and compile.
