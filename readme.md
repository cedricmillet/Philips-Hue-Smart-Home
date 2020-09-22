[![N|Solid](https://upload.wikimedia.org/wikipedia/en/a/a1/Philips_hue_logo.png)](https://nodesource.com/products/nsolid)

# Hue Smart Home Controller

* develop : [![Build Status](https://travis-ci.com/cedricmillet/Philips-Hue-Smart-Home.svg?branch=develop)](https://travis-ci.com/cedricmillet/Philips-Hue-Smart-Home)
* master : [![Build Status](https://travis-ci.com/cedricmillet/Philips-Hue-Smart-Home.svg?branch=master)](https://travis-ci.com/cedricmillet/Philips-Hue-Smart-Home)

A little library written in Dart, in order to manipulate sensors & lights states of Philips Hue family.

* [Official Philips Hue documentation](https://developers.meethue.com/)

## Commands
* `git pub` retreive package dependencies
* `dart main.dart` run library example
* `dartdoc` generate package documentation
* `pub test test/path/mytest.dart` run specific unit test

## TO DO LIST
* Se pencher sur la duree devie des username
* Implementer la remote API
* Implementer toutes les methodes de Light, Sensors...

## Dependencies
* __http__ : send/receive data from philips hue bridge device on local network
* __test__ : unit testing...