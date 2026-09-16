# Licensing

- The snapcraft.yaml, CI workflows and docs in this repo: Apache-2.0.
- The snap content ships binary packages fetched at build time from the
  Qualcomm IoT PPA (`qcom-fastrpc1`, `qcom-libdmabufheap`) and the
  `qairt-dsp-binaries` DSP tree. Those retain their upstream licenses
  (Qualcomm proprietary / Ubuntu main components such as libgomp1 under
  GPL-3.0-runtime). Distributing them inside a snap follows the same terms as
  distributing the debs; see each deb's copyright file.
- `skels/libggml-htp-v*.so` are llama.cpp build artifacts, MIT licensed.
