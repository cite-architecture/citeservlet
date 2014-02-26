# Customizing your installation of `citeservlet` #

The build tasks to construct (`gradle war`) or run a war file (`gradle jettyRunWar`) add everything in the "customize" directory the generic `citeservlet` installation.  It overwrites any items with the same names, so one way you can easily modify or replace generic versions of `citeservlet`'s pages is to copy the file from `src/main/webapp` to `customize`, and edit the `customize` copy.

Some obvious possibilities include putting a replacement home page or project-specific CSS in `customize`, but you have full control over the servlet:  you can add a copy of `WEB-INF/web.xml`  to define new servlets, URL mappings, etc.

## Running `citeservlet` installations for multiple projects ##

The directory with your customizations is by default the `customize` directory, but it is defined by the gradle project property `custom`, so you can run your servlet with different customizations either by changing the `custom` property in your local copy of `conf.gradle`, or by setting it on the command line, e.g.,


       gradle -Pcustom=/PATH/TO/YOUR/CUSTOMIZATIONS jettyRunWar

