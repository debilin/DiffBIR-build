#! /bin/bash

randstr=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)
project=diffbir
containerid=$project-build-$randstr
imageid=$project-build-$(id -u)

(set -xe; docker build --progress=plain -t $imageid .)

set -xe

docker run -it --rm --gpus all \
    --name $containerid \
    -v "$PWD/ckpt:/DiffBIR/weights" \
    -v "$PWD/output:/DiffBIR/results" \
    -v "$PWD/input:/DiffBIR/inputs" \
    $imageid

#current_script=$( dirname "$(readlink -f "$0")" )
#podman cp $containerid:/dist $current_script
#podman rm $containerid

#(set -xe; podman build --target docker -t $project .)

#podman run -it --rm \
#    --name $project-$randstr \
#    $project