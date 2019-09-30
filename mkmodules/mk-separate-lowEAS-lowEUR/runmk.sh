#!/bin/bash

find -L . \
  -type f \
  -name "*.vcf" \
| sed "s#.vcf#.SEPARATE_LOWEAS_LOWEUR#" \
| xargs mk
