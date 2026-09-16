.PHONY: build clean distclean

build:
	snapcraft pack --output qcom-htp-runtime_arm64.snap

clean:
	snapcraft clean
	rm -f qcom-htp-runtime_arm64.snap

distclean: clean
	rm -rf debs/*.deb
