# Use a recent NGC image compatible with DGX A100 (Ampere)
# Contains PyTorch ~2.4, CUDA 12.6, Python 3.10+
FROM nvcr.io/nvidia/pytorch:24.09-py3

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies required for OpenCV and compilation
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    cmake \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Copy requirements file (we will create a filtered version below)
# We remove torch/torchvision from requirements because NGC provides optimized versions
COPY requirements.txt .

# Modify requirements to exclude torch/torchvision/cuda specific lines 
# that might conflict with the container's environment
RUN sed -i '/torch/d' requirements.txt && \
    sed -i '/mmcv/d' requirements.txt && \
    sed -i '/mmengine/d' requirements.txt

# Install python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install missing specific dependencies manually to ensure compatibility
# mmcv and mmengine often need specific build flags, installing via mim is safer usually, 
# but pip is fine if versions align. 
RUN pip install mmengine "mmcv>=2.0.0"

# Fix for potential git safety errors when mounting volumes
RUN git config --global --add safe.directory '*'

# Set entrypoint to bash
CMD ["/bin/bash"]