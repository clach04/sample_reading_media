# sample reading media

  * [Overview](#overview)
  * [Applications to read sample media](#applications-to-read-sample-media)
  * [Build setup](#build-setup)
  * [Other media samples](#other-media-samples)
    + [ebooks](#ebooks)
    + [Comics](#comics)
    + [Images](#images)
    + [Videos](#videos)
  * [TODO](#todo)


## Overview

Super small, sample ebooks that are representative samples of book formats (and content).

Pre-built files ready for download available from https://github.com/clach04/sample_reading_media/releases/

Test sample ebooks, etc. Formats:

  * test_book.md
  * test_book_md.md
  * test_book_txt.txt
  * test_book_txt_crlf_win.txt
  * test_book_txt_lf_unix.txt
  * test_book_html.html
  * test_book_odt.odt
  * test_book_docx.docx
  * test_book_pdf.pdf
  * test_book_fb2.fb2
  * test_book_epub.epub
  * test_book_md_zip.zip
  * test_book_txt_zip.zip
  * test_book_html_zip.zip
  * test_book_fb2_zip.zip
  * test_book_rtf.rtf
  * test_book_rtf_zip.zip

All the above sample books are generated from [test_book.md](./test_book.md).

  * source_test_book_fb2.fb2
  * source_test_book_fb2_zip.fbz
  * source_test_book_fb2_dot_zip.fb2.zip
  * test_book_epub_more_detail.epub
  * test_book_pdf_more_detail.pdf

LGPL license, so feel free to use in/with your projects. If you modify them, share your changes.

Test sample comics, Formats:

  * bobby_make_believe_sample.cb7
  * bobby_make_believe_sample.cbt
  * bobby_make_believe_sample.cbz
  * bobby_make_believe_sample.cbr
  * bobby_make_believe_sample_dir.cb7
  * bobby_make_believe_sample_dir.cbt
  * bobby_make_believe_sample_dir.cbz

Images in comics typically in root directory of archive (see `bobby_make_believe_sample`). `bobby_make_believe_sample_dir` sample have images in a sub-directory.

For other Comic book samples, see [Comics](#comics).

[bobby_make_believe images](images/bobby_make_believe) are in the Public Domain and are the first 4 four pages of "Bobby Make-Believe (1915)" from https://comicbookplus.com/?dlid=26481 - 4 pages to reduce file size whilst being realistic content.

## Applications to read sample media

See:

  * https://github.com/clach04/dir2opds/wiki
  * https://github.com/clach04/dir2opds/wiki/Tested-Clients

## Build setup

    # Assuming Debian based
    sudo apt install pandoc
    sudo apt install wkhtmltopdf  # for pdf support
    sudo apt install xvfb  # *might* be needed for wkhtmltopdf
    sudo apt install wget  # for extra cbz comic
    sudo apt install p7zip-full  # for cb7 comic (also default for zip and CBZ)
    sudo apt install zip  # optional, can be used instead of 7z
    sudo apt install rar  # for cbr comic

Alternative/minimal build:

    env SKIP_COMICS=true env SKIP_PDF=true env SKIP_PANDOC_EOL=true ./build.sh

Issue build:

    ./build.sh

If wkhtmltopdf needs a display (not an issue under Microsoft Windows builds of Pandoc) can either try and use a diffrent PDF engine for pandoc or use Xvfb, for example:

    Xvfb :1 &
    env  DISPLAY=:1 ./build.sh
    # killall Xvfb

### Windows Build

Sample Windows build with 7-zip and MSYS2

    path %PATH%;C:\msys32_32bit\usr\bin\
    path %PATH%;C:\Program Files\7-Zip\

    C:\msys32_32bit\usr\bin\bash.exe build.sh SKIP_COMICS

    C:\msys32_32bit\usr\bin\bash.exe

    env SKIP_COMICS=true sh build.sh


## Other media samples

### ebooks

  * https://github.com/koreader/test-data
  * ebook (epub, mobi and azw3 formats) https://github.com/regueiro/spring-reference-ebook

### Comics

  * [Bobby Make-Believe (1915)](https://comicbookplus.com/?dlid=26481)
  * Comics (images) https://digitalcomicmuseum.com/index.php?cid=74
  * https://www.contrapositivediary.com/?p=1197
      * http://www.copperwood.com/pub/Elf%20Receiver%20Radio-Craft%20August%201936.cbz

### Images

  * Images https://github.com/recurser/exif-orientation-examples
  * Images https://sourceforge.net/p/exiftool/code/ci/master/tree/t/images/

### Videos

  * Video https://github.com/joshuatz/video-test-file-links


## TODO

  * add images (e.g. to html, embedded and linked, epub, new md file with images etc.) SpaceX images supposed to be PD https://www.flickr.com/photos/spacex/ (see https://99designs.com/blog/resources/public-domain-image-resources/)
  * fb2 with title page/images
  * TOC for epub `pandoc -o OUTPUTNAME.epub INPUTNAME.md --toc --toc-depth=2 --epub-cover-image=COVERIMAGE.png`
  * regular epub (done)
  * epub - stored (no-compression)
  * epub - maximum compression
  * hand crafted html (e.g. include metadata)
  * mobi
  * prc/pdb? - https://github.com/clach04/pyrite-publisher
  * azw
  * azw3
  * add comics
      * with PNG images (done)
      * 24-bit, 8-bit grayscale, indexed (e.g. 4 colors), and a transparency test
      * epub with images only
      * No compression (done)
      * with multiple sub-directories
  * metadata for formats that support it
      * mobi
      * azw/azw3
      * Comic metadata; zip comment or a ComicInfo.xml - see
          * https://github.com/dickloraine/EmbedComicMetadata
          * https://github.com/comictagger/comictagger
          * https://code.google.com/archive/p/comicbookinfo/ (wiki)
          * https://wiki.mobileread.com/wiki/CBR_and_CBZ#Metadata
  * Names of ZIP files suitable for KoReader - depending on discoveries in https://github.com/koreader/koreader/issues/9986 (done)
