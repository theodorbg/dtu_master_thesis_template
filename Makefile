# Makefile for deployment used on G-Bar's Gitlab platform
#
# All graphics are supplied by AUS and are automatically downloaded and
# converted to PDF. This Makefile performs the PDF conversion for WMF and EPS
# files.
#
# As of this writing, the file naming scheme is as follows:
# - `department_xx-YY' for department logos
# - `R_department_xx-YY' for department logos with extended information
# - `friser/department' for friezes (background design for slides etc.)
# - `DTU_xx-YY'
#
# xx-YY specifies available locales e.g. en-GB for english and da-DK for danish.
#
# Contact at AUS: Thomas Hjort Jensen <thhj@adm.dtu.dk>

# Graphics paths
resources_path := tex/latex/dturesources

department_logo_path := $(resources_path)/department_logo
department_name_logo_path := $(resources_path)/department_name_logo
background_path := $(resources_path)/background
frieze_path := $(resources_path)/frieze
logo_path := $(resources_path)/logo


# Global variables
.DEFAULT_GOAL := build

# WMF_FILES := $(shell curl -l ftp://$(FTP_USER):$(FTP_PASSWORD)@$(FTP_PATH)/ \
#                      | grep wmf \
#                      | grep -v brugesikke)

# Department logos
# DEPARTMENT_LOGO_WMF_FILES := $(filter-out R_% Logo%, $(WMF_FILES))
# DEPARTMENT_LOGO_SVG_FILES := $(DEPARTMENT_LOGO_WMF_FILES:.wmf=.svg)
# DEPARTMENT_LOGO_PDF_FILES := $(DEPARTMENT_LOGO_WMF_FILES:.wmf=.pdf)


# $(DEPARTMENT_LOGO_WMF_FILES):
# 	wget ftp://$(FTP_USER):$(FTP_PASSWORD)@$(FTP_PATH)/$@

# $(DEPARTMENT_LOGO_SVG_FILES): $(DEPARTMENT_LOGO_WMF_FILES)
# 	wmf2svg -o $@ $(@:.svg=.wmf)

# $(DEPARTMENT_LOGO_PDF_FILES): $(DEPARTMENT_LOGO_SVG_FILES)
# 	svg2pdf $(@:.pdf=.svg) $(addprefix $(department_logo_path)/, $@)

# department_logo: $(DEPARTMENT_LOGO_PDF_FILES)
# 	@echo "Downloaded and converted department logos"


# # Department logos with name
# DEPARTMENT_NAME_LOGO_WMF_FILES := $(filter-out R_Logo%, $(filter R_%, $(WMF_FILES)))
# DEPARTMENT_NAME_LOGO_SVG_FILES := $(DEPARTMENT_NAME_LOGO_WMF_FILES:.wmf=.svg)
# DEPARTMENT_NAME_LOGO_PDF_FILES := $(DEPARTMENT_NAME_LOGO_WMF_FILES:.wmf=.pdf)

# $(DEPARTMENT_NAME_LOGO_WMF_FILES):
# 	wget ftp://$(FTP_USER):$(FTP_PASSWORD)@$(FTP_PATH)/$@

# $(DEPARTMENT_NAME_LOGO_SVG_FILES): $(DEPARTMENT_NAME_LOGO_WMF_FILES)
# 	wmf2svg -o $@ $(@:.svg=.wmf)

# $(DEPARTMENT_NAME_LOGO_PDF_FILES): $(DEPARTMENT_NAME_LOGO_SVG_FILES)
# 	$(eval output_file = $(shell echo $@ \
# 	                             | sed 's/R_//g'))
# 	svg2pdf $(@:.pdf=.svg) $(addprefix $(department_name_logo_path)/, $(output_file))

# department_name_logo: $(DEPARTMENT_NAME_LOGO_PDF_FILES)
# 	@echo "Downloaded and converted department name logos"


# # Frieze
# FRIEZE_EPS_FILES := \
#              $(shell curl -l ftp://$(FTP_USER):$(FTP_PASSWORD)@$(FTP_PATH)/friser/ \
#                      | sed 's/ /_/g')
# FRIEZE_PDF_FILES := $(FRIEZE_EPS_FILES:.eps=.pdf)

# $(FRIEZE_EPS_FILES):
# 	$(eval input_file = $(shell echo $@ \
# 	                            | sed 's/_/ /g'))
# 	wget ftp://$(FTP_USER):$(FTP_PASSWORD)@$(FTP_PATH)/friser/$(input_file) \
#                -O $@

# $(FRIEZE_PDF_FILES): $(FRIEZE_EPS_FILES)
# 	$(eval output_file = $(shell echo $@ \
#                                      | sed 's/_\(\.eps\)/\1/g' \
#                                      | sed 's/\([^-]*\)_-_\(DTU\)/\2_\1/g' \
#                                      | sed 's/DTU_//g' \
# 	                             | sed 's/æ/ae/g' \
# 	                             | sed 's/ø/oe/g' \
# 	                             | sed 's/å/aa/g'))
# 	epstopdf $(@:.pdf=.eps) $(addprefix $(frieze_path)/, $(output_file))

# frieze: $(FRIEZE_PDF_FILES)
# 	@echo "Downloaded and converted friezes"


# # Download dtu logos etc and convert eps files to pdf
# build: department_logo department_name_logo frieze
# 	@echo "Build complete"

# INKSCAPE = inkscape-0.91
# compile_inkscape:
# 	wget 'https://inkscape.org/en/gallery/item/3854/$(INKSCAPE).tar.gz'
# 	mkdir -p inkscape
# 	tar zxf $(INKSCAPE).tar.gz
# 	cd $(INKSCAPE) && ./configure && make

build:
	git submodule update --init uniconvertor
	cd uniconvertor && python setup.py build
	@echo "Build complete"


# Assert the existence of the PDF files from the build process exist before
# continuing to the deploy script
test:


# .PHONY: build department_logo department_name_logo frieze
# .INTERMEDIATE: $(DEPARTMENT_LOGO_WMF_FILES) $(DEPARTMENT_LOGO_SVG_FILES) \
#                $(DEPARTMENT_NAME_LOGO_WMF_FILES) $(DEPARTMENT_NAME_LOGO_SVG_FILES) \
#                $(FRIEZE_EPS_FILES)
