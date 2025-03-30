# Installation methods

Note: the CLI requires to have [hping](https://www.hping.org) installed. See the package for your distro on [repology](https://repology.org/project/hping/versions). ChronoLeak will look for the `hping3` command to be accessible in your PATH.

## Production

### rubygems.org (universal)

```bash
gem install chronoleak
```

Gem: [chronoleak](https://rubygems.org/gems/chronoleak)

### BlackArch

From the repository:

```bash
pacman -S chronoleak
```

PKGBUILD: [chronoleak](https://github.com/BlackArch/blackarch/blob/master/packages/chronoleak/PKGBUILD)

### **ArchLinux**

Manually:

```bash
git clone https://aur.archlinux.org/chronoleak.git
cd chronoleak
makepkg -sic
```

With an AUR helper ([Pacman wrappers](https://wiki.archlinux.org/index.php/AUR_helpers#Pacman_wrappers)), eg. yay:

```bash
yay -S chronoleak
```

AUR: [chronoleak](https://aur.archlinux.org/packages/chronoleak/)

## Development

It's better to use [ASDM-VM](https://asdf-vm.com/) to have latests version of ruby and to avoid trashing your system ruby.

### rubygems.org

```bash
gem install --development chronoleak
```

### **git**

Just replace `x.x.x` with the gem version you see after `gem build`.

```bash
git clone https://github.com/noraj/chronoleak.git chronoleak
cd chronoleak
gem install bundler
bundler install
gem build chronoleak.gemspec
gem install chronoleak-x.x.x.gem
```

Note: if an automatic install is needed you can get the version with `$ gem build chronoleak.gemspec | grep Version | cut -d' ' -f4`.

### **No install**

Run the library in irb without installing the gem.

From local file:

```bash
irb -Ilib -rchronoleak
```

Same for the CLI tool:

```bash
ruby -Ilib -rchronoleak bin/chronoleak
```

