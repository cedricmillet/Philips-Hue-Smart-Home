[![N|Solid](https://upload.wikimedia.org/wikipedia/en/a/a1/Philips_hue_logo.png)](https://nodesource.com/products/nsolid)

# Hue Smart Home Controller ![link](https://img.shields.io/static/v1?label=version&message=v0.0.1&color=blue)

|  branch |   status |
|---|---|
|  develop |  [![Build Status](https://travis-ci.com/cedricmillet/Philips-Hue-Smart-Home.svg?branch=develop)](https://travis-ci.com/cedricmillet/Philips-Hue-Smart-Home) |
|  master |  [![Build Status](https://travis-ci.com/cedricmillet/Philips-Hue-Smart-Home.svg?branch=master)](https://travis-ci.com/cedricmillet/Philips-Hue-Smart-Home) |

A little library written in Dart, in order to manipulate sensors & lights states of Philips Hue family.

* [Official Philips Hue documentation](https://developers.meethue.com/)

## Commands
* `git pub` retreive package dependencies
* `dart examples/sample.dart` run library example
* `dartdoc` generate package documentation
* `pub run test` run unit tests


## Dependencies
* __http__ : send/receive data from philips hue bridge device on local network
* __test__ : unit testing...

## UML

@startuml firstDiagram

Alice -> Bob: Hello
Bob -> Alice: Hi!

@enduml