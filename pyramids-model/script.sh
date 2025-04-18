
git clone --depth 1 https://github.com/Unity-Technologies/ml-agents

pip3 install -e ./ml-agents/ml-agents-envs
pip3 install -e ./ml-agents/ml-agents

mkdir ./training-envs-executables
mkdir ./training-envs-executables/linux

wget wget "https://huggingface.co/spaces/unity/ML-Agents-Pyramids/resolve/main/Pyramids.zip" -O ./training-envs-executables/linux/Pyramids.zip

unzip -d ./training-envs-executables/linux/ ./training-envs-executables/linux/Pyramids.zip

chmod -R 755 ./training-envs-executables/linux/Pyramids/Pyramids

huggingface-cli login --token <token> --add-to-git-credential
git config --global credential.helper store

mlagents-learn ./config/ppo/PyramidsRND.yaml --env=./training-envs-executables/linux/Pyramids/Pyramids --run-id="Pyramids-Training" --no-graphics
mlagents-push-to-hf  --run-id=opria123/ppo-Pyramids  --local-dir=./results/Pyramids-Training --commit-message=train
