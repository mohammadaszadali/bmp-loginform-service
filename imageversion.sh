#!/bin/bash
sudo sed -i "s/image_version/$1/gi" kube-deploy.yml
