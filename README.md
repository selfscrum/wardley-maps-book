# Orginal Welcome
This is an Asciidoc book of Simon Wardley's "Wardley Maps". It simply takes all his [medium posts](https://medium.com/wardleymaps) and joins them together for ease of reading.  The intention is to be entirely faithful to the original posts - I've not even fixed the few spelling mistakes - while allowing various output versions to be generated, e.g. HTML, and .mobi for Kindle e-readers.  It is made available under the same Creative Commons Attribution-ShareAlike-4.0-International licence as the original posts. 

# Welcome to German Translation
* The German translation is the result of an automated translation with API services from deepl.com. No manual postprocessing has been done. Feel free to amend by creating merge requests to this repo.
* You find the script in the base directory, it is named translate.sh. Courtesy Martin Jahr (@selfscrum), Same Creative Commons Attribution-ShareAlike 4.0 International Public License applies as for the original text.
* To make the script work, you need to purchase a deepl API access and set the environment variable DEEPL_AUTH_KEY to the auth token provided to you by deepl. 
* Since deepl is paid by characters translated, the translation of the complete book is about 20 USD which I spent for you. If you want to donate: [Buy A Coffee](https://www.buymeacoffee.com/rfnlev) for our non-profit-organisation [Raum für natürliches Lernen](https://raum-fuer-natuerliches-lernen.de/en).
* If you feel alienated by the asciidoctor format, do the following after translation, which is completed irritatingly quick after the long wait for the translation ;)

```
sudo apt install pandoc
for i in $(ls -1 *.adoc.de) ; do
    asciidoctor -b docbook -a leveloffset=+1 -o - $i | pandoc  --atx-headers --wrap=preserve -t markdown_strict -f docbook - > $i.md
done
```

# Generating the book
All these generators require you to have installed [asciidoctor](https://asciidoctor.org/docs/user-manual/). Then select the command you require to generate the output you desire.

## HTML 
To generate the HTML version of this book, run the following command in the base directory of this repository:

    asciidoctor wardley-maps-book.adoc.de

## PDF
To generate the PDF version of this book, you additionally need to install [asciidoctor-pdf](https://asciidoctor.cn/docs/convert-asciidoc-to-pdf/) with the following command:

    gem install --pre asciidoctor-pdf

Then you can run the following command in the base directory of this repository:

    asciidoctor-pdf wardley-maps-book.adoc.de

## .MOBI (Kindle)
To generate the .mobi version of this book you additionally need to install [Asciidoctor-EPUB3](https://asciidoctor.org/docs/asciidoctor-epub3/) and [kindlegen](https://rubygems.org/gems/kindlegen/versions/3.0.3) both via  Ruby gems - the instructions are in the linked pages.  The pre-requisite to run both of these is Ruby. You can then run the following command in the base directory of this repository:

    asciidoctor-epub3 -a ebook-format=kf8 wardley-maps-book.adoc.de

# Contributing
Contributions are cool, and also very welcome.  There is a [code of conduct](CODE_OF_CONDUCT.md), and a [contribution guide](CONTRIBUTING.md) which you can familiarise yourself with if you want to get involved (even if its just fixing a typo).  They should be _very_ unsurprising to anyone used to the OSS world.

# To Do
* Fix xref rendering on .mobi (Kindle) file generation - it doesn't work
* Replace the formulae image in chapter 19 with the latex equivalent (https://github.com/asciidoctor/asciidoctor-latex)
* Change the type-setting so that paragraphs in the ```.mobi``` output aren't indented
* Add a Travis build
