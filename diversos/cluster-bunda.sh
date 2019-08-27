# Copyright (C) 2019 Alcides Goldoni Junior <agoldonijr@gmail.com>
# Copyright (C) 2019 Alcides Goldoni Junior <goldoni@ggaunicamp.com>

# Esse script foi feito com ajuda do Ian Liu Rodrigues
# https://github.com/ianliu


#!/bin/bash
#PBS -l nodes=1:ppn=2
#PBS -N cluster-bunda
#PBS -o out.out
#PBS -e out.err

. /opt/torque/etc/openmpi-setup.sh
cd $PBS_O_WORKDIR

mpirun bash -l -c 'hostname; date'
