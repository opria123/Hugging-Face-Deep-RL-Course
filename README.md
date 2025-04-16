# RL Baselines3 Zoo with Docker

This project utilizes the RL Baselines3 Zoo to train reinforcement learning agents using the Atari environment. The setup is containerized using Docker for easy deployment and reproducibility.

## Prerequisites

- Docker installed on your machine.
- NVIDIA GPU with the appropriate drivers installed (for GPU support).

## Docker Setup

### Dockerfile

The Dockerfile is configured to use the NVIDIA CUDA image and includes all necessary dependencies for running the RL Baselines3 Zoo.

```dockerfile
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
```

### Build the Docker Image

To build the Docker image, navigate to the directory containing the Dockerfile and run the following command:

```bash
docker build -t atari-train .
```

### Run the Docker Container

To run the Docker container with GPU support and an interactive terminal, use the following command:

```bash
docker run --gpus all -it -v "${PWD}:/app" atari-train
```

### Container Behavior

When the container starts, it will:
1. Run the `app.py` script to set up the virtual display.
2. Execute the training command for the DQN algorithm on the `SpaceInvadersNoFrameskip-v4` environment.
3. Keep the terminal open after the training command completes, allowing you to run additional commands interactively.

## Important Files

- **Dockerfile**: Contains the instructions to build the Docker image.
- **app.py**: Initializes the virtual display for running the Atari environment.

## Additional Information

- The following Python packages are installed in the Docker image:
  - `rl-baselines3-zoo`: For training reinforcement learning agents.
  - `gymnasium[atari]`: For the Atari environments.
  - `pyvirtualdisplay`: To create a virtual display for rendering.
  - `matplotlib`: For plotting and visualization.
  - `opencv-python`: For image processing.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
