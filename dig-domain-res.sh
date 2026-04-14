#!/bin/bash
for domain in qkvza.cn abvch.cn ogclz.cn bnrsr.cn hvtno.cn rboea.cn sydes.cn mepto.cn mlzbv.cn ewnhv.cn hfvck.cn zuioe.cn; do
  echo -n "$domain -> "
  dig +short A $domain
  dig +short NS $domain
  echo
done
