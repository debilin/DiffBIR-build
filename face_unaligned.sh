#! /bin/bash

# for unaligned face inputs
python inference_face.py \
--input inputs/ \
--sr_scale 2 \
--output results/demo/face/whole_img \
--bg_upsampler DiffBIR \
--device cuda