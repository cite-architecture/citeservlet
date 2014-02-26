# citeservlet #

The CITE services suite implemented using a SPARQL endpoint for source data


## Requirements ##

- a running SPARQL endpoint with your data
- gradle: <http://www.gradle.org/>


## Basic usage ##

The primary purpose of `citeservlet` is to support the two generic tasks:

- `gradle war` to build a `.war` file
- `gradle jettyRunWar` to run the `.war` file in an embedded jetty container

## Configuration ##``

1. Make a copy of each of `conf.gradle` and `links.gradle`.
2. Edit your copied files with appropriate values for your project.
3. Use the `-P` flag to specify your config files when you run a task.

Example:

       gradle -Pconf=myconf.gradle -Plinks=mylinks.gradle jettyRunWar


## Customizing the generic `citeservlet` ##

See the README.md file in the `customize` directory.
