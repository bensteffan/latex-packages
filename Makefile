build_dir = ./build

all: exsheet math

exsheet: src/sheet/bsteffan-exsheet.cls
	@mkdir -p $(build_dir)/sheet
	@cp $< $(build_dir)/sheet

math : src/math/bsteffan-math.sty
	@mkdir -p $(build_dir)/math
	@cp $< $(build_dir)/math

clean:
	@rm -rf $(build_dir)

.PHONY: all clean exsheet math
