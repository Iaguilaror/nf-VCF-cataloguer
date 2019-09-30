#!/bin/bash

find -L . \
  -type f \
  -name "*.filtered.vcf" \
| sed "s#.vcf#.snv.vcf#" \
| xargs mk
