#!/bin/bash
sed -i "s/image-version/$1/gi" kube-deploy.yml
