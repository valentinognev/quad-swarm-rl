python -m sample_factory.launcher.run \
--run=swarm_rl.runs.obstacles.pbt_quads_multi_obstacles \
--backend=slurm --slurm_workdir=slurm_output \
--experiment_suffix=slurm --pause_between=1 \
--device=cpu \
--slurm_sbatch_template=/home/zhehui/slurm/restart-swarm-rl_sbatch_timeout.sh \
--slurm_print_only=False