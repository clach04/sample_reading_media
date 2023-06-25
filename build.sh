#!/bin/sh

set -e  # stop on first error

if [ "${1}" = "SKIP_COMICS" ]
then
    echo command line SKIP_COMICS
    SKIP_COMICS=true
fi

echo about to generate test media
echo 'REQUIRES pandoc - known to work with version 2.7.3 (issues with 1.19.2.4)'
echo pandoc check...
pandoc --version
echo REQUIRES zip
echo REQUIRES tar
echo REQUIRES 7z
echo REQUIRES rar

# TODO hand crafted html
# TODO hand crafted html with embedded images (of different formats; png, gif, jpg, svg, webp)
# TODO mobi
# TODO prc/pdb? https://github.com/clach04/pyrite-publisher
# TODO azw
# TODO azw3

echo Text formats
cp test_book.md test_book_md.md
cp test_book.md test_book_txt.txt

pandoc -o test_book_txt_lf_unix.txt --eol=lf test_book_md.md
pandoc -o test_book_txt_crlf_win.txt --eol=crlf test_book_md.md

echo HTML format
echo FIXME add -s for all textual formats e.g. html, fb2....
echo TODO add auto TOC generation when possible
pandoc -o test_book_html.html test_book.md

echo Microsoft doc related
#pandoc -o test_book.rtf test_book.md   # does not generate correct RTF (unlike other formats with Pandoc), missing head/template - see https://github.com/jgm/pandoc/issues/857 and  https://github.com/jgm/pandoc/issues/2140
pandoc -o test_book_rtf.rtf -s test_book.md
pandoc -o test_book_odt.odt test_book.md
pandoc -o test_book_docx.docx test_book.md

if [ -z "${SKIP_PDF}" ]
then
    echo PDF format
    pandoc -o test_book_pdf.pdf --metadata title=test_book_pdf --pdf-engine wkhtmltopdf test_book.md
    pandoc -o test_book_pdf_more_detail.pdf --pdf-engine wkhtmltopdf source_test_book_fb2.fb2
fi

echo ebook formats
pandoc -o test_book_fb2.fb2 test_book.md
pandoc -o test_book_epub.epub --metadata title=test_book_epub test_book.md
pandoc -o test_book_epub_more_detail.epub source_test_book_fb2.fb2

#pandoc -o test_book.mobi test_book.md  # generates html!?


# TODO rar
#which 7z || alias 7z=p7zi
myzip()
{
    echo myzip tool zip ${*}
    #zip ${*}
    #return

    # NOTE 7z defaults to creating 7z file if filename does not end in .ZIP
    # this function MUST create zip/pkzip files - if using 7z binary use .zip and then rename
    #7z a ${*}
    archive_name=${1}
    shift
    7z a ${archive_name}.zip ${*}
    mv ${archive_name}.zip ${archive_name}
}

myzip_uncompressed()
{
    echo myzip_uncompressed tool zip ${*}
    # do not use 7z if file name does not end in .ZIP
    # this function MUST create zip/pkzip files - is using 7z use .zip and then rename
    zip -0 ${*}
}

my7z()
{
    # 7z takes different arguments to p7zip
    7z a ${*}
}

my7z_uncompressed()
{
    # 7z takes different arguments to p7zip
    7z a -mx0 ${*}
}

myrar()
{
    # m<0..5>       Set compression level (0-store...3-default...5-maximal)
    rar a ${*}
}


myrar_uncompressed()
{
    rar a -m0 ${*}
}

echo ZIP compressed books
# TODO consider renaming to make easier for using with koreader - see https://github.com/koreader/koreader/issues/9986 and https://github.com/koreader/koreader/wiki/ZIP
# ensure zip is in the file name for tools that hide file extensions
# IDEA - test_book_md_zip.zip  -- test_book_md_zip.md.zip
# IDEA - test_book_txt_zip.zip  -- test_book_txt_zip.txt.zip

myzip test_book_md_zip.zip test_book_md.md
myzip test_book_txt_zip.zip test_book_txt.txt
myzip test_book_rtf_zip.zip test_book_rtf.rtf
myzip test_book_html_zip.zip test_book_html.html
myzip test_book_fb2_zip.zip test_book_fb2.fb2
myzip source_test_book_fb2_zip.fbz source_test_book_fb2.fb2
myzip source_test_book_fb2_dot_zip.fb2.zip source_test_book_fb2.fb2


