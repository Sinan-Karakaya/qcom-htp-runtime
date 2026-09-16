# qcom-htp-runtime

Qualcomm Hexagon HTP runtime provider snap for inference snaps.

Implements the `inference-npu-runtime-qcom-htp-v1` content contract:
inference snaps (e.g. [gemma4](https://github.com/canonical/gemma4-snap)) with
the experimental `qualcomm-htp` engine consume this snap to get the proprietary
Qualcomm FastRPC userspace, which cannot be bundled inside a strict-confinement
model snap.

## Contents

- **FastRPC userland** — `libcdsprpc.so` (incl. the unversioned dlopen
  symlink), `libadsprpc.so`, CDSP/ADSP default listeners, FastRPC daemons.
  Sourced at build time from the public
  [ubuntu-qcom-iot/qcom-ppa](https://launchpad.net/~ubuntu-qcom-iot/+archive/ubuntu/qcom-ppa).
- **DSP configuration tree** — `/usr/share/qcom` for QCS8300 and QCM6490
  platforms (CDSP/ADSP/GDSP shells, skels, mapping files), from
  `qairt-dsp-binaries`. The provider owns the `/usr/share/qcom` layout bind;
  consumer snaps must not bind the same path.
- **HTP DSP skeletons** — `libggml-htp-v68..v81.so`, one per Hexagon version,
  loaded by name via `ADSP_LIBRARY_PATH` at FastRPC session open. Built by
  [canonical/llama.cpp-builds](https://github.com/canonical/llama.cpp-builds)
  (hexagon artifact). Without the matching skel (v73 on QCS8275, v73 on X
  Elite) session open fails with error 114.

## Usage (consumer side, e.g. gemma4)

```bash
sudo snap install qcom-htp-runtime
sudo snap connect gemma4:inference-npu-runtime-qcom-htp \
  qcom-htp-runtime:inference-npu-runtime-qcom-htp
```

## Validation

Device-validated on a Dragonwing RB4 (QCS8275, Hexagon v73) via Testflinger:
`HTP0` enumerated via FastRPC, `/dev/fastrpc-cdsp` and `/dev/dma_heap/system`
held open by the serving process, real Gemma 4 E2B Q4_0 completions
(~10–22 tok/s).

## CI

`ci.yaml` builds the snap on arm64 for every push/PR (debs fetched from the
public PPA, or pinned ones from `debs/`), and publishes to the `edge` channel
on push to main. Publishing requires the `qcom-htp-runtime` store name to be
registered and a `STORE_LOGIN` secret in the repo environment.

## Maintainers

Intended to be handed to / co-maintained with the Qualcomm squad. Currently
maintained by Sinan KARAKAYA <sinan.karakaya@canonical.com>.
