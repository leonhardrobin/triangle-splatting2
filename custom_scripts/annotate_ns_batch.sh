#!/bin/bash

SCENES=("drums" "ficus" "hotdog" "materials" "mic" "ship" "lego" "chair")
SUB_DIR="nerf_synthetic"
# =================================================

echo "Starting batch annotation..."

for scene in "${SCENES[@]}"; do
    IMAGE="annotation_renders/${SUB_DIR}/${scene}/00000.png"

    echo "------------------------------------------------"
    echo "Starting annotation for: $scene"

    python annotate_points_boxes.py \
        "$IMAGE" \
        --scale 1
        
    echo "Finished annotation for $scene"
done

echo "------------------------------------------------"
echo "All scenes processed."