library("testthat")
library("animint2")
library("RSelenium");library("XML")
setwd("testthat")
source("helper-functions.R")
source("helper-HTML.R")
source("helper-plot-data.r")

## RSelenium does not work with all versions of firefox, TDH usually
## tests using one of the following.

## thocking@silene:~/R/animint-mine(fix-common-chunk)$ firefox --version
## Mozilla Firefox 11.0
## thocking@silene:~/R/animint(animation-fix)$ java -jar ~/lib/R/library/RSelenium/bin/selenium-server-standalone.jar --version
## 10:10:58.942 INFO - Launching a standalone server
## 10:10:58.973 INFO - Java: Sun Microsystems Inc. 23.25-b01
## 10:10:58.973 INFO - OS: Linux 3.8.0-44-generic amd64
## 10:10:58.987 INFO - v2.44.0, with Core v2.44.0. Built from revision 76d78cf
## > packageVersion("RSelenium")
## [1] ‘1.3.6’

## > packageVersion("RSelenium")
## [1] ‘1.3.5’
## tdhock@recycled:~/R/animint(roc-bugfix)$ firefox --version
## Mozilla Firefox 41.0
## tdhock@recycled:~/R/animint(roc-bugfix*)$ java -jar ~/lib/R/library/RSelenium/bin/selenium-server-standalone.jar --version
## 08:13:17.803 INFO - Launching a standalone Selenium Server
## 08:13:17.877 INFO - Java: Oracle Corporation 24.79-b02
## 08:13:17.877 INFO - OS: Linux 3.13.0-65-generic i386
## 08:13:17.907 INFO - v2.47.0, with Core v2.47.0. Built from revision 0e4837e

filter <- Sys.getenv("TEST_SUITE")
# If we're running in github actions then use Firefox, since we can
# use the Selenium docker image instead of relying on PhantomJS.
gh.action <- Sys.getenv("GH_ACTION")
dont.need.browser <- grepl("compiler", filter)
use.browser <- !dont.need.browser
if(filter == ""){
  filter <- NULL
}
message(gh.action)
if(gh.action == "ENABLED"){
  tests_init("chrome")
}else if(interactive()) {
  tests_init("firefox")
} else {
  tests_init()
}

tests_run(filter=filter)
tests_exit()
