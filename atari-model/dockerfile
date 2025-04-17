# Use the specified NVIDIA CUDA image
FROM nvidia/cuda:12.6.2-cudnn-devel-ubuntu22.04

# Set the working directory
WORKDIR /app

# Install system dependencies including git
RUN apt-get update && \
    apt-get install -y swig cmake ffmpeg python3-opengl xvfb git && \
    apt-get install -y python3 python3-pip && \
    apt-get clean

# Install Python packages
RUN pip3 install git+https://github.com/DLR-RM/rl-baselines3-zoo && \
    pip3 install gymnasium[atari] && \
    pip3 install gymnasium[accept-rom-license] && \
    pip3 install pyvirtualdisplay && \
    pip3 install --upgrade matplotlib && \
    pip3 install matplotlib-inline && \
    pip3 install opencv-python

# Set up a volume for live updates
VOLUME ["/app"]

# Start an interactive terminal, run the app script, and keep the shell open
CMD ["bash", "-c", "python3 app.py && python3 -m rl_zoo3.train --algo dqn --env SpaceInvadersNoFrameskip-v4 -f logs/ -c dqn.yml; exec bash"]