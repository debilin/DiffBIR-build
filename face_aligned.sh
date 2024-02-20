#! /bin/bash

# for aligned face inputs
python inference_face.py \
--input inputs/ \
--sr_scale 1 \
--output results/demo/face/aligned \
--has_aligned \
--device cuda