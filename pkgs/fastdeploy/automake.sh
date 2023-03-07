#!/usr/bin/env bash

cd FastDeploy/build
make clean
cmake .. -DENABLE_ORT_BACKEND=ON \
         -DENABLE_PADDLE_BACKEND=ON \
         -DENABLE_OPENVINO_BACKEND=OFF \
         -DCMAKE_INSTALL_PREFIX=${PWD}/compiled_fastdeploy_sdk \
         -DENABLE_VISION=ON \
         -DENABLE_TEXT=OFF \
         -DOPENCV_DIRECTORY=$OPENCV_PATH \
         -DORT_DIRECTORY=$ORT_PATH
make -j 12