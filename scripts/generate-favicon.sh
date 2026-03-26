#!/usr/bin/env bash
set -e

# Genera favicon.ico a partir de img/logo.svg usando ImageMagick
# Producción de múltiples tamaños y combinación en un único .ico

SRC="img/logo.svg"
OUT="favicon.ico"

if [ ! -f "$SRC" ]; then
  echo "Error: no se encontró $SRC"
  exit 2
fi

if command -v magick >/dev/null 2>&1; then
  CONVERT="magick convert"
elif command -v convert >/dev/null 2>&1; then
  CONVERT="convert"
else
  echo "Error: ImageMagick no está instalado. Instala 'imagemagick' y vuelve a intentarlo."
  exit 3
fi

# Crear PNGs intermedios
$CONVERT -background none -resize 64x64 "$SRC" favicon-64.png
$CONVERT -background none -resize 32x32 "$SRC" favicon-32.png
$CONVERT -background none -resize 16x16 "$SRC" favicon-16.png

# Combinar en favicon.ico
$CONVERT favicon-16.png favicon-32.png favicon-64.png "$OUT"

# Limpiar
rm -f favicon-16.png favicon-32.png favicon-64.png

echo "Generado: $OUT"
