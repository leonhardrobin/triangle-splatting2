#!/bin/bash

DATA_ROOT="/nfs/lschnaitl/projects/nerf_synthetic"
SCENES=("drums" "ficus" "hotdog" "materials" "mic" "ship" "lego" "chair")
SUB_DIR="nerf_synthetic"

echo "Starting batch rendering..."

for scene in "${SCENES[@]}"; do
    SOURCE_PATH="${DATA_ROOT}/${scene}"
    MODEL_OUTPUT="output/${SUB_DIR}/${scene}"

    echo "------------------------------------------------"
    echo "Starting rendering for: $scene"
    echo "  Model Path: $MODEL_OUTPUT"

    python render.py \
        -m "$MODEL_OUTPUT"
    
    echo "Finished processing $scene"
done

echo "------------------------------------------------"
echo "All scenes processed."