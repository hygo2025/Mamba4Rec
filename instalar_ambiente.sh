#!/bin/bash


ENV_NAME="mamba_conda"

echo "--- Passo 1: A criar o ambiente Conda '$ENV_NAME'... ---"
conda create -n $ENV_NAME python=3.9 -y

if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao criar o ambiente Conda. A abortar."
    exit 1
fi

echo ""
echo "--- Passo 2: A instalar PyTorch, Torchvision, e Torchaudio com CUDA 11.8... ---"
conda run -n $ENV_NAME conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia -y

if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao instalar o PyTorch. A abortar."
    exit 1
fi

echo ""
echo "--- Passo 3: A instalar o NVIDIA CUDA Toolkit (para compilação)... ---"
conda run -n $ENV_NAME conda install -c nvidia cuda-toolkit -y

if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao instalar o CUDA Toolkit. A abortar."
    exit 1
fi

echo ""
echo "--- Passo 4: A instalar causal-conv1d via pip... ---"
conda run -n $ENV_NAME pip install "causal-conv1d>=1.4.0"

if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao instalar o causal-conv1d. Verifique os logs de erro."
    exit 1
fi

echo ""
echo "--- Instalação Concluída com Sucesso! ---"
echo "Para ativar o seu novo ambiente, execute:"
echo ""
echo "conda activate $ENV_NAME"
echo ""