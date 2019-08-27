#!/bin/bash
#PBS -l nodes=1:ppn=2
#PBS -N cluster-bunda
#PBS -o out.out
#PBS -e out.err

. /opt/torque/etc/openmpi-setup.sh
cd $PBS_O_WORKDIR

mpirun bash -l -c 'hostname; date'
