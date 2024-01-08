# Convert Markdown (resume.md) to DOCX and PDF
# prerequisites(Mac): pandoc, basictex

RESUME = resume.md
OUTPUT_DIR = output

all: docx pdf

docx:
	@mkdir -p $(OUTPUT_DIR)
	pandoc $(RESUME) -o $(OUTPUT_DIR)/NikhilRavi_CV-$(BRANCH_NAME).docx \
		--lua-filter filter.lua \
		-M private=$(PRIVATIZE)

pdf:
	@mkdir -p $(OUTPUT_DIR)
	pandoc $(RESUME) -o $(OUTPUT_DIR)/NikhilRavi_CV-$(BRANCH_NAME).pdf \
		--pdf-engine=xelatex \
		--variable geometry:margin=0.5in \
		--variable fontsize=8pt \
		--variable documentclass=scrartcl \
		--variable classoption=twoside \
		--variable classoption=a4paper \
		--variable lang=en \
		--variable toc-depth=2 \
		--variable toc-own-page=true \
		--variable indent=true \
		--pdf-engine-opt=--shell-escape \
		--lua-filter filter.lua \
		-V colorlinks=true \
		-V linkcolor=blue \
		-V urlcolor=blue \
		-V toccolor=gray \
		-M privatize=$(PRIVATIZE)

clean:
	rm -rf $(OUTPUT_DIR)

.PHONY: all docx pdf clean