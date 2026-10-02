# NVIDIA Container Toolkit
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
    | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.sources > /dev/null <<- EOH
Types: deb
URIs: https://nvidia.github.io/libnvidia-container/stable/deb/amd64/
Suites: /
Components:
Signed-By: /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
EOH

sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

# Configure Docker to use Nvidia driver
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# docker run -d --gpus=all -v "$HOME/.ollama:/root/.ollama" -p 11434:11434 --name nvim-llama ollama/ollama
