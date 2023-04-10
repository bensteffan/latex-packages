build_dir = ./build

all: exsheet sheetthms sheetdiagrams math

sheetthms: src/sheet/bsteffan-sheetthms.sty
	@mkdir -p $(build_dir)/sheet
	@cp $< $(build_dir)/sheet

sheetdiagrams: src/sheet/bsteffan-sheetdiagrams.sty
	@mkdir -p $(build_dir)/sheet
	@cp $< $(build_dir)/sheet

exsheet: src/sheet/bsteffan-exsheet.cls sheetthms sheetdiagrams
	@mkdir -p $(build_dir)/sheet
	@cp $< $(build_dir)/sheet

math: src/math/bsteffan-math.sty
	@mkdir -p $(build_dir)/math
	@cp $< $(build_dir)/math

clean:
	@rm -rf $(build_dir)

.PHONY: all clean exsheet sheetthms sheetdiagrams math
