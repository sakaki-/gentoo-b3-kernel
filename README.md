# gentoo-b3-kernel
Automated weekly build of the latest (~arm) gentoo-sources kernel for the Excito B3 miniserver 

## Description

<img src="https://raw.githubusercontent.com/sakaki-/resources/master/excito/b3/Excito_b3.jpg" alt="Excito B3" width="250px" align="right"/>

This project contains a weekly autobuild of the most recent testing (~arm) version of the [gentoo-sources](https://wiki.gentoo.org/wiki/Kernel/Overview#General_purpose:_gentoo-sources) Linux kernel, for the Excito B3 miniserver.

Builds are performed based on an `oldefconfig`-updated version of [this baseline configuration](https://github.com/sakaki-/gentoo-on-b3/blob/master/configs/b3_baseline_config). A new build tarball is automatically created and uploaded as a release asset each week (unless the most recent version has not changed since the prior week, or an error occurs during the build process).

Each kernel release tarball provides the following files:
* `/boot/zImage` (this is the bootable kernel);
* `/boot/kirkwood-b3.dtb` (the device tree blob);
* `/boot/config` (a copy of the kernel's configuration file);
* `/boot/System.map` (the kernel's symbol table);
* `/lib/modules/<kernel release name>/...` (the module set for the kernel);
* `/lib/firmware/...` (the kernel-built firmware).

The current kernel tarball may be downloaded from the link below (or via `wget`, or via the corresponding `gentoo-b3-kernel-bin` ebuild, per the [instructions following](#installation)):

Variant | Version | Most Recent Image
:--- | ---: | ---:
Kernel, DTB, modules and (kernel) firmware | 4.15.5 | [gentoo-b3-kernel-4.15.5.tar.xz](https://github.com/sakaki-/gentoo-b3-kernel/releases/download/4.15.5/gentoo-b3-kernel-4.15.5.tar.xz)

The corresponding kernel configuration (derived by running `make olddefconfig` on [this baseline configuration](https://github.com/sakaki-/gentoo-on-b3/blob/master/configs/b3_baseline_config)) may be viewed [here](https://github.com/sakaki-/gentoo-b3-kernel/blob/master/config).

> A list of all releases may be seen [here](https://github.com/sakaki-/gentoo-b3-kernel/releases).

## <a name="installation"></a>Installation

These binary kernels are most easily deployed via my [gentoo-b3](https://github.com/sakaki-/gentoo-b3-overlay) overlay (this overlay is pre-installed on the [gentoo-on-b3](https://github.com/sakaki-/gentoo-on-b3) image) - to do so, simply emerge the `gentoo-b3-kernel-bin` package (a new ebuild is automatically created to mirror each release here). For example, to install the latest available version (and start using it):
```console
b3 ~ # emaint sync --repo gentoo-b3
b3 ~ # emerge -av gentoo-b3-kernel-bin
b3 ~ # reboot
```

Or, to install a particular version (e.g.):
```console
b3 ~ # emaint sync --repo gentoo-b3
b3 ~ # emerge -av =gentoo-b3-kernel-bin-4.15.5
b3 ~ # reboot
```

Alternatively (assuming that your B3's boot partition is mounted as `/boot`), you can simply simply download the release file, untar it directly on your B3, and reboot:
```console
b3 ~ # wget -c https://github.com/sakaki-/gentoo-b3-kernel/releases/download/4.15.5/gentoo-b3-kernel-4.15.5.tar.xz
b3 ~ # tar -xJf gentoo-b3-kernel-4.15.5.tar.xz -C /
b3 ~ # sync && reboot
```

> NB: these prebuilt kernels and ebuilds are provided as a convenience only. Use at your own risk! **Given that the releases in this project are created automatically, there is no guarantee that any given kernel will boot correctly.**

> NB: You **must** be working with **>= version 2.0.0** of the [gentoo-on-b3](https://github.com/sakaki-/gentoo-on-b3) image to use these kernels (since they rely on the B3 first booting an interstitial kernel to patch and kexec them (with the correct command line, DTB file and possibly initramfs), and this facility was first introduced in version 2.0.0).
