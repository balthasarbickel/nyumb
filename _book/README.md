
Compilation via `bash build.sh` (web site only) or `bash build_all.sh` (includes PDF)

Test the site by firing up a local web server with `python -m http.server --cgi 8000` from within `_site` and then poimt your browser to `http://localhost:8000` (or whatever port number you used). Stop the server with `crtl+C`


Or from within the `_book` directory via

```
pandoc -f markdown -t markdown -i combined.md  -s --lua-filter convert_yaml.lua | sed -e 's/\-.*`\(.*\)` \(.*\)/\\\ingredient{\\1}\\{\\2\\}/g' | sed -e 's/------.*/\\\freeform\\\hrulefill/g'| pandoc --template=cuisine.latex --pdf-engine=xelatex -o book.pdf ; open book.pdf

```

What does not work is the Devanagri display in recipe titles. If I add `\D` (as defined with `xelatex::fontspec` in `cusine.latex`) to the markdown, it works well for PDF but inserts a literal `\D` in html. Easiest fix right now is to generate `.tex` and then to postprocess it by hand, adding `\D`.

Search via regex [ऄ-ॿ]+

Couldn't get this to work: https://tex.stackexchange.com/questions/394146/creating-bilingual-german-devanagari-hindi-sanskrit-pdf-using-markdown-pa
