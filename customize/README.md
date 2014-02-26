# Customizing your installation of `citeservlet` #

The build tasks to construct (`gradle war`) or run a war file (`gradle jettyRunWar`) add everything in the "customize" directory the generic `citeservlet` installation.  It overwrites any items with the same names, so one way you can easily modify or replace generic versions of `citeservlet`'s pages is to copy the file from `src/main/webapp` to `customize`, and edit the `customize` copy.
