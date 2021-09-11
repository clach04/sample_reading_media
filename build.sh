#!/bin/sh

echo about to generate test media
echo REQUIRES pandoc - known to work with version 2.7.3
echo REQUIRES zip/7z

# TODO hand crafted html
# TODO rtf
# TODO mobi
# TODO prc/pdb?
# TODO azw
# TODO azw3
# TODO CBZ/CBR/CBT/CB7
# TODO metadata
# compressed files

cp test_book.md test_book_md.md
cp test_book.md test_book_txt.txt

echo FIXME add -s for all textual formats e.g. html, fb2....
echo TODO add auto TOC generation when possible
pandoc -o test_book_html.html test_book.md

#pandoc -o test_book.rtf test_book.md   # does not generate correct rtf, missing head/template- https://github.com/jgm/pandoc/issues/857 TODO cross link to https://github.com/jgm/pandoc/issues/2140
pandoc -o test_book_rtf.rtf -s test_book.md
pandoc -o test_book_odt.odt test_book.md
pandoc -o test_book_docx.docx test_book.md

pandoc -o test_book_pdf.pdf --metadata title=test_book_pdf --pdf-engine wkhtmltopdf test_book.md

pandoc -o test_book_fb2.fb2 test_book.md
pandoc -o test_book_epub.epub --metadata title=test_book_epub test_book.md

#pandoc -o test_book.mobi test_book.md  # generates html!?

# Comics
#if [ ! -f "Elf Receiver Radio-Craft August 1936.cbz" ]
if [ ! -f Elf_Receiver_Radio-Craft_August_1936.cbz ]
then
    # From https://www.contrapositivediary.com/?p=1197
    wget "http://www.copperwood.com/pub/Elf%20Receiver%20Radio-Craft%20August%201936.cbz"  # download with original name
    mv "Elf Receiver Radio-Craft August 1936.cbz" Elf_Receiver_Radio-Craft_August_1936.cbz
fi


#which 7z || alias 7z=p7zi
# 7z takes different arguments to p7zip
myzip()
{
    echo myzip tool zip ${*}
    #7z a ${*}
    zip ${*}
}


myzip test_book_md_zip.zip test_book_md.md
myzip test_book_txt_zip.zip test_book_txt.txt
myzip test_book_rtf_zip.zip test_book_rtf.rtf
myzip test_book_html_zip.zip test_book_html.html
myzip test_book_fb2_zip.zip test_book_fb2.fb2

# generate release
myzip sample_reading_media.zip *.*

