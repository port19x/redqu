# Maintainer: port19 <port19 at port19 dot xyz>
pkgname='redqu'
pkgver=1.1
pkgrel=1
pkgdesc='A media centric reddit client'
arch=('any')
url='https://github.com/port19x/redqu'
license=('Unlicense')
depends=('gawk')
#FIXME source=("${pkgname}-${pkgver}.tar.gz::https://github.com/port19x/redqu/archive/refs/tags/v${pkgver}.tar.gz")
#FIXME sha256sums=('0781cf624224398ff5f0298575ef959225cb66bf0cf3f17d0d2dc65b77052961')
package() {
    cd "$srcdir/$pkgname-$pkgver"
    install -Dm755 "./redqu" "$pkgdir/usr/bin/redqu"
}
