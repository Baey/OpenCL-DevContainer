#!/bin/bash

# Instalacja Docker Engine
# Krok 1: Dodanie repozytorium Docker do apt
echo "Dodawanie repozytorium Docker..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Krok 2: Instalacja niezbędnych paczek
echo "Instalacja Docker Engine..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Krok 3: Weryfikacja działania Docker Engine po instalacji
echo "Weryfikacja instalacji Docker Engine..."
sudo docker run hello-world

# Instalacja NVIDIA Container Toolkit
# Krok 1: Dodanie repozytorium NVIDIA Container Toolkit do apt
echo "Dodawanie repozytorium NVIDIA Container Toolkit..."
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Krok 2: Aktualizacja repozytorium i instalacja paczek
echo "Instalacja NVIDIA Container Toolkit..."
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

# Krok 3: Konfiguracja Docker
echo "Konfiguracja Docker z NVIDIA Container Toolkit..."
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# Krok 4: Umożliwienie działania Dockera bez uprawnień root'a
echo "Konfiguracja Docker dla użytkowników bez uprawnień root'a..."
sudo nvidia-ctk runtime configure --runtime=docker --config=$HOME/.config/docker/daemon.json
systemctl --user restart docker
sudo nvidia-ctk config --set nvidia-container-cli.no-cgroups --in-place

# Krok 5: Weryfikacja instalacji NVIDIA Container Toolkit
echo "Weryfikacja instalacji NVIDIA Container Toolkit..."
sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi

echo "Instalacja zakończona pomyślnie!"
