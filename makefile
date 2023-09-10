#include .env

# ID = ""  # set ID as an option
WORK_DIR = ./work
SOURCE = $(ID)
MAIN = $(WORK_DIR)/main.tex
HTML_DIR = ./docs/$(ID)
HTML = $(HTML_DIR)/index.html
HTML_JA = $(HTML_DIR)/index_ja.html

all: download decompress html clean

download:
	echo "Downloading"
	wget --user-agent="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" https://arxiv.org/e-print/$(ID)

decompress:
	echo "Decompressing"
	mkdir -p $(WORK_DIR)
	tar -xvf $(SOURCE) -C $(WORK_DIR)

html: $(WORK_DIR)
	echo "Generating HTML"
	docker run --rm -v `pwd`:/docdir -w /docdir --user `id -u`:`id -g` latexml/ar5ivist --source=`ls -S $(WORK_DIR)/*.tex | head -n 1` --destination=$(HTML)

clean:
	echo "Cleaning"
	rm -rf $(WORK_DIR)/*
	mv $(SOURCE) ./sources/
