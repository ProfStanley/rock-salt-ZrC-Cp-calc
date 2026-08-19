#!/bin/bash
#SBATCH -J ZrC64
#SBATCH -e ZrC64.errors
#SBATCH -o ZrC64.output
#SBATCH -p normal
#SBATCH -t 0:20:00
#SBATCH -N 1
#SBATCH -n 68
#SBATCH --mail-user=stanleyc@uindy.edu
#SBATCH --mail-type=all
#SBATCH -A TG-PHY210117

cd /scratch/06209/tg855087
mkdir $SLURM_JOB_ID
cd $SLURM_JOB_ID

#if [ -f $SLURM_SUBMIT_DIR/ZrC64.DM ]
#  then cp $SLURM_SUBMIT_DIR/ZrC64.DM .
#fi

if [ -f $SLURM_SUBMIT_DIR/ZrC64.XV ]
  then cp $SLURM_SUBMIT_DIR/ZrC64.XV .
fi

if [ -f $SLURM_SUBMIT_DIR/ZrC64.ANI ]
  then cp $SLURM_SUBMIT_DIR/ZrC64.ANI .
fi

if [ -f $SLURM_SUBMIT_DIR/ZrC64.CG ]
  then cp $SLURM_SUBMIT_DIR/ZrC64.CG .
fi

if [ -f $SLURM_SUBMIT_DIR/temp.out ]
  then cp $SLURM_SUBMIT_DIR/temp.out .
fi

if [ -f $SLURM_SUBMIT_DIR/ZrC64.MD ]
  then cp $SLURM_SUBMIT_DIR/ZrC64.MD .
fi

if [ -f $SLURM_SUBMIT_DIR/ZrC64.VERLET_RESTART ]
  then cp $SLURM_SUBMIT_DIR/ZrC64.VERLET_RESTART .
fi

cp $SLURM_SUBMIT_DIR/ZrC64.fdf $SLURM_SUBMIT_DIR/*.vps ./.
cp $SLURM_SUBMIT_DIR/ZrC64.fdf $SLURM_SUBMIT_DIR/*.psf ./.

if [ -d $SLURM_SUBMIT_DIR/work_dir ]
  then rm $SLURM_SUBMIT_DIR/work_dir
fi

ln -f -s /scratch/06209/tg855087/$SLURM_JOB_ID $SLURM_SUBMIT_DIR/work_dir
touch ZrC64.out; ln -f -s /scratch/06209/tg855087/$SLURM_JOB_ID/ZrC64.out $SLURM_SUBMIT_DIR/temp.out
touch ZrC64.ANI; ln -f -s /scratch/06209/tg855087/$SLURM_JOB_ID/ZrC64.ANI $SLURM_SUBMIT_DIR/temp.ANI
touch CLOCK; ln -f -s /scratch/06209/tg855087/$SLURM_JOB_ID/CLOCK $SLURM_SUBMIT_DIR/CLOCK

ibrun siesta_4_1_b4_intel_19_1_1 < ZrC64.fdf > ZrC64.out

for var in `ls |grep ZrC64`;do cp $var $SLURM_SUBMIT_DIR;done

for var in `ls |grep ZrC64`;do cp $var $SLURM_SUBMIT_DIR;done

rm $SLURM_SUBMIT_DIR/CLOCK; cp -f CLOCK $SLURM_SUBMIT_DIR

rm $SLURM_SUBMIT_DIR/temp.out
rm $SLURM_SUBMIT_DIR/temp.ANI


