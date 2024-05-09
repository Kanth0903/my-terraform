#!/bin/bash
sudo amazon-linux-extras install docker -y
sudo systemctl start docker
sudo usermod -aG docker ec2-user