build_dir = ./build

all: exsheet sheetthms sheetdiagrams breakoutthms mathbreakout math

math: src/math/bsteffan-math.sty
	@mkdir -p $(build_dir)/math
	@cp $< $(build_dir)/math

sheetthms: src/sheet/bsteffan-sheetthms.sty
	@mkdir -p $(build_dir)/sheet
	@cp $< $(build_dir)/sheet

sheetdiagrams: src/sheet/bsteffan-sheetdiagrams.sty
	@mkdir -p $(build_dir)/sheet
	@cp $< $(build_dir)/sheet

exsheet: src/sheet/bsteffan-exsheet.cls sheetthms sheetdiagrams math
	@mkdir -p $(build_dir)/sheet
	@cp $< $(build_dir)/sheet

breakoutthms: src/breakout/bsteffan-breakoutthms.sty
	@mkdir -p $(build_dir)/breakout
	@cp $< $(build_dir)/breakout

mathbreakout: src/breakout/bsteffan-mathbreakout.cls math
	@mkdir -p $(build_dir)/breakout
	@cp $< $(build_dir)/breakout

clean:
	@rm -rf $(build_dir)

.PHONY: all clean exsheet sheetthms sheetdiagrams breakoutthms mathbreakout math
