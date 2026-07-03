# cpu-governor

The ArxOS **CPU and kernel governor**. A tiny C tool that moves the CPU governor,
turbo/boost, energy preference **and** kernel tunables together as one profile, so
performance and idle behaviour are governed from a single place.

`v0.0.1` · C · one small binary, no runtime

## Profiles

| Command | What it does |
|---|---|
| `performance` | performance governor, turbo on, idle states off, aggressive kernel tunables (low swappiness, THP always) |
| `balanced` | **ArxOS default** - schedutil (falls back to ondemand/conservative), turbo on, idle states on, balanced kernel tunables |
| `powersave` | powersave governor, turbo off, power-biased energy + kernel tunables |
| `status` | current governor, vendor, turbo, frequency range and per-core frequencies |
| `install` | build + install system-wide, optionally enabling a boot service |

```bash
sudo ./install.sh            # builds cpu-governor.c with gcc, installs to /usr/local/bin
sudo cpu-governor balanced   # the ArxOS default profile
cpu-governor status          # inspect, no root needed
```

## Kernel + patch governance

Each profile ends by governing kernel-level knobs (swappiness, nmi_watchdog, dirty
ratios, transparent hugepages) and then applies any matching profile file:

```
/etc/arxos/kernel.d/<profile>.conf     # sysctl-format, applied after the built-ins
```

This is the hook the custom **linux-arxos** kernel and its patch/optimization
profiles plug into: drop a performance.conf / balanced.conf / powersave.conf there
and it is applied whenever that profile is selected, so kernel patches and
whole-stack idle tuning are governed alongside the CPU. Portable by design - knobs
that do not exist on a given kernel or in a VM are skipped silently.

---

Part of **ArxOS**.
