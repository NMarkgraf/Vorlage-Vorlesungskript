#! /bin/sh
grep -o "library(.*)" Inhalte/*.Rmd | \
    sort | uniq | \
    awk 'BEGIN{FS=":|\\(|\\)"; 
         print "\"mosaic\", \"1.7.0\""
         print "\"rmarkdown\", \"2.1\""
         print "\"tinytex\", \"0.23\""
         print "\"knitr\", \"1.28\""
         print "\"futile.logger\", \"0\""
    } {
        x = $2
        if ($2 == "library") {
            x = $3
        }
        if (x != "XXX") {
            print "\"" x "\", \"0\""
        }
      }' |\
    awk 'BEGIN{print "packages, minrelease"} {print $0} ' |\
    sort -r | awk '!a[$1]++' | sort -r
