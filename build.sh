echo about to generate test media
echo requires
echo    pandoc - known to work with version 2.7.3
echo    7z

cp test_book.md test_book.txt

pandoc -o test_book.html test_book.md

#pandoc -o test_book.rtf test_book.md   # does not generate correct rtf
pandoc -o test_book.odt test_book.md
pandoc -o test_book.docx test_book.md

pandoc -o test_book.fb2 test_book.md
pandoc -o test_book.epub --metadata title=test_book_epub test_book.md

7z a test_book_md.zip test_book.md
7z a test_book_txt.zip test_book.txt
