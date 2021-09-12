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

pandoc -o test_book_txt_lf_unix.txt --eol=lf test_book_md.md
pandoc -o test_book_txt_crlf_win.txt --eol=crlf test_book_md.md


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
pandoc -o test_book_epub_more_detail.epub source_test_book_fb2.fb2
pandoc -o test_book_pdf_more_detail.pdf --pdf-engine wkhtmltopdf source_test_book_fb2.fb2

#pandoc -o test_book.mobi test_book.md  # generates html!?

# Comics
#if [ ! -f "Elf Receiver Radio-Craft August 1936.cbz" ]
if [ ! -f Elf_Receiver_Radio-Craft_August_1936.cbz ]
then
    # From https://www.contrapositivediary.com/?p=1197
    wget "http://www.copperwood.com/pub/Elf%20Receiver%20Radio-Craft%20August%201936.cbz"  # download with original name
    mv "Elf Receiver Radio-Craft August 1936.cbz" Elf_Receiver_Radio-Craft_August_1936.cbz
fi



# TODO no compression
#which 7z || alias 7z=p7zi
# 7z takes different arguments to p7zip
myzip()
{
    echo myzip tool zip ${*}
    #7z a ${*}
    zip ${*}
}

my7z()
{
    7z a ${*}
}


myzip bobby_make_believe_sample_dir.cbz images/bobby_make_believe/Bobby-Make-Believe_1915__0.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__1.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__2.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__3.jpg
my7z bobby_make_believe_sample_dir.cb7 images/bobby_make_believe/Bobby-Make-Believe_1915__0.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__1.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__2.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__3.jpg
tar -cvf bobby_make_believe_sample_dir.cbt images/bobby_make_believe/Bobby-Make-Believe_1915__0.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__1.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__2.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__3.jpg

cd images/bobby_make_believe/
myzip ../../bobby_make_believe_sample.cbz Bobby-Make-Believe_1915__0.jpg Bobby-Make-Believe_1915__1.jpg Bobby-Make-Believe_1915__2.jpg Bobby-Make-Believe_1915__3.jpg
my7z ../../bobby_make_believe_sample.cb7 Bobby-Make-Believe_1915__0.jpg Bobby-Make-Believe_1915__1.jpg Bobby-Make-Believe_1915__2.jpg Bobby-Make-Believe_1915__3.jpg
tar -cvf ../../bobby_make_believe_sample.cbt Bobby-Make-Believe_1915__0.jpg Bobby-Make-Believe_1915__1.jpg Bobby-Make-Believe_1915__2.jpg Bobby-Make-Believe_1915__3.jpg
rar a -m0 ..\..\bobby_make_believe_sample.cbr Bobby-Make-Believe_1915__0.jpg Bobby-Make-Believe_1915__1.jpg Bobby-Make-Believe_1915__2.jpg Bobby-Make-Believe_1915__3.jpg
cd ../..

myzip test_book_md_zip.zip test_book_md.md
myzip test_book_txt_zip.zip test_book_txt.txt
myzip test_book_rtf_zip.zip test_book_rtf.rtf
myzip test_book_html_zip.zip test_book_html.html
myzip test_book_fb2_zip.zip test_book_fb2.fb2
myzip source_test_book_fb2_zip.fbz source_test_book_fb2.fb2
myzip source_test_book_fb2_dot_zip.fb2.zip source_test_book_fb2.fb2

# generate release
#myzip sample_reading_media.zip *.*