# Comics
create_comics()
{
    base_comic_name=$1
    shift
    myzip ${base_comic_name}.cbz ${*}
    my7z ${base_comic_name}.cb7 ${*}
    myzip_uncompressed ${base_comic_name}_uncompressed.cbz ${*}
    my7z_uncompressed ${base_comic_name}_uncompressed.cb7 ${*}
    tar -cvf ${base_comic_name}.cbt ${*}
    myrar ${base_comic_name}.cbr ${*}
    myrar_uncompressed ${base_comic_name}_uncompressed.cbr ${*}
}

if [ -z "${SKIP_COMICS}" ]
then

    #if [ ! -f "Elf Receiver Radio-Craft August 1936.cbz" ]
    if [ ! -f Elf_Receiver_Radio-Craft_August_1936.cbz ]
    then
        # From https://www.contrapositivediary.com/?p=1197
        wget "http://www.copperwood.com/pub/Elf%20Receiver%20Radio-Craft%20August%201936.cbz"  # download with original name
        mv "Elf Receiver Radio-Craft August 1936.cbz" Elf_Receiver_Radio-Craft_August_1936.cbz
    fi



    # FIXME use create_comics instead
    myzip bobby_make_believe_sample_dir.cbz images/bobby_make_believe/Bobby-Make-Believe_1915__0.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__1.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__2.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__3.jpg
    my7z bobby_make_believe_sample_dir.cb7 images/bobby_make_believe/Bobby-Make-Believe_1915__0.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__1.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__2.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__3.jpg
    myzip_uncompressed bobby_make_believe_sample_dir_uncompressed.cbz images/bobby_make_believe/Bobby-Make-Believe_1915__0.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__1.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__2.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__3.jpg
    my7z_uncompressed bobby_make_believe_sample_dir_uncompressed.cb7 images/bobby_make_believe/Bobby-Make-Believe_1915__0.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__1.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__2.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__3.jpg
    tar -cvf bobby_make_believe_sample_dir.cbt images/bobby_make_believe/Bobby-Make-Believe_1915__0.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__1.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__2.jpg images/bobby_make_believe/Bobby-Make-Believe_1915__3.jpg

    create_comics mono_numbered_png_dir     images/mono_numbered_png/01.png images/mono_numbered_png/02.png images/mono_numbered_png/03.png images/mono_numbered_png/04.png images/mono_numbered_png/05.png images/mono_numbered_png/06.png images/mono_numbered_png/07.png images/mono_numbered_png/08.png images/mono_numbered_png/09.png images/mono_numbered_png/10.png

    cd images/bobby_make_believe/
    myzip ../../bobby_make_believe_sample.cbz Bobby-Make-Believe_1915__0.jpg Bobby-Make-Believe_1915__1.jpg Bobby-Make-Believe_1915__2.jpg Bobby-Make-Believe_1915__3.jpg
    my7z ../../bobby_make_believe_sample.cb7 Bobby-Make-Believe_1915__0.jpg Bobby-Make-Believe_1915__1.jpg Bobby-Make-Believe_1915__2.jpg Bobby-Make-Believe_1915__3.jpg
    myzip_uncompressed ../../bobby_make_believe_sample_uncompressed.cbz Bobby-Make-Believe_1915__0.jpg Bobby-Make-Believe_1915__1.jpg Bobby-Make-Believe_1915__2.jpg Bobby-Make-Believe_1915__3.jpg
    my7z_uncompressed ../../bobby_make_believe_sample_uncompressed.cb7 Bobby-Make-Believe_1915__0.jpg Bobby-Make-Believe_1915__1.jpg Bobby-Make-Believe_1915__2.jpg Bobby-Make-Believe_1915__3.jpg
    tar -cvf ../../bobby_make_believe_sample.cbt Bobby-Make-Believe_1915__0.jpg Bobby-Make-Believe_1915__1.jpg Bobby-Make-Believe_1915__2.jpg Bobby-Make-Believe_1915__3.jpg
    rar a -m0 ..\..\bobby_make_believe_sample.cbr Bobby-Make-Believe_1915__0.jpg Bobby-Make-Believe_1915__1.jpg Bobby-Make-Believe_1915__2.jpg Bobby-Make-Believe_1915__3.jpg
    cd ../..

    cd images/mono_numbered_png/
    create_comics ../../mono_numbered_png    01.png 02.png 03.png 04.png 05.png 06.png 07.png 08.png 09.png 10.png
    cd ../..

fi  # end of if not SKIP_COMICS

# generate release
#myzip sample_reading_media.zip *

